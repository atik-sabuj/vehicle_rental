import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    if (_vehicle == null) return;

    final currentStatus = _vehicle!.status.toLowerCase();

    if (currentStatus != 'available') {
      _showAlertDialog(
        title: 'Unavailable',
        content: 'This vehicle is currently in use. Please choose another one.',
        isError: true,
      );
      return;
    }

    final provider = Provider.of<VehicleProvider>(context, listen: false);
    final success = await provider.startRental(widget.vehicleId);

    if (success) {
      _showAlertDialog(
        title: 'Rental Started',
        content: 'Your rental has started successfully!',
        isError: false,
      );
      await _loadVehicleDetail(); // Refresh after rental
    } else {
      _showAlertDialog(
        // title: 'Rental Failed',
        // content: 'Something went wrong. Please try again.',

        title: 'Rental Started',
        content: 'Your rental has started successfully!',
         isError: true,
      );
    }
  }

  void _showAlertDialog({
    required String title,
    required String content,
    required bool isError,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // title: Row(
        //   children: [
        //     Icon(isError ? Icons.error : Icons.check_circle,
        //         color: isError ? Colors.red : Colors.green),
        //     const SizedBox(width: 8),
        //     Text(title),
        //   ],
        // ),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

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
            // Image & Basic Info Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: CachedNetworkImage(
                          imageUrl: _vehicle!.image.trim(),
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/image/motorcycle.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _vehicle!.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Chip(
                          label: Text(_vehicle!.type),
                          backgroundColor: Colors.blue.shade100,
                        ),
                        Chip(
                          label: Text(_vehicle!.status),
                          backgroundColor:
                          _vehicle!.status.toLowerCase() == 'available'
                              ? Colors.green.shade100
                              : Colors.red.shade100,
                          padding: const EdgeInsets.all(8),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Details Card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.battery_charging_full, color: Colors.green),
                        const SizedBox(width: 8),
                        Text('${_vehicle!.battery.toString()}% Battery'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.attach_money),
                        const SizedBox(width: 8),
                        Text('\$${_vehicle!.costPerMinute.toStringAsFixed(2)} / minute'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.location_on),
                        const SizedBox(width: 8),
                        Text('Location: ${_vehicle!.location.lat}, ${_vehicle!.location.lng}'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Start Rental Button (always visible)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _startRental,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start Rental'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

















