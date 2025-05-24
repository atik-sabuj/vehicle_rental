import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_rental/providers/auth_provider.dart';
import 'package:vehicle_rental/providers/vehicle_provider.dart';
import 'package:vehicle_rental/screens/splash_screen/view_splash_screen.dart';
// import 'screens/login_screen.dart';
// import 'screens/splash_screen.dart';
// import 'providers/auth_provider.dart';
// import 'providers/vehicle_provider.dart';
// import 'providers/profile_provider.dart';

void main() {
  runApp(const VehicleRentalApp());
}

class VehicleRentalApp extends StatelessWidget {
  const VehicleRentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => VehicleProvider()),
        // ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: MaterialApp(
        title: 'Vehicle Rental',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const SplashScreen(),
      ),
    );
  }
}
