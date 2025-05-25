import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    const dummyProfile = {
      "name": "John Doe",
      "email": "user@example.com",
      "total_trips": 15,
   //   "avatar": "https://via.placeholder.com/150",
      "status": "Active",
      "created_at": "2025-02-01",
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Avatar
                // CircleAvatar(
                //   radius: 50,
                //   backgroundImage: NetworkImage(dummyProfile['avatar']!.toString()),
                // ),
                // const SizedBox(height: 16),

                // Local Avatar Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    'assets/image/man.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),

                // Name
                Text(
                  dummyProfile['name']!.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // Email
                Row(
                  children: [
                    const Icon(Icons.email, size: 18),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        dummyProfile['email']!.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Total Trips
                Row(
                  children: [
                    const Icon(Icons.directions_car, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      'Total Trips: ${dummyProfile['total_trips']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Status
                Row(
                  children: [
                    const Icon(Icons.verified_user, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      'Status: ${dummyProfile['status']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Created At
                Row(
                  children: [
                    const Icon(Icons.date_range, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      'Joined: ${dummyProfile['created_at']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





















// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../models/user_model.dart';
// import '../../providers/profile_provider.dart';
//
// class ProfileScreen extends StatefulWidget {
//   final String userId;
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
//     Provider.of<ProfileProvider>(context, listen: false).fetchProfile(widget.userId);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final profileProvider = Provider.of<ProfileProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Profile',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontStyle: FontStyle.italic,
//             color: Colors.black,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: profileProvider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : profileProvider.error != null
//           ? Center(child: Text(profileProvider.error!))
//           : _buildProfileView(profileProvider.profile),
//     );
//   }
//
//   Widget _buildProfileView(User? profile) {
//     if (profile == null) {
//       return const Center(child: Text('Profile not found.'));
//     }
//
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: CircleAvatar(
//               backgroundImage: NetworkImage(profile.avatar),
//               radius: 60,
//             ),
//           ),
//           const SizedBox(height: 20),
//
//           Text(
//             'Name: ${profile.name}',
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//
//           Text(
//             'Email: ${profile.email}',
//             style: const TextStyle(fontSize: 16),
//           ),
//           const SizedBox(height: 8),
//
//           Text(
//             'ID: ${profile.id}',
//             style: const TextStyle(fontSize: 16),
//           ),
//           const SizedBox(height: 8),
//
//           Text(
//             'Created At: ${profile.createdAt}',
//             style: const TextStyle(fontSize: 16),
//           ),
//           const SizedBox(height: 8),
//
//           Text(
//             'Total Trips: ${profile.totalTrips}',
//             style: const TextStyle(fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }
// }




















































