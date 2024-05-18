import 'dart:convert';

SignupRequestDTO signupRequestFromJson(String str) =>
    SignupRequestDTO.fromJson(json.decode(str));

String signupRequestToJson(SignupRequestDTO data) => json.encode(data.toJson());

class SignupRequestDTO {
  String name;
  String lastName;
  String email;
  String password;

  SignupRequestDTO({
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
  });

  factory SignupRequestDTO.fromJson(Map<String, dynamic> json) =>
      SignupRequestDTO(
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
