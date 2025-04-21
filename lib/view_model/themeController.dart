import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:college_app/constants/customTheme.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  RxBool isColorMode = false.obs;

  CustomTheme get currentTheme =>
      isColorMode.value ? AppThemes.coloredTheme : AppThemes.blackWhiteTheme;

  static const _themeKey = 'isColorMode';

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPrefs();
  }

  void toggleTheme() async {
    isColorMode.value = !isColorMode.value;
    _saveThemeToPrefs(isColorMode.value);
  }

  Future<void> _saveThemeToPrefs(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, value);
  }

  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    isColorMode.value = prefs.getBool(_themeKey) ?? false;
  }
}
