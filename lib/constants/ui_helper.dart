import 'package:college_app/constants/colors.dart';
import 'package:college_app/view_model/themeController.dart';
import 'package:flutter/material.dart';

class UiHelper {
  static getPrimaryBtn({
    required String title,
    required VoidCallback callback,
    IconData? icon,
  }) {
    return icon != null
        ? ElevatedButton.icon(
          onPressed: callback,
          icon: Icon(icon, color: Colors.white, size: 18),
          label: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Clr.primaryBtnClr,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
        )
        : ElevatedButton(
          onPressed: callback,
          style: ElevatedButton.styleFrom(
            backgroundColor: Clr.primaryBtnClr,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        );
  }

  static getSecondaryBtn({
    required title,
    required VoidCallback callback,
    IconData? icon,
  }) {
    return ElevatedButton(
      onPressed: callback,
      style: ElevatedButton.styleFrom(
        backgroundColor: Clr.secondaryBtnClr,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        side: const BorderSide(color: Colors.black),
      ),
      child: Text(title, style: TextStyle(color: Colors.black, fontSize: 16)),
    );
  }

  static getTextField({
    required hint,
    required controller,
    Icon? pre,
    Icon? suf,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        labelText: hint,
        labelStyle: TextStyle(color: Colors.black),
        prefixIcon: pre,
        suffixIcon: suf,
      ),
    );
  }

  static getNavItem({
    required label,
    required icon,
    required VoidCallback callback,
    required selected,
  }) {
    return GestureDetector(
      onTap: callback,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color:
                  selected
                      ? ThemeController.to.currentTheme.bottonNav
                      : Colors.white,
            ),
            child: Icon(
              icon,
              color: selected ? Colors.black : Colors.black,
              size: selected ? 28 : 24,
            ),
          ),
          SizedBox(height: 5),
          Text(label, style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

  static getCard({required double width, required widget}) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: widget,
    );
  }
}
