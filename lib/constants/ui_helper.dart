import 'package:college_app/constants/colors.dart';
import 'package:flutter/material.dart';

class UiHelper{

  static getPrimaryBtn({required title, required VoidCallback callback}){
    return ElevatedButton(onPressed: callback,
        style: ElevatedButton.styleFrom(
            backgroundColor: Clr.primaryBtnClr,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)
        ),
        child: Text(title, style: TextStyle(color: Colors.white, fontSize: 16),));
  }

  static getSecondaryBtn({required title, required VoidCallback callback}){
    return ElevatedButton(onPressed: callback, style: ElevatedButton.styleFrom(
        backgroundColor: Clr.secondaryBtnClr,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)
    ),
        child: Text(title, style: TextStyle(color: Colors.black, fontSize: 16),));
  }

  static getTextField({required hint, required controller, Icon? pre, Icon? suf}){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: Colors.black, width: 2)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: Colors.black, width: 2)),
        labelText: hint,
        labelStyle: TextStyle(color: Colors.black),
        prefixIcon: pre,
        suffixIcon: suf
      ),
    );
  }

}