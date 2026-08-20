import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Storage Keys
  static const String _keyToken = 'user_token';
  static const String _keyUserId = 'user_id';
  static const String _keyUserName = 'user_name';
  static const String _keyUserEmail = 'user_email';
  static const String _keyUserImage = 'user_image';
  static const String _keyUserType = 'user_type';

  // --- SAVE AUTH DATA ---
  static Future<void> saveAuthData({
    required String token,
    required int userId,
    required String userName,
    required String userEmail,
    String? userImage,
    required String userType,
  }) async {
    await _preferences.setString(_keyToken, token);
    await _preferences.setInt(_keyUserId, userId);
    await _preferences.setString(_keyUserName, userName);
    await _preferences.setString(_keyUserEmail, userEmail);
    await _preferences.setString(_keyUserType, userType);
    if (userImage != null) {
      await _preferences.setString(_keyUserImage, userImage);
    }
  }

  // --- GETTERS ---
  static String? getToken() => _preferences.getString(_keyToken);
  static int? getUserId() => _preferences.getInt(_keyUserId);
  static String? getUserName() => _preferences.getString(_keyUserName);
  static String? getUserEmail() => _preferences.getString(_keyUserEmail);
  static String? getUserImage() => _preferences.getString(_keyUserImage);
  static String? getUserType() => _preferences.getString(_keyUserType);

  // Check if user is logged in
  static bool isLoggedIn() {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }

  // --- CLEAR SESSION (LOGOUT) ---
  static Future<bool> clearSession() async {
    return await _preferences.clear();
  }


  // Add inside CacheHelper
  static Future<void> updateUserData({
    required String userName,
    required String userEmail,
  }) async {
    await _preferences.setString(_keyUserName, userName);
    await _preferences.setString(_keyUserEmail, userEmail);
  }
}