/*
 * ====================================================
 * package   : utils
 * author    : Created by nansi.
 * time      : 2019/4/26  3:17 PM 
 * remark    : 
 * ====================================================
 */

import 'package:flutter/material.dart';

class VerifyUtils {
  static bool verifyPhone(phone) {
    return new RegExp("^^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199|(147))\\d{8}\$").hasMatch(phone);
  }
}