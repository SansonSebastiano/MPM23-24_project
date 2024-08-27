import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/model/ad_model.dart';
import 'package:room_finder/provider/firebase_providers.dart';

/// List of fields for ads' documents
const String _hostUidField = 'hostUid';
const String _nameField = 'name';
const String _rentersCapacityField = 'rentersCapacity';
const String _monthlyRentField = 'monthlyRent';
const String _servicesField = 'services';
const String _addressSubcolletionName = 'address';
const String _roomsSubcolletionName = 'rooms';
const String _rentersSubcollectionName = 'renters';
const String _adsCollectionName = 'ads'; 
const String _photosAdsRef = "photos/ads"; 

/// This class allow to handle the 'users' collection in Firestore
/// 
/// [_adCollection] refers to corresponding collection in Firestore
/// 
/// [_adRef] refers to path on Storage to access ad photos
class AdDataSource {
  final CollectionReference _adCollection;
  final Reference _adRef;

  AdDataSource(this._adCollection, this._adRef);

  Future<Either<String, AdData>> getAd({required String adUid}) async {
    try {
      final docSnap = await _adCollection.doc(adUid).get();
      
      // Fetch address subcollection
      final addressSnap = await docSnap.reference.collection(_addressSubcolletionName).get();
      final address = Address(
        street: addressSnap.docs.first['street'],
        city: addressSnap.docs.first['city'],
      );

      // Fetch rooms subcollection
      final roomsSnap = await docSnap.reference.collection(_roomsSubcolletionName).get();
      final List<Room> rooms = roomsSnap.docs.map((roomDoc) {
        final roomData = roomDoc.data();
        if (roomData.containsKey('numBeds')) {
          return Bedroom(
            name: roomData['name'],
            quantity: roomData['quantity'],
            numBeds: List<int>.from(roomData['numBeds']),
          );
        } else {
          return Room(
            name: roomData['name'],
            quantity: roomData['quantity'],
          );
        }
      }).toList();

      // Fetch renters subcollection
      final rentersSnap = await docSnap.reference.collection(_rentersSubcollectionName).get();
      final List<Renter> renters = rentersSnap.docs.map((renterDoc) {
        final renterData = renterDoc.data();
        return Renter(
          name: renterData['name'],
          age: renterData['age'],
          facultyOfStudies: renterData['facultyOfStudies'],
          interests: renterData['interests'],
          contractDeadline: DateTime.parse(renterData['contractDeadline']),
        );
      }).toList();

      // Fetch services field
      final services = List<String>.from(docSnap[_servicesField] ?? []);

      // Fetch photos from Firebase Storage
      final adPhotos = await _adRef.child(adUid).listAll();
      final List<String> adPhotosURLs = await Future.wait(
        adPhotos.items.map((item) => item.getDownloadURL())
      );

      // Return the populated AdData object
      return right(AdData(
        uid: adUid,
        hostUid: docSnap[_hostUidField],
        name: docSnap[_nameField],
        address: address,
        rooms: rooms,
        rentersCapacity: docSnap[_rentersCapacityField],
        renters: renters,
        services: services,
        monthlyRent: docSnap[_monthlyRentField],
        photosURLs: adPhotosURLs,
      ));
    } on FirebaseException catch (e) {
      return left(e.message ?? "Failed to get the ad data");
    }
  }

  Future<void> addNewAd({
    required String hostUid,
    required String name,
    required Address address,
    required List<Room> rooms,
    required int rentersCapacity,
    required List<Renter> renters,
    required List<String> services,
    required int monthlyRent,
    required List<File> photosPaths
  }) async {
    try {
      // 1. Add standard fields
      DocumentReference adDocRef = await _adCollection.add({
        _hostUidField: hostUid,
        _nameField: name,
        _rentersCapacityField: rentersCapacity,
        _monthlyRentField: monthlyRent,
        _servicesField: services, 
      });

      // 2. Add sub-collections
      await adDocRef.collection(_addressSubcolletionName).add({
        'street': address.street,
        'city': address.city,
      });

      for (Room room in rooms) {
        final roomData = {
          'name': room.name,
          'quantity': room.quantity,
        };

        // If the room is a Bedroom add the [numBeds] parameter
        if (room is Bedroom) {
          roomData['numBeds'] = room.numBeds;
        }

        await adDocRef.collection(_roomsSubcolletionName).add(roomData);
      }

      for (Renter renter in renters) {
        await adDocRef.collection(_rentersSubcollectionName).add({
          'name': renter.name,
          'age': renter.age,
          'facultyOfStudies': renter.facultyOfStudies,
          'interests': renter.interests,
          'contractDeadline': renter.contractDeadline.toIso8601String(),
        });
      }

      // 3. Upload photos to Firebase Storage
      for (File photo in photosPaths) {
        String photoName = photo.uri.pathSegments.last; // Get the file name
        Reference photoRef = _adRef.child(adDocRef.id).child(photoName); // Append the photo under [adDocRef.id] folder

        await photoRef.putFile(photo);
      }
      
    } on FirebaseException catch (e) {
      print('Failed to add ad: $e');
      throw Exception(e.message);
    }
  }

  Future<void> deleteAd({required String adUid}) async {
    try {
      // 1. Delete photos from Firebase Storage
      final adPhotosRef = _adRef.child(adUid);
      final adPhotos = await adPhotosRef.listAll();
      for (final item in adPhotos.items) {
        await item.delete();
      }

      // 2. Delete subcollections
      final adDocRef = _adCollection.doc(adUid);

      final subcollections = [
        _addressSubcolletionName,
        _roomsSubcolletionName,
        _rentersSubcollectionName,
      ];

      // Delete all subcollections and each document inside
      for (final subcollection in subcollections) {
        final snapshot = await adDocRef.collection(subcollection).get();
        for (final doc in snapshot.docs) {
          await doc.reference.delete(); 
        }
      }

      // 3. Delete the ad document
      await adDocRef.delete();

    } on FirebaseException catch (e) {
      print('Failed to delete ad: $e');
      throw Exception(e.message);
    }
  }

  Future<void> updateAd({
    required String adUid,
    required String name,
    required Address address,
    required List<Room> rooms,
    required int rentersCapacity,
    required List<Renter> renters,
    required List<String> services,
    required int monthlyRent,
    required List<File> newPhotosPaths,
  }) async {
    try {
      final adDocRef = _adCollection.doc(adUid);

      // 1. Update standard fields
      await adDocRef.update({
        _nameField: name,
        _rentersCapacityField: rentersCapacity,
        _monthlyRentField: monthlyRent,
        _servicesField: services, // Update services as a list of strings
      });

      // 2. Update subcollections

      // Update Address
      final addressSnapshot = await adDocRef.collection(_addressSubcolletionName).get();

      await addressSnapshot.docs.first.reference.update({
        'street': address.street,
        'city': address.city,
      });

      // Update Rooms
      final roomsSnapshot = await adDocRef.collection(_roomsSubcolletionName).get();
      for (final doc in roomsSnapshot.docs) {
        await doc.reference.delete();
      }

      for (final room in rooms) {
        final roomData = {
          'name': room.name,
          'quantity': room.quantity,
        };
        if (room is Bedroom) {
          roomData['numBeds'] = room.numBeds;
        }
        await adDocRef.collection(_roomsSubcolletionName).add(roomData);
      }

      // Update Renters
      final rentersSnapshot = await adDocRef.collection(_rentersSubcollectionName).get();
      for (final doc in rentersSnapshot.docs) {
        await doc.reference.delete();
      }
      for (final renter in renters) {
        await adDocRef.collection(_rentersSubcollectionName).add({
          'name': renter.name,
          'age': renter.age,
          'facultyOfStudies': renter.facultyOfStudies,
          'interests': renter.interests,
          'contractDeadline': renter.contractDeadline.toIso8601String(),
        });
      }

      // 3. Update photos in Firebase Storage
      final adPhotosRef = _adRef.child(adUid);
      final adPhotos = await adPhotosRef.listAll();

      // Delete old photos
      for (final item in adPhotos.items) {
        await item.delete();
      }

      // Upload new photos
      for (File photo in newPhotosPaths) {
        String photoName = photo.uri.pathSegments.last; // Get the file name
        Reference photoRef = _adRef.child(adUid).child(photoName); // Reference for the new photo
        await photoRef.putFile(photo); 
      }

    } on FirebaseException catch (e) {
      print('Failed to update ad: $e');
      throw Exception(e.message);
    }
  }

  Future<Either<String, List<AdData>>> getLatestAdsForRandomCity({required int n}) async {
    try {
      // 1. Fetch all ads
      final adsSnapshot = await _adCollection.get();
      final ads = adsSnapshot.docs;

      // 2. Filter ads by random city
      if (ads.isEmpty) {
        return right([]);
      }
      final randomCity = (ads..shuffle()).first[_addressSubcolletionName]['city'];
      final cityAdsSnapshot = await _adCollection
          .where('$_addressSubcolletionName.city', isEqualTo: randomCity)
          .orderBy('createdAt', descending: true)
          .limit(n)
          .get();

      List<AdData> adsList = [];
      for (final doc in cityAdsSnapshot.docs) {
        final adUid = doc.id;

        // Fetch ad photos
        final adPhotos = await _adRef.child(adUid).listAll();
        final List<String> adPhotosURLs = await Future.wait(
          adPhotos.items.map((item) => item.getDownloadURL())
        );

        // Fetch rooms
        final roomsSnapshot = await doc.reference.collection(_roomsSubcolletionName).get();
        List<Room> roomsList = roomsSnapshot.docs.map((roomDoc) {
          final roomData = roomDoc.data();
          if (roomData.containsKey('numBeds')) {
            return Bedroom(
              name: roomData['name'],
              quantity: roomData['quantity'],
              numBeds: List<int>.from(roomData['numBeds']),
            );
          } else {
            return Room(
              name: roomData['name'],
              quantity: roomData['quantity'],
            );
          }
        }).toList();

        // Fetch renters
        final rentersSnapshot = await doc.reference.collection(_rentersSubcollectionName).get();
        List<Renter> rentersList = rentersSnapshot.docs.map((renterDoc) {
          final renterData = renterDoc.data();
          return Renter(
            name: renterData['name'],
            age: renterData['age'],
            facultyOfStudies: renterData['facultyOfStudies'],
            interests: renterData['interests'],
            contractDeadline: DateTime.parse(renterData['contractDeadline']),
          );
        }).toList();

        // Fetch services field
        final services = List<String>.from(doc[_servicesField] ?? []);

        adsList.add(AdData(
          uid: adUid,
          hostUid: doc[_hostUidField],
          name: doc[_nameField],
          address: Address(
            street: doc[_addressSubcolletionName]['street'],
            city: doc[_addressSubcolletionName]['city'],
          ),
          rooms: roomsList,
          rentersCapacity: doc[_rentersCapacityField],
          renters: rentersList,
          services: services,
          monthlyRent: doc[_monthlyRentField],
          photosURLs: adPhotosURLs,
        ));
      }

      return right(adsList);
    } on FirebaseException catch (e) {
      return left(e.message ?? "Failed to fetch ads");
    }
  }

  Future<Either<String, List<AdData>>> getAdsByHostUid({required String hostUid}) async {
    try {
      // Fetch ads by hostUid
      final adsSnapshot = await _adCollection.where(_hostUidField, isEqualTo: hostUid).get();
      final ads = adsSnapshot.docs;

      List<AdData> adsList = [];
      for (final doc in ads) {
        final adUid = doc.id;

        // Retrieve subcollection data
        final addressSnap = await doc.reference.collection(_addressSubcolletionName).get();
        final addressData = addressSnap.docs.first.data();

        final roomsSnap = await doc.reference.collection(_roomsSubcolletionName).get();
        final rooms = roomsSnap.docs.map((roomDoc) {
          final roomData = roomDoc.data();
          if (roomData.containsKey('numBeds')) {
            return Bedroom(
              name: roomData['name'],
              quantity: roomData['quantity'],
              numBeds: List<int>.from(roomData['numBeds']),
            );
          } else {
            return Room(
              name: roomData['name'],
              quantity: roomData['quantity'],
            );
          }
        }).toList();

        final rentersSnap = await doc.reference.collection(_rentersSubcollectionName).get();
        final renters = rentersSnap.docs.map((renterDoc) => Renter(
          name: renterDoc['name'],
          age: renterDoc['age'],
          facultyOfStudies: renterDoc['facultyOfStudies'],
          interests: renterDoc['interests'],
          contractDeadline: DateTime.parse(renterDoc['contractDeadline']),
        )).toList();

        final services = List<String>.from(doc[_servicesField] ?? []);

        // Retrieve photo URLs
        final adPhotos = await _adRef.child(adUid).listAll();
        final List<String> adPhotosURLs = await Future.wait(
          adPhotos.items.map((item) => item.getDownloadURL())
        );

        // Add the ad data to the list
        adsList.add(AdData(
          uid: adUid,
          hostUid: doc[_hostUidField],
          name: doc[_nameField],
          address: Address(
            street: addressData['street'],
            city: addressData['city'],
          ),
          rooms: rooms,
          rentersCapacity: doc[_rentersCapacityField],
          renters: renters,
          services: services,
          monthlyRent: doc[_monthlyRentField],
          photosURLs: adPhotosURLs,
        ));
      }

      return right(adsList);
    } on FirebaseException catch (e) {
      return left(e.message ?? "Failed to fetch ads by host UID");
    }
  }

  // TODO: implementare metodo che scarica una lista filtrata di Ad per 
  // - range di prezzo (esempio: tra 200 e 330)
  // - List<String> services - every ad needs to match the services contained in this list
  // - number of bedrooms
  // - number of beds
  // - number of bathrooms - check the value for "Bathrooms" string with B in capslock exactly
  // - number of renters
  // ALL THESE PARAMETERS CAN BE NULL, IN CASE OF NULL PARAMETER RETURN NOTHING
}

final adDataSourceProvider = Provider<AdDataSource>((ref) => AdDataSource(
    ref.read(firebaseFirestoreProvider).collection(_adsCollectionName),
    ref.read(firebaseStorageProvider).ref().child(_photosAdsRef)
));
