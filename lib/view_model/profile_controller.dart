import 'package:college_app/model/user.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{

  var isFullProfileEnable = false.obs;
  Rxn<Student> profile = Rxn<Student>();
  Rx<String> userToken = "".obs;

}