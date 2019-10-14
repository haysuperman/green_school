/*
 * ====================================================
 * package   : Daos
 * author    : Created by nansi.
 * time      : 2019/4/4  11:21 AM 
 * remark    : 
 * ====================================================
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_school/model/ActivityScoreModel.dart';
import 'package:green_school/model/PaymentListModel.dart';
import 'package:green_school/net/Address.dart';
import 'package:green_school/net/HttpManager.dart';
import 'package:green_school/net/ResultData.dart';

class ActivityDao {
  static getPaymentList(token, id, {OnSuccess<List<PaymentModel>> onSuccess, OnFailure onFailure}) async {
    ResultData res = await HttpManager.post(
        HomeAddress.payList, {"id": id.toString(), "token": token});

    if (res.data == null) {
      onFailure(HttpManager.ERROR, "网络错误");

    } else {
      PaymentListModel activityModel =
      PaymentListModel.fromJson(json.decode(res.data));
      if (activityModel.code == HttpManager.SUCCESS) {
        onSuccess(activityModel.data, activityModel.code, activityModel.msg);
      } else {
        onFailure(activityModel.code, activityModel.msg);
      }
    }
  }

  static getActivityScore(token, id, activityId,{OnSuccess<ActivityScore> onSuccess, OnFailure onFailure}) async {
    ResultData res = await HttpManager.post(
        HomeAddress.score, {"id": id.toString(), "token": token, "activityId":activityId});

    if (res.data == null) {
      onFailure(HttpManager.ERROR, "网络错误");

    } else {
      ActivityScoreModel activityModel =
      ActivityScoreModel.fromJson(json.decode(res.data));
      if (activityModel.code == HttpManager.SUCCESS) {
        onSuccess(activityModel.score, activityModel.code, activityModel.msg);
      } else {
        onFailure(activityModel.code, activityModel.msg);
      }
    }
  }
}