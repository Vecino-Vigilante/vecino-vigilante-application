import 'dart:convert';

SignupRequest signupRequestFromJson(String str) =>
    SignupRequest.fromJson(json.decode(str));

String signupRequestToJson(SignupRequest data) => json.encode(data.toJson());

class SignupRequest {
  String? name;
  String? lastName;
  String? email;
  String? password;

  SignupRequest({
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
  });

  factory SignupRequest.fromJson(Map<String, dynamic> json) =>
      SignupRequest(
        name: json["name"],
        lastName: json["last_name"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "last_name": lastName,
        "email": email,
        "password": password,
      };
}
