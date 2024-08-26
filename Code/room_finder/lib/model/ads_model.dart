class Ads {
  final String? id;
  final String hostUid;
  final String name;
  final Address address;
  final List<Room> rooms;
  final int rentersCapacity;
  final List<Renter> renters;
  final List<String> services;
  final int monthlyRent;
  final List<String> photosURL;

  Ads({
    this.id,
    required this.hostUid,
    required this.name,
    required this.address,
    required this.rooms,
    required this.rentersCapacity,
    required this.renters,
    required this.services,
    required this.monthlyRent,
    required this.photosURL,
  });

  // TODO: implementare metodo che scarica una lista di ads
}

class Address {
  final String street;
  final String city;

  Address({
    required this.street,
    required this.city,
  });
}

class Room {
  final String name;
  final int quantity;

  Room({
    required this.name,
    required this.quantity,
  });
}

class Bedroom extends Room {
  final List<int> numBeds;

  Bedroom(
      {required super.name, required super.quantity, required this.numBeds});
}

class Renter {
  final String name;
  final int age;
  final String facultyOfStudies;
  final String interests;
  final DateTime contractDeadline;

  Renter({
    required this.name,
    required this.age,
    required this.facultyOfStudies,
    required this.interests,
    required this.contractDeadline,
  });
}
