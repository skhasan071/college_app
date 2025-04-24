class Placement {
  final String numberOfCompanyVisited;
  final String averagePackage;
  final String highestPackage;
  final String placementRate;
  final List<String> companiesVisited;
  final List<String> recentPlacements;
  final String fiveToTen;
  final String tenToFifteen;
  final String fifteenToTwenty;
  final String aboveTwenty;

  Placement({
    required this.numberOfCompanyVisited,
    required this.averagePackage,
    required this.highestPackage,
    required this.placementRate,
    required this.companiesVisited,
    required this.recentPlacements,
    required this.fiveToTen,
    required this.tenToFifteen,
    required this.fifteenToTwenty,
    required this.aboveTwenty,
  });

  // Factory method to create a Placement object from JSON data
  factory Placement.fromJson(Map<String, dynamic> json) {
    return Placement(
      numberOfCompanyVisited : json['numberOfCompanyVisited']?? '',
      averagePackage: json['averagePackage'] ?? '',
      highestPackage: json['highestPackage'] ?? '',
      placementRate: json['placementRate'] ?? '',
      companiesVisited: List<String>.from(json['companiesVisited'] ?? []),
      recentPlacements: List<String>.from(json['recentPlacements'] ?? []),
      fiveToTen: json['fiveToTen'] ?? '',
      tenToFifteen: json['tenToFifteen'] ?? '',
      fifteenToTwenty: json['fifteenToTwenty'] ?? '',
      aboveTwenty: json['aboveTwenty'] ?? '',
    );
  }

  // Method to convert Placement object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'numberOfCompanyVisited' : numberOfCompanyVisited,
      'averagePackage': averagePackage,
      'highestPackage': highestPackage,
      'placementRate': placementRate,
      'companiesVisited': companiesVisited,
      'recentPlacements': recentPlacements,
      'fiveToTen': fiveToTen,
      'tenToFifteen': tenToFifteen,
      'fifteenToTwenty': fifteenToTwenty,
      'aboveTwenty': aboveTwenty,
    };
  }
}
