/*
 * ====================================================
 * package   : Daos
 * author    : Created by nansi.
 * time      : 2019/4/7  12:39 PM 
 * remark    : 
 * ====================================================
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_school/model/NewsModel.dart';
import 'package:green_school/net/Address.dart';
import 'package:green_school/net/HttpManager.dart';
import 'package:green_school/net/ResultData.dart';

class NewsDao {
  static getNews({OnSuccess<List<New>> onSuccess, OnFailure onFailure}) async {
    ResultData res = await HttpManager.post(
        NewsAddress.newsList, null);

    if (res.data == null) {
      onFailure(HttpManager.ERROR, "网络错误");

    } else {
      NewsModel newsModel =
      NewsModel.fromJson(json.decode(res.data));
      if (newsModel.code == HttpManager.SUCCESS) {
        onSuccess(newsModel.data, newsModel.code, newsModel.msg);
      } else {
        onFailure(newsModel.code, newsModel.msg);
      }
    }
  }
}