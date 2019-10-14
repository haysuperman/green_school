/*
 * ====================================================
 * package   : widgets
 * author    : Created by nansi.
 * time      : 2019/3/27  4:09 PM 
 * remark    : 
 * ====================================================
 */

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:green_school/utils/Style.dart';

// ignore: must_be_immutable
class LoadingDialog extends Dialog {
  String text;

  LoadingDialog({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Material(
        color: Colors.transparent,
        child: WillPopScope(
          onWillPop: () => new Future.value(false),
          child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    height: 100.0,
                    padding: new EdgeInsets.only(top:5.0, bottom: 5, left: 13, right: 13),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      //用一个BoxDecoration装饰器提供背景图片
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(child: SpinKitCircle(color: AppColor.themeColor)),
                        new Container(height: 10.0),
                        new Container(child: new Text(text, style: AppTextStyle.generate(16, color: Colors.black))),
                      ],
                    ),
                  ),
                ],
              )
          ),
        ));
  }
}