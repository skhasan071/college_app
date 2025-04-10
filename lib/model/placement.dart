class Placement {
  final String id;
  final String collegeId;
  final String salaryRange;
  final int studentsPlaced;
  final List<String> companiesVisited;

  Placement({
    required this.id,
    required this.collegeId,
    required this.salaryRange,
    required this.studentsPlaced,
    required this.companiesVisited,
  });

  factory Placement.fromMap(Map<String, dynamic> map) {
    return Placement(
      id: map['_id'] ?? '',
      collegeId: map['collegeId'] ?? '',
      salaryRange: map['salaryRange'] ?? '',
      studentsPlaced: map['studentsPlaced']?.toInt() ?? 0,
      companiesVisited: List<String>.from(map['companiesVisited'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'collegeId': collegeId,
      'salaryRange': salaryRange,
      'studentsPlaced': studentsPlaced,
      'companiesVisited': companiesVisited,
    };
  }
}
