class UserModel {
  final String name;
  final String lastName;
  final String email;
  final String accountPicture;

  const UserModel(
      {required this.name,
      required this.lastName,
      required this.email,
      required this.accountPicture});

  factory UserModel.fromJson(Map<String, dynamic> data) {
    final String name = data['name'];
    final String lastName = data['lastName'];
    final String email = data['email'];
    final String accountPicture = data['accountPicture'];

    return UserModel(
        name: name,
        lastName: lastName,
        email: email,
        accountPicture: accountPicture);
  }
}
