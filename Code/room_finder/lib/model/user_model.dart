class UserData {
  final String? uid;
  final String name;
  final String? photoUrl;
  final bool isHost;

  UserData(
      {this.uid = '',
      required this.name,
      this.photoUrl = '',
      required this.isHost});
}
