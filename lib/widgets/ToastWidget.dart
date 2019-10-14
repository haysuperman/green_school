/*
 * ====================================================
 * package   : widgets
 * author    : Created by nansi.
 * time      : 2019/3/23  1:40 PM 
 * remark    : 
 * ====================================================
 */

import 'package:flutter/material.dart';
import 'package:green_school/utils/Style.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:oktoast/oktoast.dart';

enum Gravity {
  TOP,
  CENTER,
  BOTTOM
}

class ToastWidget {
  static showError(msg, {int millisecond = 2500}) {
    showToast(
        msg,
        textPadding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
        backgroundColor: Colors.red,
        duration: Duration(milliseconds: millisecond),
        position: ToastPosition(align: Alignment.bottomCenter),
        dismissOtherToast: true
    );
  }

  static showSuccess(msg) {
    showToast(
      msg,
      textPadding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      backgroundColor: AppColor.themeColor,
      position: ToastPosition(align: Alignment.bottomCenter),
      dismissOtherToast: true
    );
  }

  static showInfo(msg, {Color color, Gravity gravity = Gravity.CENTER, int duration}) {
    if (color == null) {
      color = Colors.grey[500];
    }

    showToast(
        msg,
        textPadding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
        backgroundColor: color,
        position: _transformGravity(gravity),
        dismissOtherToast: true
    );
  }


  static _transformGravity(Gravity gravity) {
    switch (gravity) {
      case Gravity.TOP : {
        return ToastPosition(align: Alignment.topCenter);
      }
      case Gravity.CENTER : {
        return ToastPosition(align: Alignment.center, offset: 200);
      }
      case Gravity.BOTTOM : {
        return ToastPosition(align: Alignment.bottomCenter);
      }
    }
  }

}