class Hostel {
  final String id;
  final String collegeId;
  final String hostelName;
  final List<String> amenities;
  final int seats;
  final List<String> photos;
  final List<String> videos;

  Hostel({
    required this.id,
    required this.collegeId,
    required this.hostelName,
    required this.amenities,
    required this.seats,
    required this.photos,
    required this.videos,
  });

  factory Hostel.fromMap(Map<String, dynamic> map) {
    return Hostel(
      id: map['_id'] ?? '',
      collegeId: map['collegeId'] ?? '',
      hostelName: map['hostelName'] ?? '',
      amenities: List<String>.from(map['amenities'] ?? []),
      seats: map['seats']?.toInt() ?? 0,
      photos: List<String>.from(map['photos'] ?? []),
      videos: List<String>.from(map['videos'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'collegeId': collegeId,
      'hostelName': hostelName,
      'amenities': amenities,
      'seats': seats,
      'photos': photos,
      'videos': videos,
    };
  }
}
