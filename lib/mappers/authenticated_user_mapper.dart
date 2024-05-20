import 'package:vecino_vigilante/dto/authenticated_user_dto.dart';
import 'package:vecino_vigilante/http/responses/authenticated_user_response.dart';

class AuthenticatedUserMapper {
  static AuthenticatedUserDTO toDTO(AuthenticatedUserResponse response) {
    return AuthenticatedUserDTO(
      accessToken: response.accessToken,
      userEmail: response.userEmail,
      userId: response.userId,
      userLastName: response.userLastName,
      userName: response.userName,
      userProfileImage: response.userProfileImage,
    );
  }

  static AuthenticatedUserResponse toResponse(AuthenticatedUserDTO dto) {
    return AuthenticatedUserResponse(
      accessToken: dto.accessToken,
      userEmail: dto.userEmail,
      userId: dto.userId,
      userLastName: dto.userLastName,
      userName: dto.userName,
      userProfileImage: dto.userProfileImage,
    );
  }
}
