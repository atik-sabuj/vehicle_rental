import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/vehicle_provider.dart';
import '../../models/vehicle_model.dart';

class VehicleDetailScreen extends StatefulWidget {
  final String vehicleId;




  const VehicleDetailScreen({super.key, required this.vehicleId});

  @override
  State<VehicleDetailScreen> createState() => _VehicleDetailScreenState();
}

class _VehicleDetailScreenState extends State<VehicleDetailScreen> {
  Vehicle? _vehicle;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadVehicleDetail();
  }

  Future<void> _loadVehicleDetail() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final provider = Provider.of<VehicleProvider>(context, listen: false);
    final success = await provider.fetchVehicleDetail(widget.vehicleId);

    setState(() {
      _isLoading = false;
      if (success) {
        _vehicle = provider.selectedVehicle;
      } else {
        _error = 'Failed to load vehicle details.';
      }
    });
  }

  Future<void> _startRental() async {
    final provider = Provider.of<VehicleProvider>(context, listen: false);
    final success = await provider.startRental(widget.vehicleId);
    final message = success ? 'Rental started successfully.' : 'Failed to start rental.';

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

    if (success) {
      _loadVehicleDetail(); // Refresh detail after starting rental
    }
  }
  static const String defaultVehicleImage = 'https://cdn-icons-png.flaticon.com/512/1086/10863820.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vehicle Detail')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text(_error!))
          : _vehicle == null
          ? const Center(child: Text('Vehicle not found.'))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // if (_vehicle!.image != null)
            //   Center(
            //     child: Image.network(
            //     //  _vehicle!.image!,
            //       _vehicle!.image ?? defaultVehicleImage,
            //       height: 200,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            const SizedBox(height: 16),
            Text('Name: ${_vehicle!.name}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 8),
            Text('Type: ${_vehicle!.type}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Status: ${_vehicle!.status}', style: const TextStyle(fontSize: 18)),
            const Spacer(),
            if (_vehicle!.status == 'available')
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _startRental,
                  child: const Text('Start Rental'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


