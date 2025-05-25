class User {
  final String createdAt;
  final String name;
  final String avatar;
  final String id;
  final String email;
  final int totalTrips;

  User({
    required this.createdAt,
    required this.name,
    required this.avatar,
    required this.id,
    required this.email,
    required this.totalTrips,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      createdAt: json['createdAt'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      totalTrips: json['total_trips'] is int
          ? json['total_trips']
          : int.tryParse(json['total_trips'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'name': name,
      'avatar': avatar,
      'id': id,
      'email': email,
      'total_trips': totalTrips,
    };
  }
}






















// class User {
//   final String id;
//   final String name;
//   final String avatar;
//   final String status;
//   final String createdAt;
//
//   User({
//     required this.id,
//     required this.name,
//     required this.avatar,
//     required this.status,
//     required this.createdAt,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'] ?? 'Unknown',
//       name: json['name'] ?? 'Unknown',
//       avatar: json['Type'] ?? 'https://via.placeholder.com/150 ',
//       status: json['Status'] ?? 'Unknown',
//       createdAt: json['createdAt'] ?? 'Unknown',
//     );
//   }
// }