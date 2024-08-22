class AuthArgs {
  final String email;
  final String password;

  AuthArgs({required this.email, required this.password});

  String get getEmail => email;
  String get getPassword => password;
}
