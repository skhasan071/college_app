import 'dart:convert';
import 'dart:io';
import 'package:college_app/model/user.dart';
import 'package:college_app/view/Filters&Compare/colleges.dart';
import 'package:http/http.dart' as http;

import '../model/college.dart';
import '../model/review.dart';

class StudentService {
  static const String _baseUrl = 'http://localhost:8080/api/students';

  Future<Student?> fetchStudentById(String id) async {
    final url = Uri.parse('$_baseUrl/get/$id'); // Update with your actual backend URL

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return Student.fromMap(data);
      } else {
        print('Failed to load student: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }

  Future<Student?> getStudent(token) async {

    try{

      final res = await http.get(
        Uri.parse("$_baseUrl/verify-user/$token"),
        headers: {
          "Content-Type":"application/json",
          "authorization":"Bearer $token"
        }
      );

      if(res.statusCode == 200 || res.statusCode == 201){

        print(jsonDecode(res.body));

        Map<String, dynamic> data = jsonDecode(res.body) as Map<String, dynamic>;

        return Student.fromMap(data);

      }else{
        print(jsonDecode(res.body));
        return null;
      }

    }catch(err){
      print(err);
      return null;
    }

  }

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
      final uri = Uri.parse('http://localhost:8080/api/students/favorites/add');
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

  static Future<bool> removeFromFavorites(String studentId, String collegeId,) async {
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


  Future<Review?> postReview(Review review) async {
    final url = Uri.parse('http://localhost:8080/api/colleges/reviews');

    try{

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(review.toJson()),
      );

      if (response.statusCode == 201) {
        print("Review added: ${response.body}");
        return Review.fromJson(jsonDecode(response.body)['review']);
      } else {
        print("Failed to post review: ${response.statusCode} ${response.body}");
        return null;
      }

    }catch(err){
      print(err);
      return null;
    }
  }

  Future<List<Review>> getReviews(String uid) async {
    final url = Uri.parse('http://localhost:8080/api/colleges/reviews/getAll/$uid');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List decoded = jsonDecode(response.body);
      return decoded.map((json) => Review.fromJson(json)).toList();
    } else {
      print("Failed to fetch reviews: ${response.statusCode} ${response.body}");
      return [];
    }
  }

  ///Filters
  static Future<List<College>> getCollegesByRanking(String studentId) async {
    try {
      final uri = Uri.parse(
        'http://localhost:8080/api/students/rankings?studentId=$studentId',
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<dynamic> list = data['colleges'];
        return list.map((item){
          print(item);
          return College.fromMap(item);
        }).toList();
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
        'http://localhost:8080/api/students/private-colleges',
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
