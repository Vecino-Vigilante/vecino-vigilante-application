import 'package:shared_preferences/shared_preferences.dart';
import 'package:vecino_vigilante/http/responses/authenticated_user_response.dart';

class AuthUtils {
  static Future<AuthenticatedUserResponseDTO?> getAuthenticatedUser() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    final String? savedAuthenticatedUser =
        sharedPreferences.getString("auth_user");

    return savedAuthenticatedUser != null
        ? authenticatedUserResponseFromJson(savedAuthenticatedUser)
        : null;
  }

  static Future<String> getBearerToken() async {
    AuthenticatedUserResponseDTO? authenticatedUser =
        await getAuthenticatedUser();

    return "Bearer ${authenticatedUser?.accessToken}";
  }

  static Future<void> setAuthenticatedUser(
    AuthenticatedUserResponseDTO user,
  ) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString(
      "auth_user",
      authenticatedUserResponseToJson(user),
    );
  }

  static Future<void> logout() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.remove("auth_user");
  }
}
