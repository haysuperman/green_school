/*
 * ====================================================
 * package   : Daos
 * author    : Created by nansi.
 * time      : 2019/3/23  2:11 PM 
 * remark    : 
 * ====================================================
 */

import 'dart:async';
import 'dart:convert';

import 'package:green_school/model/BaseModel.dart';
import 'package:green_school/net/HttpManager.dart';
import 'package:green_school/net/Address.dart';
import 'package:green_school/model/User.dart';
import 'package:green_school/net/DaoResult.dart';
import 'package:green_school/utils/Constants.dart';
import 'package:green_school/utils/SPUtil.dart';
import 'package:redux/redux.dart';
import 'package:green_school/redux/UserRedux.dart';

class LoginDao {
  static getVCode(phoneNumber, {OnSuccess<User> onSuccess, OnFailure onFailure}) async {
    var res = await HttpManager.post(
        UserAddress.sendSms,
        {
          "phoneNumber": phoneNumber,
        });

    if (res.data == null) {
      onFailure(HttpManager.ERROR, "网络错误");
      return null;
    }

    BaseModel model = BaseModel.fromJson(json.decode(res.data));
    if (model.code == HttpManager.SUCCESS) {
      onSuccess(null, model.code, model.msg);
    }else {
      onFailure(model.code, model.msg);
    }
    return res.data;
  }

  static login(name, phoneNumber, smsCode, studentNumber, {OnSuccess<User> onSuccess, OnFailure onFailure}) async{
    var res = await HttpManager.post(
        UserAddress.login,
        {
          "name": name,
          "cellphone": phoneNumber,
          "studentNumber": studentNumber,
          "smsCode":smsCode
        });

    if (res.data == null) {
      onFailure(HttpManager.ERROR, "网络错误");
      return;
    }

    UserModel userModel = UserModel.fromJson(json.decode(res.data));
    if (userModel.code == HttpManager.SUCCESS) {
      onSuccess(userModel.user, userModel.code, userModel.msg);
    }else {
      onFailure(userModel.code, userModel.msg);
    }
  }

  /// 自动登录
  static autoLogin(Store store, {OnSuccess<User> onSuccess, OnFailure onFailure}) async {

    int userID = await SPUtil.getInt(AppKeys.KEY_LOGIN_ID);
    String token = await SPUtil.getString(AppKeys.KEY_LOGIN_TOKEN);

    if (userID == null) {
      onFailure(HttpManager.ERROR, "");
      return;
    }

    var res = await HttpManager.post(UserAddress.autoLogin, {
      "id": userID,
      "token": token
    });

    if (res.data == null) {
      onFailure(HttpManager.ERROR, "网络错误");
      return;
    }

    UserModel userModel = UserModel.fromJson(json.decode(res.data));
    if (userModel.code == HttpManager.SUCCESS) {
      store.dispatch(UpdateUserAction(userModel.user));
      onSuccess(userModel.user, userModel.code, userModel.msg);
    }else {
      onFailure(userModel.code, userModel.msg);
    }
  }
}
