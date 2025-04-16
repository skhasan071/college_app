class Student {
  String id;
  final String name;
  final String email;
  final String password;
  final String? mobileNumber;
  final String? dob;
  final String? gender;
  final String? studyingIn;
  final String? city;
  final String? passedIn;
  final String? image;
  final List<String>? interestedStreams;
  final List<String>? coursesInterested;
  final String? preferredCourseLevel;
  final String? modeOfStudy;
  final String? preferredYearOfAdmission;
  final List<String>? favorites;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.mobileNumber,
    this.dob,
    this.gender,
    this.studyingIn,
    this.city,
    this.passedIn,
    this.image,
    this.interestedStreams,
    this.coursesInterested,
    this.preferredCourseLevel,
    this.modeOfStudy,
    this.preferredYearOfAdmission,
    this.favorites,
  });

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      mobileNumber: map['mobileNumber'],
      dob: map['dob'],
      gender: map['gender'],
      studyingIn: map['studyingIn'],
      city: map['city'],
      passedIn: map['passedIn'],
      image: map['image'],
      interestedStreams: map['interestedStreams'] != null
          ? List<String>.from(map['interestedStreams'])
          : null,
      coursesInterested: map['coursesInterested'] != null
          ? List<String>.from(map['coursesInterested'])
          : null,
      preferredCourseLevel: map['preferredCourseLevel'],
      modeOfStudy: map['modeOfStudy'],
      preferredYearOfAdmission: map['preferredYearOfAdmission'],
      favorites: map['favorites'] != null
          ? List<String>.from(map['favorites'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
      'mobileNumber': mobileNumber,
      'dob': dob,
      'gender': gender,
      'studyingIn': studyingIn,
      'city': city,
      'passedIn': passedIn,
      'image': image,
      'interestedStreams': interestedStreams,
      'coursesInterested': coursesInterested,
      'preferredCourseLevel': preferredCourseLevel,
      'modeOfStudy': modeOfStudy,
      'preferredYearOfAdmission': preferredYearOfAdmission,
      'favorites': favorites,
    };
  }
}
