import 'package:get/get.dart';

class saveController extends GetxController {
  var savedColleges = <String>{}.obs;

  void toggleSave(String collegeName) {
    if (savedColleges.contains(collegeName)) {
      savedColleges.remove(collegeName);
    } else {
      savedColleges.add(collegeName);
    }
  }

  bool isSaved(String collegeName) {
    return savedColleges.contains(collegeName);
  }
}
