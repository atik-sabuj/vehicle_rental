import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/profile_provider.dart';

class ProfileScreen extends StatefulWidget {
  final int userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.userId > 0) {
      Provider.of<ProfileProvider>(context, listen: false)
          .fetchProfile(widget.userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: profileProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : profileProvider.error != null
          ? Center(child: Text(profileProvider.error!))
          : _buildProfileView(profileProvider.profile),
    );
  }

  Widget _buildProfileView(Map<String, dynamic>? profile) {
    if (profile == null) {
      return const Center(child: Text('No profile data found.'));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name: ${profile['name'] ?? 'N/A'}',
              style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          Text('Email: ${profile['email'] ?? 'N/A'}',
              style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          Text('Total Trips: ${profile['totalTrips'] ?? 0}',
              style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}

























