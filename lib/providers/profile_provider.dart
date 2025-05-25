import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ProfileProvider with ChangeNotifier {
  final String baseUrl = 'https://6831fd03c3f2222a8cb117a2.mockapi.io/io/api/v1';

  User? _profile;
  bool _isLoading = false;
  String? _error;

  User? get profile => _profile;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Future<void> fetchProfile(String userId) async {
  //   _isLoading = true;
  //   _error = null;
  //   notifyListeners();
  //
  //   try {
  //     final url = Uri.parse('$baseUrl/users');
  //     final response = await http.get(url);
  //
  //     if (response.statusCode == 200) {
  //       final userData = jsonDecode(response.body);
  //       _profile = User.fromJson(userData);
  //     } else {
  //       _error = 'Failed to load profile.';
  //     }
  //   } catch (e) {
  //     _error = 'Error fetching profile: $e';
  //   }
  //
  //   _isLoading = false;
  //   notifyListeners();
  // }

  Future<void> fetchProfile(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final url = Uri.parse('$baseUrl/users');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> userDataList = jsonDecode(response.body);

        // Find the user with the matching ID
        final foundUser = userDataList.firstWhere(
              (item) => item['id'] == userId,
          orElse: () => null,
        );

        if (foundUser != null) {
          _profile = User.fromJson(foundUser);
        } else {
          _error = 'User not found.';
        }
      } else {
        _error = 'Failed to load profile.';
      }
    } catch (e) {
      _error = 'Error fetching profile: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  // Optional: Clear selected profile
  void clearProfile() {
    _profile = null;
    notifyListeners();
  }
}















