import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VehicleProvider with ChangeNotifier {
  List<dynamic> _vehicles = [];
  bool _isLoading = false;
  String? _error;

  List<dynamic> get vehicles => _vehicles;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchVehicles() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final url = Uri.parse('https://your-mockapi-endpoint.com/vehicles');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        _vehicles = jsonDecode(response.body);
      } else {
        _error = 'Failed to load vehicles';
      }
    } catch (e) {
      _error = 'Error: $e';
    }

    _isLoading = false;
    notifyListeners();
  }
}
