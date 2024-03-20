import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vecino_vigilante/domain/models/user_model.dart';

class SessionUtils {
  static Future<UserModel?> getUser() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    String? userInJson = sharedPreferences.getString("user");

    if (userInJson != null) {
      return UserModel.fromJson(jsonDecode(userInJson));
    }

    return null;
  }

  static Future<bool> setUser(UserModel user) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    return await sharedPreferences.setString("user", jsonEncode(user));
  }
}
