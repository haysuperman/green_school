/*
 * ====================================================
 * package   : views.home_page
 * author    : Created by nansi.
 * time      : 2019/3/20  10:10 AM 
 * remark    : 
 * ====================================================
 */

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:fluwx/fluwx.dart' as fluwx;

import 'package:green_school/Daos/HomeDao.dart';
import 'package:green_school/manager/UserManager.dart';
import 'package:green_school/utils/GSDialog.dart';
import 'package:green_school/utils/GSImageResource.dart';
import 'package:green_school/utils/NavigatorUtils.dart';
import 'package:green_school/widgets/GSButton.dart';
import 'package:green_school/utils/Constants.dart';
import 'package:green_school/widgets/ToastWidget.dart';
import 'package:green_school/model/SchoolAvtivityModel.dart';
import 'package:green_school/model/PayInfoModel.dart';

class PaymentPage extends StatefulWidget {
  final PayModel payModel;

  PaymentPage(this.payModel);

  @override
  State<StatefulWidget> createState() {
    return _PaymentPageState(payModel);
  }
}

class _PaymentPageState extends State<PaymentPage> {
  final PayModel payModel;
  PayInfo _payInfo;

  final double _fontSize = 16.0;
  int _checkIndex = 0;

  _PaymentPageState(this.payModel);

  @override
  void initState() {
    super.initState();
    fluwx.responseFromPayment.listen((response) {
      print("-------- $response");
      if (response.errCode == -2) {
        if (_payInfo != null) {
          Future.delayed(Duration(seconds: 1), () {
            NavigatorUtils.goOrderPayPage(context, _payInfo, payModel);
          });
        }
      } else if (response.errCode == 0) {
        GSDialog.showLoadingDialog(context, ("正在验证支付..."));
        HomeDao.verifyOrderPayStatus(payModel.stuPayId,
            onSuccess: (data,  int code, String msg) {
          GSDialog.dismiss(context);
          if (data == "ok") {
            NavigatorUtils.goToPaySuccessPage(context);
          }
        }, onFailure: (code, err) {
          GSDialog.dismiss(context);
        });
      }
      print(response.errCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("报名缴费"),
        backgroundColor: Colors.white,
      ),
      body: _buildListView(context),
    );
  }

  ListView _buildListView(BuildContext context) {
    return ListView(children: <Widget>[
      _buildTitle("报名信息"),
      _buildPayInfo("项目名称", payModel.activity.title),
      Divider(height: 1),
      _buildPayInfo("报名金额", "${payModel.activity.price}元"),
      Container(
        height: 3,
        color: Theme.of(context).primaryColor,
      ),
      _buildTitle("选择支付方式"),
      _buildPayWay("微信支付", 0),
      Divider(
        height: 1,
        indent: 10,
      ),
//      _buildPayWay("支付宝支付", 1),
      Container(
        margin: EdgeInsets.only(top: 40, left: 60, right: 60),
        child: GSButton(
          text: "确认支付",
          color: Theme.of(context).primaryColor,
          onPress: () {
            _payWithWeChat();
//            NavigatorUtils.goToPaySuccessPage(context);
          },
        ),
      )
    ]);
  }

  _buildTitle(title) {
    return ListTile(
      dense: true,
      leading: Text(
        title,
        style: TextStyle(fontSize: _fontSize),
      ),
      contentPadding: EdgeInsets.only(left: 16, right: 16),
    );
  }

  _buildPayInfo(title, value) {
    return Container(
        color: Colors.white,
        child: ListTile(
          dense: true,
          leading: Text(
            title,
            style: TextStyle(fontSize: _fontSize, color: Colors.grey),
          ),
          trailing: SizedBox(
            child: Text(
              value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: _fontSize),
            ),
            width: 230,
          ),
          contentPadding: EdgeInsets.only(left: 16, right: 16),
        ));
  }

  _buildPayWay(title, int index) {
    return RaisedButton(
        color: Colors.white,
        elevation: 0,
        highlightElevation: 0,
        child: Container(
          height: 50,
          child: Row(
            children: <Widget>[
              index == _checkIndex
                  ? Icon(
                      Icons.check_circle,
                      color: Theme.of(context).primaryColor,
                    )
                  : Icon(
                      Icons.radio_button_unchecked,
                      color: Colors.grey[400],
                    ),
              Container(
                  child: index == 0
                      ? Icon(GSIcon.icon_pay_wechat,
                          size: 20, color: Theme.of(context).primaryColor)
                      : Icon(GSIcon.icon_pay_ali, color: Colors.blue),
                  margin: EdgeInsets.only(left: 16, right: 16)),
              Text(
                title,
                style: TextStyle(fontSize: _fontSize),
              )
            ],
          ),
        ),
        onPressed: () {
          setState(() {
            _checkIndex = index;
          });
        });
  }

  _payWithWeChat() {
    HomeDao.getPayInfo(payModel.stuPayId, onSuccess: (data, int code, String msg) {
      print("appid-------${data.appid}");
      print("partner-------${data.partnerid}");
      print("prepay-------${data.prepayid}");
      print("nonce-------${data.noncestr}");
      print("timestamp-------${data.timestamp}");
      print("sign-------${data.sign}");
      _payInfo = data;
      fluwx.pay(
        appId: data.appid,
        partnerId: data.partnerid,
        prepayId: data.prepayid,
        packageValue: 'Sign=WXPay',
        nonceStr: data.noncestr,
        timeStamp: int.parse(data.timestamp),
        sign: data.sign,
      );
    }, onFailure: (code, err) {
      ToastWidget.showError(err);
    });
  }
}
