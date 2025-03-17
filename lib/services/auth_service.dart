import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  bool _isAuthenticated = false;
  String? _token;
  String? _userRole;

  bool get isAuthenticated => _isAuthenticated;
  String? get token => _token;
  String? get userRole => _userRole;

  Future<bool> login(String username, String password) async {
    try {
      // TODO: Replace with your actual API endpoint
      final response = await http.post(
        Uri.parse('http://your-api-url/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _token = data['token'];
        _userRole = data['role'];
        _isAuthenticated = true;
        
        // Store token securely
        await _storage.write(key: 'auth_token', value: _token);
        await _storage.write(key: 'user_role', value: _userRole);
        
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  Future<void> logout() async {
    _token = null;
    _userRole = null;
    _isAuthenticated = false;
    
    await _storage.delete(key: 'auth_token');
    await _storage.delete(key: 'user_role');
    
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    _token = await _storage.read(key: 'auth_token');
    _userRole = await _storage.read(key: 'user_role');
    _isAuthenticated = _token != null;
    notifyListeners();
  }
} 