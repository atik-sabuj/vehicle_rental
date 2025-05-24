import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VehicleDetailScreen extends StatefulWidget {
  final String vehicleId;
  const VehicleDetailScreen({super.key, required this.vehicleId});

  @override
  State<VehicleDetailScreen> createState() => _VehicleDetailScreenState();
}

class _VehicleDetailScreenState extends State<VehicleDetailScreen> {
  Map<String, dynamic>? _vehicle;
  bool _isLoading = true;
  String? _error;

  Future<void> fetchVehicleDetails() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final url = Uri.parse('https://your-mockapi-endpoint.com/vehicles/${widget.vehicleId}');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          _vehicle = jsonDecode(response.body);
        });
      } else {
        _error = 'Failed to fetch details';
      }
    } catch (e) {
      _error = 'Error: $e';
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> startRental() async {
    final url = Uri.parse('https://your-mockapi-endpoint.com/vehicles/${widget.vehicleId}/rent');

    try {
      final response = await http.post(url);
      if (response.statusCode == 200) {
        final msg = jsonDecode(response.body)['message'];
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to start rental')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchVehicleDetails();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_error != null) {
      return Scaffold(body: Center(child: Text(_error!)));
    }

    if (_vehicle == null) {
      return const Scaffold(body: Center(child: Text('No data available')));
    }

    return Scaffold(
      appBar: AppBar(title: Text(_vehicle!['name'] ?? 'Vehicle Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(_vehicle!['image'], height: 150),
            const SizedBox(height: 16),
            Text('Type: ${_vehicle!['type']}'),
            Text('Status: ${_vehicle!['status']}'),
            Text('Battery: ${_vehicle!['battery']}%'),
            Text('Cost/min: \$${_vehicle!['cost_per_minute']}'),
            Text('Location: (${_vehicle!['location']['lat']}, ${_vehicle!['location']['lng']})'),
            const Spacer(),
            ElevatedButton(
              onPressed: startRental,
              child: const Text('Start Rental'),
            ),
          ],
        ),
      ),
    );
  }
}
