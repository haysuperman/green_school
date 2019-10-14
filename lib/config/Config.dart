/*
 * ====================================================
 * package   : config
 * author    : Created by nansi.
 * time      : 2019/3/19  4:02 PM
 * remark    :
 * ====================================================
 */

import 'package:green_school/net/Address.dart';

class Config {
  static bool debug = true;

  static toggleEnvironment(bool isDebug) {
    debug = isDebug;
    Address.toggleEnvironment(isDebug);
  }
}