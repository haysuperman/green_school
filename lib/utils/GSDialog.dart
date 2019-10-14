/*
 * ====================================================
 * package   : utils
 * author    : Created by nansi.
 * time      : 2019/3/26  2:47 PM 
 * remark    : 
 * ====================================================
 */

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:green_school/utils/Style.dart';
import 'package:green_school/widgets/LoadingDialog.dart';

class GSDialog {
  static Future<Null> showLoadingDialog(BuildContext context, String text) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog( //调用对话框
            text: text,
          );
        });
  }

  static dismiss(BuildContext context) {
    Navigator.pop(context);
  }
}