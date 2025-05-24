class User {
  final String id;
  final String name;
  final String avatar;
  final String status;
  final String createdAt;

  User({
    required this.id,
    required this.name,
    required this.avatar,
    required this.status,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 'Unknown',
      name: json['name'] ?? 'Unknown',
      avatar: json['Type'] ?? 'https://via.placeholder.com/150 ',
      status: json['Status'] ?? 'Unknown',
      createdAt: json['createdAt'] ?? 'Unknown',
    );
  }
}