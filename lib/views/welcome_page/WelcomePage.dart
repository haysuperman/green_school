import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:green_school/Daos/LoginDaos.dart';
import 'package:green_school/net/HttpManager.dart';
import 'package:green_school/redux/GSState.dart';
import 'package:green_school/utils/NavigatorUtils.dart';
import 'package:green_school/utils/Style.dart';
import 'package:green_school/widgets/ToastWidget.dart';
import 'package:redux/redux.dart';

/*
 *====================================================
 * package   : views.welcome_page
 * author    : Created by nansi.
 * time      : 2019/2/20  2:00 PM
 * remark    :
 *====================================================
 */

class WelcomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WelcomeState();
  }
}

class _WelcomeState extends State<WelcomeWidget> {


  bool hadInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if(hadInit) {
      return;
    }
    hadInit = true;
    ///防止多次进入
    Store<GSState> store = StoreProvider.of(context);
    new Future.delayed(const Duration(seconds: 2), () {
      LoginDao.autoLogin(store, onSuccess: (user,  int code, String msg) {
        NavigatorUtils.goHome(context);
      }, onFailure: (code, err) {
        if(code != HttpManager.ERROR) {
          ToastWidget.showError(err);
        }
        NavigatorUtils.goLogin(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GSState>(
      builder: (context, store) {
        return new Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Image(image: new AssetImage('assets/icon.png'), width: 190, height: 190,),
                new CircularProgressIndicator(strokeWidth: 3, valueColor:  AlwaysStoppedAnimation(AppColor.themeColor),),
//                new CupertinoActivityIndicator(radius: 12,),
//                Text("绿色学校", style: TextStyle(fontSize: 30, color: AppColor.themeColor, fontStyle: FontStyle.italic,),)
              ],
            ),
        );
      },
    );
  }
}
