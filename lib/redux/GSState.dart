/*
 * ====================================================
 * package   : redux
 * author    : Created by nansi.
 * time      : 2019/2/28  9:31 AM
 * remark    :
 * ====================================================
 */

import 'package:flutter/material.dart';
import 'package:green_school/model/User.dart';
import 'package:green_school/redux/UserRedux.dart';
import 'package:green_school/redux/ThemeDataRedux.dart';

class GSState {
    User user;
    ThemeData themeData;

    GSState({this.user, this.themeData});
}

GSState appReducer(GSState state, action){
    return GSState(
      user : UserReducer(state.user, action),
      themeData: ThemeDataReducer(state.themeData, action)
    );
}
