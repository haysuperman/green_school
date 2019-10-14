/*
 * ====================================================
 * package   : manager
 * author    : Created by nansi.
 * time      : 2019/3/27  6:39 PM 
 * remark    : 
 * ====================================================
 */

import 'package:flutter/material.dart';
import 'package:green_school/model/User.dart';
import 'package:green_school/utils/Constants.dart';

import 'package:green_school/utils/SPUtil.dart';

class UserManager {
  static bool shouldRefresh = false;
  User user;

  factory UserManager() =>_getInstance();
  static UserManager get instance => _getInstance();
  static UserManager _instance;
  UserManager._internal() {
    // 初始化
  }
  static UserManager _getInstance() {
    if (_instance == null) {
      _instance = new UserManager._internal();
      _instance.user = User.empty();
    }
    return _instance;
  }

  static loginSuccess(id, token) async {
    SPUtil.setInt(AppKeys.KEY_LOGIN_ID, id);
    SPUtil.setString(AppKeys.KEY_LOGIN_TOKEN, token);
  }

  static logout() async{
    await SPUtil.remove(AppKeys.KEY_LOGIN_ID);
    await SPUtil.remove(AppKeys.KEY_LOGIN_TOKEN);
  }
}