class UserResponse {
  String? id;
  String? name;
  String? lastName;
  String? email;

  UserResponse({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        id: json["id"],
        name: json["name"],
        lastName: json["last_name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "last_name": lastName,
        "email": email,
      };
}
