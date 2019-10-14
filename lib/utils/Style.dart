import 'package:flutter/material.dart';

/*
 * ====================================================
 * package   : utils
 * author    : Created by nansi.
 * time      : 2019/2/21  9:56 AM
 * remark    :
 * ====================================================
 */

class AppColor {
  static const Color themeColor = Color.fromARGB(255, 36, 191, 104);
  static const int tabBarSelectedColor = 0xFF1B5E20;
}

class AppTextStyle {
  static const appBarTextStyle = TextStyle(color: Colors.white);
  static const appBarItemTextStyle = TextStyle(color: Colors.white, fontSize: 13);

  static TextStyle generate(double fontSize , {Color color = Colors.black, }) {
    return TextStyle(color: color, fontSize: fontSize);
  }
}

class AppThemeData {
  static const appBarIconThemeData = IconThemeData(color: Colors.white);
}


