import 'package:cached_network_image/cached_network_image.dart';
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
    // Fetch vehicles on init
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
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 8.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VehicleDetailScreen(
                            vehicleId: vehicle.id),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      // Image Section
                      ClipRRect(
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(12),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: vehicle.image.trim(),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const SizedBox(
                            width: 100,
                            height: 100,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/image/motorcycle.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Info Section
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vehicle.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${vehicle.type} • ${vehicle.status}',
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(Icons.battery_charging_full,
                                      color: Colors.green, size: 16),
                                  const SizedBox(width: 4),
                                  Text('${vehicle.battery}%'),
                                  const SizedBox(width: 12),
                                  Text(
                                    '\$${vehicle.costPerMinute}/min',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                      // Arrow icon
                      const Padding(
                        padding:
                        EdgeInsets.only(right: 12.0, top: 8, bottom: 8),
                        child: Icon(Icons.arrow_forward_ios, size: 16),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}









// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:vehicle_rental/screens/vehicle_screen/vehicle_detail_screen..dart';
// import '../../providers/vehicle_provider.dart';
//
// class VehicleListScreen extends StatefulWidget {
//   const VehicleListScreen({super.key});
//
//   @override
//   State<VehicleListScreen> createState() => _VehicleListScreenState();
// }
//
// class _VehicleListScreenState extends State<VehicleListScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Fetch vehicles once on init
//     Provider.of<VehicleProvider>(context, listen: false).fetchVehicles();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<VehicleProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Available Vehicles')),
//       body: RefreshIndicator(
//         onRefresh: provider.fetchVehicles,
//         child: provider.isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : provider.error != null
//             ? Center(child: Text(provider.error!))
//             : provider.vehicles.isEmpty
//             ? const Center(child: Text('No vehicles found'))
//             : ListView.builder(
//           itemCount: provider.vehicles.length,
//           itemBuilder: (ctx, i) {
//             final vehicle = provider.vehicles[i];
//             return ListTile(
//                 leading: vehicle.image != null
//                     ? CachedNetworkImage(
//                   imageUrl: vehicle.image!,
//                   width: 50,
//                   height: 50,
//                   fit: BoxFit.cover,
//                   placeholder: (context, url) => CircularProgressIndicator(),
//                   errorWidget: (context, url, error) => Icon(Icons.error),
//                 )
//
//                   : const Icon(Icons.directions_car),
//               title: Text(vehicle.name),
//               subtitle: Text('${vehicle.type} - ${vehicle.status}'),
//               trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => VehicleDetailScreen(vehicleId: vehicle.id),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
