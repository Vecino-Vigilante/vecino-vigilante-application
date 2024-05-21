import 'package:shared_preferences/shared_preferences.dart';
import 'package:vecino_vigilante/dto/authenticated_user_dto.dart';

class AuthUtils {
  static Future<AuthenticatedUserDTO?> getAuthenticatedUser() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    final String? savedAuthenticatedUser =
        sharedPreferences.getString("auth_user");

    return savedAuthenticatedUser != null
        ? authenticatedUserDTOFromJson(savedAuthenticatedUser)
        : null;
  }

  static Future<String> getAuthenticatedUserId() async {
    AuthenticatedUserDTO? authenticatedUser = await getAuthenticatedUser();

    return "${authenticatedUser?.userId}";
  }

  static Future<String> getBearerToken() async {
    AuthenticatedUserDTO? authenticatedUser = await getAuthenticatedUser();

    return "Bearer ${authenticatedUser?.accessToken}";
  }

  static Future<void> setAuthenticatedUser(
    AuthenticatedUserDTO user,
  ) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString(
      "auth_user",
      authenticatedUserDTOToJson(user),
    );
  }

  static Future<void> logout() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.remove("auth_user");
  }
}
