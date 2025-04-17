import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/Faculty.dart';
import '../model/Hostel.dart';
import '../model/Placement.dart';
import '../model/admission_process.dart';
import '../model/campus.dart';
import '../model/college.dart';
import '../model/course.dart';

class CollegeServices {

  static const String _baseUrl = 'http://localhost:8080/api/colleges/';

  /// Get all colleges
  static Future<List<College>> getColleges() async {
    final url = Uri.parse('${_baseUrl}all');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((e) => College.fromMap(e)).toList();
      } else {
        print('Error fetching colleges: ${response.statusCode} == ${response.body}');
        return [];
      }
    } catch (e) {
      print('Exception: $e');
      return [];
    }
  }

  ///Get Filters
  static Future<List<College>> filterColleges({required List<String> interestedStreams, List<String>? coursesInterested, String? type,}) async {
    final url = Uri.parse('${_baseUrl}filter');

    try {
      final response = await http.post(
        url,
        headers: { 'Content-Type': 'application/json' },
        body: jsonEncode({
          'interestedStreams': interestedStreams,
          'coursesInterested': coursesInterested,
          'type': type,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body)['colleges'];
        return jsonData.map((e) => College.fromMap(e)).toList();
      } else {
        print('Filter failed: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception: $e');
      return [];
    }
  }

  static Future<List<College>> filterCollegesByRanking({required String stream, String? ranking,}) async {
    final uri = Uri.parse('${_baseUrl}colleges/filter-by-ranking')
        .replace(queryParameters: {
      'stream': stream,
      if (ranking != null) 'ranking': ranking,
    });

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        return data.map((college) => College.fromMap(college)).toList();
      } else {
        print('Error: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Exception while filtering colleges by ranking: $e');
      return [];
    }
  }

  static Future<List<College>> filterCollegesByStream({required String stream, String? country, String? state, String? city,}) async {
    final uri = Uri.parse('${_baseUrl}colleges/filter-by-stream').replace(
      queryParameters: {
        'stream': stream,
        if (country != null) 'country': country,
        if (state != null) 'state': state,
        if (city != null) 'city': city,
      },
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        return data.map((college) => College.fromMap(college)).toList();
      } else {
        print('Error: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Exception while filtering colleges by stream: $e');
      return [];
    }
  }

  static Future<List<College>> predictColleges({required String examType, required String category, required String rankType, required dynamic rankOrPercentile,}) async {
    final uri = Uri.parse('${_baseUrl}predict');

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'examType': examType,
          'category': category,
          'rankType': rankType,
          'rankOrPercentile': rankOrPercentile,
        }),
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        final colleges = data.map((item) => College.fromMap(item as Map<String, dynamic>)).toList();
        return colleges;
      } else {
        print('Error: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Exception during college prediction: $e');
      return [];
    }
  }

  /// Get College Details Page
  static Future<AdmissionProcess?> getAdmissionProcess(String collegeId) async {
    final url = Uri.parse('$_baseUrl$collegeId/admission-process');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return AdmissionProcess.fromMap(data);
      } else if (response.statusCode == 404) {
        print('Admission process not found');
        return null;
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  static Future<List<Course>> getCoursesByCollege(String collegeId) async {
    final url = Uri.parse('${_baseUrl}courses/$collegeId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((e) => Course.fromMap(e)).toList();
      } else {
        print('No courses found or college not found: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception: $e');
      return [];
    }
  }

  static Future<List<Faculty>> getFacultyByCollege(String collegeId) async {
    final url = Uri.parse('${_baseUrl}faculty/$collegeId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((e) => Faculty.fromMap(e)).toList();
      } else {
        print('Failed to load faculty: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception: $e');
      return [];
    }
  }

  static Future<List<Placement>> getPlacementByCollege(String collegeId) async {
    final url = Uri.parse('${_baseUrl}placement/$collegeId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((e) => Placement.fromMap(e)).toList();
      } else {
        print('Failed to load placement data: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception: $e');
      return [];
    }
  }

  static Future<Hostel?> getHostelByCollege(String collegeId) async {
    final url = Uri.parse('${_baseUrl}hostel/$collegeId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return Hostel.fromMap(json.decode(response.body));
      } else {
        print('Hostel not found: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception while fetching hostel: $e');
      return null;
    }
  }

  static Future<Campus?> getCampusByCollege(String collegeId) async {
    final url = Uri.parse('${_baseUrl}campus/$collegeId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return Campus.fromMap(json.decode(response.body));
      } else {
        print('Campus not found: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception while fetching campus: $e');
      return null;
    }
  }

}
