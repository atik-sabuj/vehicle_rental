import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileProvider with ChangeNotifier {
 // final String baseUrl = 'https://your-mockapi.io/api/v1';

  final String baseUrl = 'https://vehiclerental.mockapi.io/api/v1';


  Map<String, dynamic>? _profile;
  bool _isLoading = false;
  String? _error;

  Map<String, dynamic>? get profile => _profile;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchProfile(int userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final url = Uri.parse('$baseUrl/users/$userId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        _profile = jsonDecode(response.body);
      } else {
        _error = 'Failed to load profile.';
      }
    } catch (e) {
      _error = 'Error: $e';
    }

    _isLoading = false;
    notifyListeners();
  }
}






