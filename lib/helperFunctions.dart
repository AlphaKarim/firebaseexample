import 'package:shared_preferences/shared_preferences.dart';
class SharedPreferencesUtil{
  static String SharedPreferenceUserLogInKey = "USERLOGINKEY";
  static String SharedPreferenceUserNameKey = "USERNAMEKEY";
  static String SharedPreferenceUserEmailKey = "USEREMAILKEY";

  static Future<void> saveUserName(String username) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(SharedPreferenceUserNameKey, username);
  }
  static Future<void> saveUserEmail(String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(SharedPreferenceUserEmailKey, email);
  }
  static Future<String> getUserEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(SharedPreferenceUserEmailKey);
  }
  static Future<String> getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(SharedPreferenceUserNameKey);
  }
  static Future<void> saveUserLoginBool(bool loginBool) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool(SharedPreferenceUserLogInKey, loginBool);
  }
  static Future<bool> getUserLoginBool() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(SharedPreferenceUserLogInKey);
  }
}