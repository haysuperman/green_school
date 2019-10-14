/*
 * ====================================================
 * package   : Daos
 * author    : Created by nansi.
 * time      : 2019/3/23  5:38 PM 
 * remark    : 
 * ====================================================
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_school/model/ActivityProgressModel.dart';
import 'package:green_school/model/BaseModel.dart';
import 'package:green_school/model/OrderCheckModel.dart';
import 'package:green_school/model/PayInfoModel.dart';
import 'package:green_school/model/SchoolAvtivityModel.dart';
import 'package:green_school/net/Address.dart';
import 'package:green_school/net/DaoResult.dart';
import 'package:green_school/net/HttpManager.dart';
import 'package:green_school/net/ResultData.dart';

class HomeDao {
  static loadActivities(token, id,
      {OnSuccess<List<PayModel>> onSuccess, OnFailure onFailure}) async {
    ResultData res = await HttpManager.post(
        UserAddress.activities, {"id": id.toString(), "token": token});

    if (res.data == null) {
      onFailure(HttpManager.ERROR, "网络错误");
    } else {
      SchoolActivityModel activityModel =
          SchoolActivityModel.fromJson(json.decode(res.data));
      if (activityModel.code == HttpManager.SUCCESS) {
        onSuccess(
            activityModel.payModels, activityModel.code, activityModel.msg);
      } else {
        onFailure(activityModel.code, activityModel.msg);
      }
    }
  }

  //报名
  static activitySignUp(String payId, String opinion, token, id,{OnSuccess<List<PayModel>> onSuccess, OnFailure onFailure}) async {
    ResultData res = await HttpManager.post(UserAddress.signUp,
        {
          "id": id.toString(),
          "parentOpinion": opinion,
          "token": token,
          "payId": payId});

    if (res.data == null) {
      onFailure(HttpManager.ERROR, "网络错误");
    } else {
      BaseModel activityModel =
          SchoolActivityModel.fromJson(json.decode(res.data));
      if (activityModel.code == HttpManager.SUCCESS) {
        onSuccess(
            null, activityModel.code, activityModel.msg);
      } else {
        onFailure(activityModel.code, activityModel.msg);
      }
    }
  }

  // 报名进度
  static activitySignUpProgress(int activityId, token, id,
      {OnSuccess<ProgressModel> onSuccess, OnFailure onFailure}) async {
    ResultData res = await HttpManager.post(UserAddress.signUpProgress,
        {"id": id.toString(), "token": token, "activityId": activityId});

    if (res.data == null) {
      onFailure(HttpManager.ERROR, "网络错误");
    } else {
      ActivityProgressModel progressModel =
      ActivityProgressModel.fromJson(json.decode(res.data));
      if (progressModel.code == HttpManager.SUCCESS) {
        onSuccess(
            progressModel.data, progressModel.code, progressModel.msg);
      } else {
        onFailure(progressModel.code, progressModel.msg);
      }
    }
  }

  /// 获取支付信息
  static getPayInfo(id,
      {OnSuccess<PayInfo> onSuccess, OnFailure onFailure}) async {
    ResultData res =
        await HttpManager.post(UserAddress.payInfo, {"id": id.toString()});
    if (res.data == null) {
      onFailure(HttpManager.ERROR, "网络错误");
    } else {
      PayInfoModel payInfoModel = PayInfoModel.fromJson(json.decode(res.data));
      if (payInfoModel.code == HttpManager.SUCCESS) {
        onSuccess(payInfoModel.payInfo, payInfoModel.code, payInfoModel.msg);
      } else {
        onFailure(payInfoModel.code, payInfoModel.msg);
      }
    }
  }

  /// 验证支付订单
  static verifyOrderPayStatus(payId,
      {OnSuccess<String> onSuccess, OnFailure onFailure}) async {
    ResultData res = await HttpManager.post(
        UserAddress.verifyOderPayStatus, {"id": payId.toString()});
    if (res.data == null) {
      onFailure(HttpManager.ERROR, "网络错误");
//      return DaoResult(null);
      return;
    }
    OrderCheckModel orderCheckModel =
        OrderCheckModel.fromJson(json.decode(res.data));
    if (orderCheckModel.code == HttpManager.SUCCESS) {
      onSuccess(
          orderCheckModel.data, orderCheckModel.code, orderCheckModel.msg);
    } else {
      onFailure(orderCheckModel.code, orderCheckModel.msg);
    }
  }
}
