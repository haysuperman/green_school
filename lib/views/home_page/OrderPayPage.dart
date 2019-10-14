/*
 * ====================================================
 * package   : views.home_page
 * author    : Created by nansi.
 * time      : 2019/3/26  4:51 PM 
 * remark    : 
 * ====================================================
 */

import 'package:flutter/material.dart';

import 'package:fluwx/fluwx.dart' as fluwx;

import 'package:green_school/model/PayInfoModel.dart';
import 'package:green_school/model/SchoolAvtivityModel.dart';
import 'package:green_school/utils/GSDialog.dart';
import 'package:green_school/utils/GSImageResource.dart';
import 'package:green_school/utils/NavigatorUtils.dart';
import 'package:green_school/utils/Style.dart';
import 'package:green_school/widgets/GSButton.dart';
import 'package:green_school/Daos/HomeDao.dart';
import 'package:green_school/widgets/ProgressWidget.dart';
import 'package:green_school/widgets/ToastWidget.dart';

class OrderPayPage extends StatefulWidget {
  final PayInfo payInfo;
  final PayModel payModel;

  OrderPayPage(this.payInfo, this.payModel);

  @override
  State<StatefulWidget> createState() {
    return _OrderPayPageState(payInfo, payModel);
  }
}

class _OrderPayPageState extends State<OrderPayPage> with WidgetsBindingObserver{
  final PayInfo payInfo;
  final PayModel payModel;

  bool _goToPay = false;
  bool _isFirstInactive = true;

  _OrderPayPageState(this.payInfo, this.payModel);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    fluwx.responseFromPayment.listen((response){
      if (response.errCode == -2) {
        ToastWidget.showInfo("取消支付");
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
      if (state == AppLifecycleState.inactive) {

        if (!_goToPay) {
          return;
        }

        if (_isFirstInactive) {
          _isFirstInactive = false;
          return;
        }

        _isFirstInactive = true;
        _goToPay = false;

        Future.delayed(Duration(seconds: 1), (){
          GSDialog.showLoadingDialog(context, ("正在验证支付..."));
          HomeDao.verifyOrderPayStatus(
              payModel.stuPayId,
              onSuccess: (data,  int code, String msg) {
                GSDialog.dismiss(context);
                if (data == "ok") {
                  NavigatorUtils.goToPaySuccessPage(context);
                }
              },
              onFailure: (code, err) {
                GSDialog.dismiss(context);
                ToastWidget.showInfo(err);
              });
        });
        print(state);
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          "继续支付",
          style: AppTextStyle.appBarTextStyle,
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("报名活动：${payModel.activity.title}", style: AppTextStyle.generate(15, color: Colors.grey[600])),
//                    Text(payModel.activity.periodNumber, style: AppTextStyle.generate(15),),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 15, bottom: 15),
                  child: Text("￥${payModel.activity.price}", textAlign: TextAlign.center, style: AppTextStyle.generate(30, color: Colors.deepOrange),),
                ),
              ],
            ),
          ),

          Container(child: Text("支付方式", style: AppTextStyle.generate(14, color: Colors.grey[600]),), margin: EdgeInsets.all(10),),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(0),
            child: ListTile(
              leading: Icon(GSIcon.icon_pay_wechat, color: Theme.of(context).primaryColor,),
              title: Text("微信支付", style: AppTextStyle.generate(17),),
              trailing: Icon(Icons.check_circle, color: AppColor.themeColor,),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 20, left: 40, right: 40),
        child: GSButton(
          radius: 22,
          fontSize: 17,
          minHeight: 44,
          color: AppColor.themeColor,
          absoluteWidth: 200,
          text: "继续支付",
          onPress: (){
            _payWithWeChat();
          },
        ),
      )
    );
  }

  _payWithWeChat() {
    _goToPay = true;
    fluwx.pay(
      appId: payInfo.appid,
      partnerId: payInfo.partnerid,
      prepayId: payInfo.prepayid,
      packageValue: 'Sign=WXPay',
      nonceStr: payInfo.noncestr,
      timeStamp: int.parse(payInfo.timestamp),
      sign: payInfo.sign,
    );
  }
}
