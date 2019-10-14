/*
 * ====================================================
 * package   : utils
 * author    : Created by nansi.
 * time      : 2019/3/19  4:55 PM 
 * remark    : 
 * ====================================================
 */

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_school/model/PayInfoModel.dart';
import 'package:green_school/views/home_page/ActivitiesPage.dart';
import 'package:green_school/views/home_page/ActivityScorePage.dart';
import 'package:green_school/views/home_page/HomePage.dart';
import 'package:green_school/views/news/NewDetailPage.dart';
import 'package:green_school/views/user_page/OrderPage.dart';
import 'package:green_school/views/home_page/PaySuccessPage.dart';
import 'package:green_school/views/home_page/PaymentPage.dart';
import 'package:green_school/model/SchoolAvtivityModel.dart';
import 'package:green_school/views/login_page/LoginPage.dart';
import 'package:green_school/views/tabbar_page/TabbarPage.dart';
import 'package:green_school/views/home_page/OrderPayPage.dart';
import 'package:green_school/views/user_page/UserInfoWidget.dart';
import 'package:green_school/widgets/ImagePreviewWidget.dart';
import 'package:path/path.dart';

class NavigatorUtils {
  ///替换
  static Future pushReplacement(BuildContext context, Widget widget) {
    return Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => widget));
  }

  /// 系统push
  static Future iosPush(BuildContext context, Widget widget) {
    return Navigator.push(context, new CupertinoPageRoute(builder: (context) => widget));
  }
  
  static Future modelRoute(BuildContext context, routeName) {
    return Navigator.pushNamed(context, routeName);
  }

  /// material push
  static Future materialPush(BuildContext context, Widget widget) {
    return Navigator.push(context, new MaterialPageRoute(builder: (context) => widget));
  }
  
  /// 主页
  static Future goHome(BuildContext context) {
    return pushReplacement(context, TabBarPage());
  }

  /// 登录
  static Future goLogin(BuildContext context) {
    return pushReplacement(context, LoginPage());
  }

  /// 活动报名
  static Future goToActivitySignUp(BuildContext context, PayModel payModel) {
      return materialPush(context, ActivitiesPage(payModel));
  }

  /// 支付界面
  static Future goToPaymentPage(BuildContext context, PayModel payModel) {
    return pushReplacement(context, PaymentPage(payModel));
  }

  /// 支付未完成 订单界面
  static Future goOrderPayPage(BuildContext context, PayInfo payInfo, PayModel payModel) {
    return pushReplacement(context, OrderPayPage(payInfo, payModel));
  }

  /// 支付成功
  static Future goToPaySuccessPage(BuildContext context) {
    return pushReplacement(context, PaySuccessPage());
  }

  /// 我的缴费
  static goToOrderPage(BuildContext context) {
    materialPush(context, OrderPage());
  }

  /// 查看成绩
  static goToScore(BuildContext context, score, activity) {
    materialPush(context, ActivityScorePage(score, activity));
  }

  /// 资讯详情
  static goNewsDetail(BuildContext context, title, url) {
    materialPush(context, NewDetailPage(title, url));
  }

  /// 资讯详情
  static goPreview(BuildContext context, url) {
    materialPush(context, ImagePreviewWidget(url));
  }


  /// 个人信息
  static goUserInfo(BuildContext context) {
    materialPush(context, UserInfoWidget());
  }
}