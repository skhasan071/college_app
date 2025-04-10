class College {
  final String id;
  final String name;
  final String city;
  final String state;
  final String country;
  final int ranking;
  final String brochure;
  final String image;
  final String collegeInfo;
  final String stream; // Expected values: "Engineering", "Medical", etc.
  final String type;   // Expected values: "Private", "Government"

  College({
    required this.id,
    required this.name,
    required this.city,
    required this.state,
    required this.country,
    required this.ranking,
    required this.brochure,
    required this.image,
    required this.collegeInfo,
    required this.stream,
    required this.type,
  });

  factory College.fromMap(Map<String, dynamic> map) {
    return College(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      country: map['country'] ?? '',
      ranking: map['ranking']?.toInt() ?? 0,
      brochure: map['brochure'] ?? '',
      image: map['image'] ?? '',
      collegeInfo: map['collegeInfo'] ?? '',
      stream: map['stream'] ?? '',
      type: map['type'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'city': city,
      'state': state,
      'country': country,
      'ranking': ranking,
      'brochure': brochure,
      'image': image,
      'collegeInfo': collegeInfo,
      'stream': stream,
      'type': type,
    };
  }
}
