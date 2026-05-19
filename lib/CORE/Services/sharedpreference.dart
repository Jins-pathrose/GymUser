import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String memberDataKey = 'member_data';

  /// Save Tokens + Member Data
  static Future<void> saveLoginData({
    required String accessToken,
    required String refreshToken,
    required Map<String, dynamic> memberData,
  }) async {
    
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(accessTokenKey, accessToken);
    await prefs.setString(refreshTokenKey, refreshToken);

    /// Store member object as JSON String
    await prefs.setString(
      memberDataKey,
      jsonEncode(memberData),
    );
  }

  /// Get Access Token
  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(accessTokenKey);
  }

  /// Get Refresh Token
  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(refreshTokenKey);
  }

  /// Get Member Data
  static Future<Map<String, dynamic>?> getMemberData() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(memberDataKey);

    if (data != null) {
      return jsonDecode(data);
    }

    return null;
  }

  /// Logout / Clear Data
  static Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(accessTokenKey);
    await prefs.remove(refreshTokenKey);
    await prefs.remove(memberDataKey);
  }
}