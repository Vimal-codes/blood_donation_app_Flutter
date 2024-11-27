
import 'package:shared_preferences/shared_preferences.dart';

import '../model/login/GetLoginData.dart';

class SharedPreferenceHelper {
  static const String _loginDataKey = "user_login_data";

  // Save login data to SharedPreferences
  Future<void> saveLoginData(GetLoginData loginData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = getLoginDataToJson(loginData);
    await prefs.setString(_loginDataKey, jsonData);
  }

  // Retrieve login data from SharedPreferences
  Future<GetLoginData?> getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString(_loginDataKey);
    if (jsonData != null) {
      return getLoginDataFromJson(jsonData);
    }
    return null;
  }

  // Clear login data from SharedPreferences
  Future<void> clearLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loginDataKey);
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_loginDataKey);
  }
}