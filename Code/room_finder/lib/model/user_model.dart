/// [UserData] is the object that encapsulate the following data:
/// 
/// *[uid] the ID of the user account
/// 
/// *[name] the name of the user
/// 
/// *[photoUrl] the profile photo of the user
/// 
/// *[isHost] represent the user's role {true if 'host', false if 'student'}
class UserData {
  final String? uid;
  final String? name;
  final String? photoUrl;
  final bool isHost;

  UserData(
      {this.uid = '',
      this.name = '',
      this.photoUrl = '',
      required this.isHost});

  // USE THESE WHEN THE OBJECT IS MORE COMPLEX, IN ORDER TO A EASIER CONVERSION

  // factory City.fromFirestore(
  //   DocumentSnapshot<Map<String, dynamic>> snapshot,
  //   SnapshotOptions? options,
  // ) {
  //   final data = snapshot.data();
  //   return City(
  //     name: data?['name'],
  //     state: data?['state'],
  //     country: data?['country'],
  //     capital: data?['capital'],
  //     population: data?['population'],
  //     regions:
  //         data?['regions'] is Iterable ? List.from(data?['regions']) : null,
  //   );
  // }

  // Map<String, dynamic> toFirestore() {
  //   return {
  //     if (name != null) "name": name,
  //     if (state != null) "state": state,
  //     if (country != null) "country": country,
  //     if (capital != null) "capital": capital,
  //     if (population != null) "population": population,
  //     if (regions != null) "regions": regions,
  //   };
  // }
}
