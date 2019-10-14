/*
 * ====================================================
 * package   : views.home_page
 * author    : Created by nansi.
 * time      : 2019/3/20  5:50 PM 
 * remark    : 
 * ====================================================
 */

import 'package:flutter/material.dart';
import 'package:green_school/manager/UserManager.dart';

import 'package:green_school/utils/GSImageResource.dart';
import 'package:green_school/widgets/GSButton.dart';

class PaySuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserManager.shouldRefresh = true;
    return Scaffold(
      appBar: AppBar(
        title: Text("支付结果"),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 80, left: 0, right: 0, bottom: 20),
              child: Image.asset(GSImage.pay_success),
              height: 100,
              width: 100),
          Text("支付成功",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "恭喜你，支付成功",
              style: TextStyle(fontSize: 17, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 150, left: 60, right: 60),
            child: GSButton(
              text: "确定",
              color: Theme.of(context).primaryColor,
              padding: 40,
              onPress: () {
                Navigator.pop(context, {

                });
              },
            ),
          )
        ],
      ),
    );
  }
}
