import 'package:get/get.dart';

class FilterController extends GetxController {
  var selectedFilter = ''.obs;

  void selectFilter(String title) {
    selectedFilter.value = title;
  }

  bool isSelected(String title) => selectedFilter.value == title;
}
