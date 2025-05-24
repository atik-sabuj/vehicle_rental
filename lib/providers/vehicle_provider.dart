import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/vehicle_model.dart';  // adjust path accordingly

class VehicleProvider with ChangeNotifier {
  final String baseUrl = 'https://6831fd03c3f2222a8cb117a2.mockapi.io/io/api/v1';

  List<Vehicle> _vehicles = [];
  Vehicle? _selectedVehicle;
  bool _isLoading = false;
  String? _error;

  List<Vehicle> get vehicles => _vehicles;
  Vehicle? get selectedVehicle => _selectedVehicle;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchVehicles() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final url = Uri.parse('$baseUrl/VehicleList');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _vehicles = data.map((e) => Vehicle.fromJson(e)).toList();
      } else {
        _error = 'Failed to load vehicles.';
      }
    } catch (e) {
      _error = 'Error: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> fetchVehicleDetail(String id) async {
    try {
      final url = Uri.parse('$baseUrl/VehicleList/$id');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _selectedVehicle = Vehicle.fromJson(data);
        notifyListeners();
        return true;
      } else {
        _error = 'Failed to load vehicle detail.';
      }
    } catch (e) {
      _error = 'Error: $e';
    }
    notifyListeners();
    return false;
  }

  Future<bool> startRental(String id) async {
    try {
      final url = Uri.parse('$baseUrl/VehicleList/$id/rent');
      final response = await http.post(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      debugPrint('Start rental error: $e');
    }
    return false;
  }
}

















