import 'package:dio/dio.dart';
import 'package:vecino_vigilante/http/dio_client.dart';
import 'package:vecino_vigilante/http/requests/signup_request.dart';
import 'package:vecino_vigilante/http/responses/authenticated_user_response.dart';

Future<AuthenticatedUserResponseDTO?> signup(
    Map<String, dynamic> userData) async {
  try {
    final request = SignupRequestDTO(
      email: userData["email"],
      lastName: userData["lastname"],
      name: userData["name"],
      password: userData["password"],
    );

    Response<String> response = await dioClient.post(
      "/auth/signup",
      data: signupRequestToJson(request),
    );

    return authenticatedUserResponseFromJson(response.data!);
  } catch (e) {
    return null;
  }
}
