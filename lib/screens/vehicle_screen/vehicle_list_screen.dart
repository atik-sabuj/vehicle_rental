import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_rental/screens/vehicle_screen/vehicle_detail_screen..dart';
import '../../providers/vehicle_provider.dart';

class VehicleListScreen extends StatefulWidget {
  const VehicleListScreen({super.key});

  @override
  State<VehicleListScreen> createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<VehicleProvider>(context, listen: false).fetchVehicles();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VehicleProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Available Vehicles')),
      body: RefreshIndicator(
        onRefresh: provider.fetchVehicles,
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : provider.error != null
            ? Center(child: Text(provider.error!))
            : provider.vehicles.isEmpty
            ? const Center(child: Text('No vehicles found'))
            : ListView.builder(
          itemCount: provider.vehicles.length,
          itemBuilder: (ctx, i) {
            final vehicle = provider.vehicles[i];
            return ListTile(
              leading: Image.network(vehicle['image'], width: 50),
              title: Text(vehicle['name']),
              subtitle: Text('${vehicle['type']} - ${vehicle['status']}'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => VehicleDetailScreen(vehicleId: vehicle['id']),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
