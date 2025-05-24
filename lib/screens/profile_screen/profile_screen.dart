import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user_model.dart'; // Make sure this path is correct
import '../../providers/profile_provider.dart';

class ProfileScreen extends StatefulWidget {
  final String userId; // Changed to String since ID is a string in JSON

  const ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false).fetchProfile(widget.userId);
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

  Widget _buildProfileView(User? profile) {
    if (profile == null) {
      return const Center(child: Text('No profile data found.'));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar Image
          Center(
            child: CircleAvatar(
              backgroundImage: NetworkImage(profile.avatar),
              radius: 60,
            ),
          ),
          const SizedBox(height: 20),

          // Name
          Text(
            'Name: ${profile.name}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // ID
          Text(
            'ID: ${profile.id}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),

          // Status
          Text(
            'Status: ${profile.status ?? 'N/A'}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),

          // Created At
          Text(
            'Created At: ${profile.createdAt}',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}








// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../providers/profile_provider.dart';
//
// class ProfileScreen extends StatefulWidget {
//   final int userId;
//
//   const ProfileScreen({super.key, required this.userId});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   void initState() {
//     super.initState();
//     if (widget.userId > 0) {
//       Provider.of<ProfileProvider>(context, listen: false)
//           .fetchProfile(widget.userId);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final profileProvider = Provider.of<ProfileProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Profile')),
//       body: profileProvider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : profileProvider.error != null
//           ? Center(child: Text(profileProvider.error!))
//           : _buildProfileView(profileProvider.profile),
//     );
//   }
//
//   Widget _buildProfileView(Map<String, dynamic>? profile) {
//     if (profile == null) {
//       return const Center(child: Text('No profile data found.'));
//     }
//
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Name: ${profile['name'] ?? 'N/A'}',
//               style: const TextStyle(fontSize: 18)),
//           const SizedBox(height: 8),
//           Text('Email: ${profile['email'] ?? 'N/A'}',
//               style: const TextStyle(fontSize: 18)),
//           const SizedBox(height: 8),
//           Text('Total Trips: ${profile['totalTrips'] ?? 0}',
//               style: const TextStyle(fontSize: 18)),
//         ],
//       ),
//     );
//   }
// }

























