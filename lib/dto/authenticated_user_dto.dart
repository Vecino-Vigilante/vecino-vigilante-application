import 'dart:convert';

AuthenticatedUserDTO authenticatedUserDTOFromJson(String str) =>
    AuthenticatedUserDTO.fromJson(json.decode(str));

String authenticatedUserDTOToJson(AuthenticatedUserDTO data) =>
    json.encode(data.toJson());

class AuthenticatedUserDTO {
  String? accessToken;
  String? userEmail;
  String? userId;
  String? userLastName;
  String? userName;
  String? userProfileImage;

  AuthenticatedUserDTO({
    this.accessToken,
    this.userEmail,
    this.userId,
    this.userLastName,
    this.userName,
    this.userProfileImage,
  });

  factory AuthenticatedUserDTO.fromJson(Map<String, dynamic> json) =>
      AuthenticatedUserDTO(
        accessToken: json["access_token"],
        userEmail: json["user_email"],
        userId: json["user_id"],
        userLastName: json["user_last_name"],
        userName: json["user_name"],
        userProfileImage: json["user_profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "user_email": userEmail,
        "user_id": userId,
        "user_last_name": userLastName,
        "user_name": userName,
        "user_profile_image": userProfileImage,
      };
}
