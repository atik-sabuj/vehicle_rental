import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String? _token;
  Map<String, dynamic>? _user;

  bool get isAuthenticated => _token != null;
  String? get token => _token;
  Map<String, dynamic>? get user => _user;

  // Mock login - replace with real API if available
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network delay

    if (email == 'user@example.com' && password == '123456') {
      _token = 'abc123'; // mock token
      _user = {
        'id': 1,
        'name': 'John Doe',
        'email': email,
      };
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _token = null;
    _user = null;
    notifyListeners();
  }
}

























