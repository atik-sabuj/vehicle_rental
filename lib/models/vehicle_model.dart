// class Vehicle {
//   final String id;
//   final String name;
//   final String type;
//   final String status;
//   final String? image;
//   final int? battery;
//   final Location? location;
//   final double? costPerMinute;
//
//   Vehicle({
//     required this.id,
//     required this.name,
//     required this.type,
//     required this.status,
//     this.image,
//     this.battery,
//     this.location,
//     this.costPerMinute,
//   });
//
//   factory Vehicle.fromJson(Map<String, dynamic> json) {
//     return Vehicle(
//       id: json['id'] as String? ?? 'Unknown',
//       name: json['name'] as String? ?? 'Unknown',
//       type: json['Type'] as String? ?? 'Unknown',
//       status: json['Status'] as String? ?? 'Unknown',
//       image: json['image'] as String?,
//       battery: json['battery'] as int?,
//       location: json['location'] != null
//           ? Location.fromJson(json['location'] as Map<String, dynamic>)
//           : null,
//       costPerMinute: (json['cost_per_minute'] is num)
//           ? (json['cost_per_minute'] as num).toDouble()
//           : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'Type': type,
//       'Status': status,
//       'battery': battery,
//       'image': image,
//       'location': location?.toJson(),
//       'cost_per_minute': costPerMinute,
//     };
//   }
// }



class Vehicle {
  final String name;
  final String type;
  final String status;
  final String id;
  final int battery;
  final Location location;
  final double costPerMinute;
  final String image;

  Vehicle({
    required this.name,
    required this.type,
    required this.status,
    required this.id,
    required this.battery,
    required this.location,
    required this.costPerMinute,
    required this.image,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      name: json['name'],
      type: json['Type'], // Note: JSON key is "Type" (uppercase)
      status: json['Status'], // Note: JSON key is "Status"
      id: json['id'],
      battery: json['battery'],
      location: Location.fromJson(json['location']),
      costPerMinute: json['cost_per_minute'] is num
          ? json['cost_per_minute'].toDouble()
          : double.parse(json['cost_per_minute']),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'Type': type,
      'Status': status,
      'id': id,
      'battery': battery,
      'location': location.toJson(),
      'cost_per_minute': costPerMinute,
      'image': image,
    };
  }
}

class Location {
  final double? lat;
  final double? lng;

  Location({this.lat, this.lng});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: (json['lat'] is num)
          ? (json['lat'] as num).toDouble()
          : double.tryParse(json['lat'].toString()) ?? 0.0,
      lng: (json['lng'] is num)
          ? (json['lng'] as num).toDouble()
          : double.tryParse(json['lng'].toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}


