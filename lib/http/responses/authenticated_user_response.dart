import 'dart:convert';

AuthenticatedUserResponseDTO authenticatedUserResponseFromJson(String str) =>
    AuthenticatedUserResponseDTO.fromJson(json.decode(str));

String authenticatedUserResponseToJson(AuthenticatedUserResponseDTO data) =>
    json.encode(data.toJson());

class AuthenticatedUserResponseDTO {
  String accessToken;
  String userEmail;
  String userId;
  String userLastName;
  String userName;
  String userProfileImage;

  AuthenticatedUserResponseDTO({
    required this.accessToken,
    required this.userEmail,
    required this.userId,
    required this.userLastName,
    required this.userName,
    required this.userProfileImage,
  });

  factory AuthenticatedUserResponseDTO.fromJson(Map<String, dynamic> json) =>
      AuthenticatedUserResponseDTO(
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
