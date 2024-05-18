import 'package:dio/dio.dart';
import 'package:vecino_vigilante/http/dio_client.dart';
import 'package:vecino_vigilante/http/responses/authenticated_user_response.dart';

Future<AuthenticatedUserResponseDTO?> login(
    String email, String password) async {
  try {
    Response<String> response = await dioClient.post(
      "/auth/login",
      data: {
        "username": email,
        "password": password,
      },
      options: Options(
        contentType: "application/x-www-form-urlencoded",
      ),
    );

    return authenticatedUserResponseFromJson(response.data!);
  } catch (e) {
    return null;
  }
}
