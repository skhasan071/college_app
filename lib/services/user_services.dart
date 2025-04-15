import 'dart:convert';
import 'dart:io';
import 'package:college_app/model/user.dart';
import 'package:college_app/view/Filters&Compare/colleges.dart';
import 'package:http/http.dart' as http;

import '../model/college.dart';

class StudentService {
  static const String _baseUrl = 'http://localhost:8080/api/students';

  /// Add or update student profile
  static Future<Map<String, dynamic>?> addOrUpdateStudent({
    required String token,
    required String mobileNumber,
    required String studyingIn,
    required String city,
    String? gender,
    String? dob,
    required String passedIn,
    File? imageFile,
  }) async {
    final uri = Uri.parse('$_baseUrl/add');

    var request = http.MultipartRequest('POST', uri);

    // Headers
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Content-Type'] = 'multipart/form-data';

    // Fields
    request.fields['mobileNumber'] = mobileNumber;
    request.fields['studyingIn'] = studyingIn;
    request.fields['city'] = city;
    if (gender != null) request.fields['gender'] = gender;
    if (dob != null) request.fields['dob'] = dob;
    request.fields['passedIn'] = passedIn;

    // Image file (optional)
    if (imageFile != null) {
      request.files.add(
        await http.MultipartFile.fromPath('file', imageFile.path),
      );
    }

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(responseBody);
      } else {
        print('Failed: ${response.statusCode} - $responseBody');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> saveCoursePreferences({
    required String token,
    List<String>? interestedStreams,
    List<String>? coursesInterested,
    String? preferredYearOfAdmission,
    String? preferredCourseLevel,
    String? modeOfStudy,
  }) async {
    try {
      final uri = Uri.parse('http://localhost:8080/api/students/preferences');
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          if (interestedStreams != null) 'interestedStreams': interestedStreams,
          if (coursesInterested != null) 'coursesInterested': coursesInterested,
          if (preferredYearOfAdmission != null)
            'preferredYearOfAdmission': preferredYearOfAdmission,
          if (preferredCourseLevel != null)
            'preferredCourseLevel': preferredCourseLevel,
          if (modeOfStudy != null) 'modeOfStudy': modeOfStudy,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("❌ Failed to save preferences: ${response.body}");
        return null;
      }
    } catch (e) {
      print("❌ Exception in saveCoursePreferences: $e");
      return null;
    }
  }

  static Future<Map<String, dynamic>?> addToFavorites({
    required String studentId,
    required String collegeId,
  }) async {
    try {
      final uri = Uri.parse('http://localhost:8080/api/students/favorites');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'studentId': studentId, 'collegeId': collegeId}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // { message, favorites }
      } else {
        print("❌ Failed to add to favorites: ${response.body}");
        return null;
      }
    } catch (e) {
      print("❌ Exception in addToFavorites: $e");
      return null;
    }
  }

  static Future<List<College>> getFavoriteColleges(String studentId) async {
    try {
      final uri = Uri.parse(
        'http://localhost:8080/api/students/favorites/$studentId',
      );
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final favoritesList = data['favorites'] as List<dynamic>;

        // Convert each favorite map to a Student object
        final students =
            favoritesList.map((item) => College.fromMap(item)).toList();

        return students; // This should be a list of college objects
      } else {
        print("❌ Failed to retrieve favorites: ${response.body}");
        return [];
      }
    } catch (e) {
      print("❌ Exception in getFavoriteColleges: $e");
      return [];
    }
  }

  static Future<bool> removeFromFavorites(
    String studentId,
    String collegeId,
  ) async {
    try {
      final uri = Uri.parse(
        'http://localhost:8080/api/students/favorites/remove',
      );
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"studentId": studentId, "collegeId": collegeId}),
      );

      if (response.statusCode == 200) {
        print("✅ College removed from favorites");
        return true;
      } else {
        print("❌ Failed to remove favorite: ${response.body}");
        return false;
      }
    } catch (e) {
      print("❌ Exception in removeFromFavorites: $e");
      return false;
    }
  }

  ///Filters
  static Future<List<dynamic>> getCollegesByRanking(String studentId) async {
    try {
      final uri = Uri.parse(
        'http://localhost:8080/api/students/ranked-colleges?studentId=$studentId',
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("✅ Colleges retrieved successfully");
        return data['colleges']; // List of college objects
      } else {
        print("❌ Failed to retrieve colleges: ${response.body}");
        return [];
      }
    } catch (e) {
      print("❌ Exception in getCollegesByRanking: $e");
      return [];
    }
  }

  static Future<List<College>> getPrivateCollegesByInterest(
    String studentId,
  ) async {
    try {
      final uri = Uri.parse(
        'http://localhost:8080/api/students/private-colleges-by-interest',
      );

      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"studentId": studentId}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("✅ Private colleges retrieved successfully");
        final favoritesList = data['colleges'] as List<dynamic>;

        // Convert each favorite map to a Student object
        final students =
            favoritesList.map((item) => College.fromMap(item)).toList();

        return students; // This should be a list of college objects
      } else {
        print("❌ Failed to fetch private colleges: ${response.body}");
        return [];
      }
    } catch (e) {
      print("❌ Exception in getPrivateCollegesByInterest: $e");
      return [];
    }
  }
}
