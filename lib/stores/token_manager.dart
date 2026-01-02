import 'package:e_commerce/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  Future<SharedPreferences> _getInstance() {
    return SharedPreferences.getInstance();
  }

  String _token = "";

  Future<void> init() async {
    final prefs = await _getInstance();
    _token = prefs.getString(GlobalConstants.tokenKey) ?? "";
  }

  Future<void> setToken(String value) async {
    final prefs = await _getInstance();
    await prefs.setString(GlobalConstants.tokenKey, value);
    _token = value;
  }

  String getToken() {
    return _token;
  }

  Future<void> removeToken() async {
    final prefs = await _getInstance();
    await prefs.remove(GlobalConstants.tokenKey);
    _token = "";
  }
}

final tokenManager = TokenManager();
