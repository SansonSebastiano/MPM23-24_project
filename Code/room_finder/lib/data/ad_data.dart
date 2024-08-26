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
const String _addressSubcolletionName = 'address';
const String _roomsSubcolletionName = 'rooms';
const String _rentersSubcollectionName = 'renters';
const String _servicesSubcollectionName = 'services';
const String _adsCollectionName = 'ads'; // for Provider
const String _photosAdsRef = "photos/ads"; // for Provider

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
      
      final adPhotos = await _adRef.child(adUid).listAll();
      final List<String> adPhotosURLs = await Future.wait(
        adPhotos.items.map((item) => item.getDownloadURL())
      );

      return right(AdData(
        hostUid: docSnap[_hostUidField],
        name: docSnap[_nameField],
        address: docSnap[_addressSubcolletionName],
        rooms: docSnap[_roomsSubcolletionName],
        rentersCapacity: docSnap[_rentersCapacityField],
        renters: docSnap[_rentersSubcollectionName],
        services: docSnap[_servicesSubcollectionName],
        monthlyRent: docSnap[_monthlyRentField],
        photosURL: adPhotosURLs
      ));
    } on FirebaseException catch (e) {
      return left(e.message ?? "Failed to get the ad data");
    }
  }

  Future<void> addNewAd({
    required String newAdUid, 
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
      });

      // 2. Add sub-collections
      await adDocRef.collection(_addressSubcolletionName).add({
        'street': address.street,
        'city': address.city,
      });

      for (Room room in rooms) {
        await adDocRef.collection(_roomsSubcolletionName).add({
          'name': room.name,
          'quantity': room.quantity,
        });
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

      for (String service in services) {
        await adDocRef.collection(_servicesSubcollectionName).add({
          'name': service,
        });
      }

      // 3. Upload photos to Firebase Storage
      for (File photo in photosPaths) {
        // Create a reference to the storage location
        String photoName = photo.uri.pathSegments.last; // Get the file name
        Reference photoRef = _adRef.child(adDocRef.id).child(photoName);

        // Upload the file to Firebase Storage
        await photoRef.putFile(photo);
      }
      
    } on FirebaseException catch (e) {
      print('Failed to add ad: $e');
      throw Exception(e.message);
    }
  }

  // TODO: implementare metodo che elimina un Ad

  // TODO: implementare metodo che modifica un Ad

  // TODO: implementare metodo che scarica una lista di Ad

  // TODO: implementare metodo che scarica una lista filtrata di Ad

  // TODO: implementare metodo che scarica una lista di Ad per l'account host in base al suo uid
}

// TODO: write the provider