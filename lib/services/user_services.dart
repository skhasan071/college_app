import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class StudentService {
  static const String _baseUrl = 'http://localhost:8080/api/students';

  /// Add or update student profile
  static Future<Map<String, dynamic>?> addOrUpdateStudent({required String token, required String mobileNumber, required String studyingIn, required String city, required String gender, required String dob, String? passedIn, File? imageFile,}) async {
    final uri = Uri.parse('$_baseUrl/add-or-update');

    var request = http.MultipartRequest('POST', uri);

    // Headers
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Content-Type'] = 'multipart/form-data';

    // Fields
    request.fields['mobileNumber'] = mobileNumber;
    request.fields['studyingIn'] = studyingIn;
    request.fields['city'] = city;
    request.fields['gender'] = gender;
    request.fields['dob'] = dob;
    if (passedIn != null) {
      request.fields['passedIn'] = passedIn;
    }

    // Image file (optional)
    if (imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));
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

  static Future<Map<String, dynamic>?> saveCoursePreferences({required String token, List<String>? interestedStreams, List<String>? coursesInterested, String? preferredYearOfAdmission, String? preferredCourseLevel, String? modeOfStudy,}) async {
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
          if (preferredYearOfAdmission != null) 'preferredYearOfAdmission': preferredYearOfAdmission,
          if (preferredCourseLevel != null) 'preferredCourseLevel': preferredCourseLevel,
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

  static Future<Map<String, dynamic>?> addToFavorites({required String studentId, required String collegeId,}) async {
    try {
      final uri = Uri.parse('http://localhost:8080/api/students/favorites');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'studentId': studentId,
          'collegeId': collegeId,
        }),
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

  static Future<List<dynamic>?> getFavoriteColleges(String studentId) async {
    try {
      final uri = Uri.parse('http://localhost:8080/api/students/favorites/$studentId');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['favorites']; // This should be a list of college objects
      } else {
        print("❌ Failed to retrieve favorites: ${response.body}");
        return null;
      }
    } catch (e) {
      print("❌ Exception in getFavoriteColleges: $e");
      return null;
    }
  }

  static Future<bool> removeFromFavorites(String studentId, String collegeId) async {
    try {
      final uri = Uri.parse('http://localhost:8080/api/students/favorites/remove');
      final response = await http.post(
        uri,
        headers: { "Content-Type": "application/json" },
        body: jsonEncode({
          "studentId": studentId,
          "collegeId": collegeId,
        }),
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
      final uri = Uri.parse('http://localhost:8080/api/students/ranked-colleges?studentId=$studentId');

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

  static Future<List<dynamic>> getPrivateCollegesByInterest(String studentId) async {
    try {
      final uri = Uri.parse('http://localhost:8080/api/students/private-colleges-by-interest');

      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"studentId": studentId}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("✅ Private colleges retrieved successfully");
        return data['colleges']; // List of college objects
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
