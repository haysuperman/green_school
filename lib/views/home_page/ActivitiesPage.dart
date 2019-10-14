/*
 * ====================================================
 * package   : views.home_page
 * author    : Created by nansi.
 * time      : 2019/3/19  4:49 PM 
 * remark    : 
 * ====================================================
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:green_school/Daos/ActivityDao.dart';
import 'package:green_school/Daos/HomeDao.dart';
import 'package:green_school/manager/UserManager.dart';
import 'package:green_school/model/ActivityProgressModel.dart';
import 'package:green_school/model/ActivityScoreModel.dart';
import 'package:green_school/net/Address.dart';
import 'package:green_school/utils/GSDialog.dart';
import 'package:green_school/utils/StringUtils.dart';
import 'package:green_school/utils/Style.dart';
import 'package:green_school/widgets/ToastWidget.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:green_school/widgets/GSButton.dart';
import 'package:green_school/utils/NavigatorUtils.dart';
import 'package:green_school/model/SchoolAvtivityModel.dart';

class ActivitiesPage extends StatefulWidget {
  final PayModel payModel;

  ActivitiesPage(this.payModel);

  @override
  State<StatefulWidget> createState() {
    return _ActivitiesPageState(payModel);
  }
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  final PayModel payModel;

  ProgressModel progressModel;

  TextEditingController _editController;

  bool _isCheck = false;

  _ActivitiesPageState(this.payModel);

  @override
  void initState() {
    super.initState();
    _editController = new TextEditingController();
  }

  _buildWebView() {
    String url = "${UserAddress.parentBook}?type=${payModel.type}";

//    String url = "http://www.baidu.com";
    print("webview ---- $url");

    return WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("报名须知"),
          actions: <Widget>[
            RawMaterialButton(
                child: Text("课程表"),
                onPressed: () {
                  if (StringUtils.isEmpty(payModel.activity.classSchedulePic)) {
                    ToastWidget.showInfo("暂无课程表");
                    return;
                  }
                  NavigatorUtils.goPreview(context,
                      Address.pic_prefix + payModel.activity.classSchedulePic);
                })
          ],
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: _buildWebView(),
                ),
              ),
              _buildProgress(),
              _buildRemarkText(),
              _buildCheckOptions(context),
              _bottomItems(payModel.status)
            ],
          ),
        ));
  }

  Offstage _buildCheckOptions(BuildContext context) {
    return Offstage(
      offstage: !(payModel.status == 1),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Checkbox(
                value: _isCheck,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (value) {
                  setState(() {
                    _isCheck = !_isCheck;
                  });
                }),
          ),
          Text("本人已阅读并同意协议")
        ],
      ),
    );
  }

  _buildRemarkText() {
    if (payModel.status != 1) {
      return Container();
    }
//    opinion
    return Column(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.grey[200],
            ),
            child: TextField(
              controller: _editController,
              maxLines: 3,
              maxLength: 50,
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(8, 5, 0, 0),
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 14),
                hintText: "备注内容,最多50字",
              ),
            ))
      ],
    );
  }

  _bottomItems(int state) {
    switch (state) {
      case 1:
        return Container(
            margin: EdgeInsets.only(bottom: 50, left: 50, right: 50),
            child: GSButton(
              text: "报名并缴费",
              color: Theme.of(context).primaryColor,
              disableColor: Colors.grey[400],
              onPress: _isCheck
                  ? (() {
                      HomeDao.activitySignUp(
                          payModel.stuPayId,
                          _editController.text == null? "" : _editController.text,
                          UserManager.instance.user.token,
                          UserManager.instance.user.id,
                          onSuccess: (data, code, msg) {
                        UserManager.shouldRefresh = true;
                        NavigatorUtils.goToPaymentPage(context, payModel);
                      }, onFailure: (code, msg) {
                        ToastWidget.showError(msg);
                      });
                    })
                  : null,
            ));
      case 2:
        return Container(
            margin: EdgeInsets.only(bottom: 50, left: 50, right: 50),
            child: GSButton(
              text: "去缴费",
              color: Theme.of(context).primaryColor,
              onPress: (() {
                NavigatorUtils.goToPaymentPage(context, payModel);
              }),
            ));
      case 3:
        return Container(
            margin: EdgeInsets.only(bottom: 50, left: 50, right: 50),
            child: GSButton(
              text: "查看成绩",
              color: Theme.of(context).primaryColor,
              onPress: (() {
                _checkScore();
              }),
            ));
      case 4:
        return Container(
            margin: EdgeInsets.only(bottom: 50, left: 50, right: 50),
            child: GSButton(
              text: "已超过缴费时间",
              color: Theme.of(context).primaryColor,
              onPress: null,
            ));
      default:
        return Container(
            margin: EdgeInsets.only(bottom: 50, left: 50, right: 50),
            child: GSButton(
              padding: 15,
              text: "当前不能进行报名，请联系班主任",
              color: Theme.of(context).primaryColor,
              onPress: null,
            ));
    }
  }

  _checkScore() {
    GSDialog.showLoadingDialog(context, "正在获取成绩..");
    ActivityDao.getActivityScore(
        UserManager.instance.user.token,
        UserManager.instance.user.id,
        payModel.activity.id, onSuccess: (data, int code, String msg) {
      GSDialog.dismiss(context);
      if (data == null) {
        data = ActivityScore.mock();
//                            ToastWidget.showInfo(msg);
//                            NavigatorUtils.goToScore(context, ActivityScore.mock(), payActivity.activity);
//                            return;
      }
      NavigatorUtils.goToScore(context, data, payModel.activity);
    }, onFailure: (code, msg) {
      ToastWidget.showError(msg);
      GSDialog.dismiss(context);
    });
  }

  _buildProgress() {
    if (payModel.status == 0) {
      return Container();
    }

    if (payModel.status > 0 && progressModel == null) {
      HomeDao.activitySignUpProgress(payModel.activity.id,
          UserManager.instance.user.token, UserManager.instance.user.id,
          onSuccess: (data, int code, String msg) {
        setState(() {
          progressModel = data;
        });
      }, onFailure: (code, msg) {
        ToastWidget.showError(msg);
      });
    }

    String text = "0 / 0";

    if (progressModel != null) {
      text = "${progressModel.payCount} / ${progressModel.total}";
    }

    return Offstage(
      offstage: false,
      child: Container(
        padding: EdgeInsets.only(right: 15, bottom: 15),
        child: Text(
          "报名进度： $text",
          textAlign: TextAlign.end,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
