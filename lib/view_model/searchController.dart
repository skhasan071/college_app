import 'package:get/get.dart';

class SelectionController extends GetxController {
  var selectedLocations = <String>{}.obs;
  var selectedStreams = <String>{}.obs;
  var selectedCountries = <String>{}.obs;

  void toggleLocation(String item) {
    selectedLocations.contains(item)
        ? selectedLocations.remove(item)
        : selectedLocations.add(item);
  }

  void toggleStream(String item) {
    selectedStreams.contains(item)
        ? selectedStreams.remove(item)
        : selectedStreams.add(item);
  }

  void toggleCountry(String item) {
    selectedCountries.contains(item)
        ? selectedCountries.remove(item)
        : selectedCountries.add(item);
  }
}
