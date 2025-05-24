import 'package:flutter/material.dart';
import 'dart:async';
import '../login_screen/login_screen.dart';
import '../vehicle_screen/vehicle_list_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  void _navigateToLogin() {
    Timer(const Duration(seconds: 20), () {
      Navigator.pushReplacement(
        context,
    //    MaterialPageRoute(builder: (_) => const LoginScreen()),
        MaterialPageRoute(builder: (_) => const VehicleListScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.directions_bike, color: Colors.white, size: 80),
            SizedBox(height: 20),
            Text(
              'Vehicle Rental',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
