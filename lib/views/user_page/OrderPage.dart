/*
 * ====================================================
 * package   : views.home_page
 * author    : Created by nansi.
 * time      : 2019/3/20  3:21 PM 
 * remark    : 
 * ====================================================
 */

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:green_school/Daos/ActivityDao.dart';
import 'package:green_school/manager/UserManager.dart';
import 'package:green_school/model/PaymentListModel.dart';
import 'package:green_school/redux/GSState.dart';
import 'package:green_school/utils/GSDialog.dart';
import 'package:green_school/utils/Style.dart';
import 'package:green_school/widgets/ProgressWidget.dart';
import 'package:green_school/widgets/ToastWidget.dart';
import 'package:redux/redux.dart';

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderPageState();
  }
}

class _OrderPageState extends State<OrderPage> {
  List orders = [];

  @override
  void initState() {
    super.initState();
    _getPaymentList();
  }

  Store<GSState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
//    GSDialog.showLoadingDialog(context, "正在加载中..");
    return Scaffold(
      appBar: AppBar(
          title: Text("我的报名", style: AppTextStyle.appBarTextStyle),
          iconTheme: AppThemeData.appBarIconThemeData),
      body: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            PaymentModel model = orders[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
              margin: EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Container(
                padding: EdgeInsets.only(top: 15, bottom: 10, left: 12, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    _buildPayInfo("报名活动", model.title),
                    _buildPayInfo("报名费用", "${model.price}元"),
//                    Divider(height: 18, color: Colors.grey),
//                    Divider(height: 4, color: Colors.white),
//                    GSButton(text: "查看详情",minHeight: 27, fontSize: 14, color: Theme.of(context).primaryColor, padding: 30, onPress: () {
//                    })
                  ],
                ),
              ),
            );
          }),
    );
  }

  _getPaymentList() {
    ActivityDao.getPaymentList(
        UserManager.instance.user.token,
        UserManager.instance.user.id,
        onSuccess: (list,  int code, String msg) {
//          GSDialog.dismiss(context);
          setState(() {
            orders.addAll(list);
          });
        }, onFailure: (code, msg) {
      GSDialog.dismiss(context);
      ToastWidget.showError(msg);
    });
  }

  _buildPayInfo(title, value) {
    return Container(
        margin: EdgeInsets.only(bottom: 5),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Text(title, style: TextStyle(fontSize: 16, color: Colors.grey)),
            Expanded(child: Text(value, style: TextStyle(fontSize: 16), textAlign: TextAlign.right,), flex: 1)
          ],
        )
    );
  }
}
