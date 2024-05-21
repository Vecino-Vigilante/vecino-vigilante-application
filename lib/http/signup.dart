import 'package:dio/dio.dart';
import 'package:vecino_vigilante/dto/authenticated_user_dto.dart';
import 'package:vecino_vigilante/http/dio_client.dart';
import 'package:vecino_vigilante/http/requests/signup_request.dart';
import 'package:vecino_vigilante/http/responses/authenticated_user_response.dart';
import 'package:vecino_vigilante/mappers/authenticated_user_mapper.dart';

Future<AuthenticatedUserDTO?> signup(
  SignupRequest request,
) async {
  try {
    Response<String> response = await dioClient.post(
      "/auth/signup",
      data: signupRequestToJson(request),
    );

    AuthenticatedUserResponse authenticatedUserResponse =
        authenticatedUserResponseFromJson(response.data!);

    return AuthenticatedUserMapper.toDTO(authenticatedUserResponse);
  } catch (e) {
    return null;
  }
}
