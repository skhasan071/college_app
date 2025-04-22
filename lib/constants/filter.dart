import 'package:college_app/constants/colors.dart';
import 'package:college_app/view_model/filterController.dart';
import 'package:college_app/view_model/themeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Filter extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const Filter({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(FilterController());

    return Obx(() {
      final theme = ThemeController.to.currentTheme;
      final bool selected = controller.isSelected(title);

      return GestureDetector(
        onTap: () {
          controller.selectFilter(title);
          if (onTap != null) onTap!();
        },
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: selected ? theme.filterSelectedColor : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            title,
            style: TextStyle(
              color: selected ? theme.filterTextColor : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    });
  }
}
