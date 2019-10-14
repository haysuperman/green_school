/*
 *====================================================
 * package   : views.login_page
 * author    : Created by nansi.
 * time      : 2019/2/20  2:00 PM
 * remark    :
 *====================================================
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:green_school/Daos/LoginDaos.dart';
import 'package:green_school/manager/UserManager.dart';
import 'package:green_school/net/HttpManager.dart';
import 'package:green_school/redux/GSState.dart';
import 'package:green_school/redux/UserRedux.dart';
import 'package:green_school/utils/Constants.dart';
import 'package:green_school/utils/GSDialog.dart';
import 'package:green_school/utils/NavigatorUtils.dart';
import 'package:green_school/utils/SPUtil.dart';
import 'package:green_school/utils/VerifyUtils.dart';
import 'package:green_school/widgets/GSButton.dart';
import 'package:green_school/widgets/ProgressWidget.dart';
import 'package:green_school/widgets/ToastWidget.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController _studentNameController;
  TextEditingController _studentNumController;
  TextEditingController _vCodeController;
  TextEditingController _phoneController;

  Timer _timer;
  String _countDownStr = "获取验证码";
  int _countDownNum = 59;
  bool _enable = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();

    _phoneController = TextEditingController(text: "");
    _vCodeController = TextEditingController(text: "");
    _studentNumController = TextEditingController(text: "");
    _studentNameController = TextEditingController(text: "");

    _phoneController.addListener(() {
      setState(() {
        if (_timer != null && _timer.isActive) {
          return;
        }
        if (_phoneController.text.length < 11) {
          _enable = false;
        } else {
          _enable = true;
        }
      });
    });
  }

  Container _buildContainer() {
    return Container(
        margin: EdgeInsets.only(top: 100),
        child: Column(
          children: <Widget>[
            Image.asset('assets/icon.png'),
          ],
        ));
  }

  Container _buildEdit(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 30),
      child: Column(
        children: <Widget>[
          _buildTF(_studentNameController, Icons.perm_contact_calendar,
              "请输入学生姓名", 20, TextInputType.text),
          _buildTF(_studentNumController, Icons.person, "请输入学号", 20,
              TextInputType.numberWithOptions()),
          _buildTF(_phoneController, Icons.phone_android, "请输入手机号", 11,
              TextInputType.numberWithOptions()),
          _buildVCodeTF(),
        ],
      ),
    );
  }

  Container _buildTF(controller, icon, hint, maxLength, inputType) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        style: TextStyle(color: Colors.black, fontSize: 16),
        cursorColor: Colors.green,
        inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
        onChanged: (text) {
          setState(() {});
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.deepOrange, width: 5)),
          icon: Icon(icon),
          hintStyle: TextStyle(fontSize: 16),
          hintText: hint,
        ),
      ),
    );
  }

  Container _buildVCodeTF() {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: TextField(
                controller: _vCodeController,
                style: TextStyle(color: Colors.black, fontSize: 16),
                cursorColor: Colors.green,
                keyboardType: TextInputType.number,
                inputFormatters: [LengthLimitingTextInputFormatter(4)],
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  icon: Icon(Icons.verified_user),
                  hintStyle: TextStyle(fontSize: 16),
                  hintText: "请输入验证码",
                ),
                onChanged: (text) {
                  setState(() {});
                },
              ),
            ),
            GSButton(
              color: Theme.of(context).primaryColor,
              absoluteWidth: 120,
              text: _countDownStr,
              minHeight: 30,
              padding: 20,
              fontSize: 13,
              enable: _enable,
              onPress: _getVCode,
            )
          ],
        ));
  }

  Container _buildLoginBtn(store) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(top: 40),
      child: GSButton(
        color: Theme.of(context).primaryColor,
        text: "登录",
        onPress: _loginClick(store),
      ),
    );
  }

  _getVCode() {
    setState(() {
      _loading = true;
    });

    if (!VerifyUtils.verifyPhone(_phoneController.text)) {
      ToastWidget.showError("手机号码格式不正确");
      return;
    }

    GSDialog.showLoadingDialog(context, "正在获取验证码...");

    LoginDao.getVCode(_phoneController.text, onSuccess: (data, code, msg) {
      GSDialog.dismiss(context);
      ToastWidget.showSuccess(msg);
      setState(() {
        _loading = false;
      });
      _beginCountDown();
    }, onFailure: (code, msg) {
      GSDialog.dismiss(context);
      ToastWidget.showError(msg);
    });
  }

  _beginCountDown() {
    setState(() {
      _enable = false;
      _countDownStr = "重新获取($_countDownNum)";
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timer == null || !mounted) {
        return;
      }
      setState(() {
        if (_countDownNum == 0) {
          _countDownNum = 59;
          _countDownStr = "获取验证码";
          _enable = true;
          _timer.cancel();
          _timer = null;
          return;
        }
        _countDownStr = "重新获取(${_countDownNum--})";
      });
    });
  }

  _loginClick(store) {
    if (_studentNameController.text.length > 0 &&
        _studentNumController.text.length > 0 &&
        _phoneController.text.length == 11 &&
        _vCodeController.text.length == 4) {
      return () {
        _login(store);
      };
    }
    return null;
  }

  _login(store) async {
    GSDialog.showLoadingDialog(context, "正在登录...");

    return await LoginDao.login(_studentNameController.text, _phoneController.text, _vCodeController.text,
        _studentNumController.text, onSuccess: (user, int code, String msg) {
      ToastWidget.showSuccess("登录成功");
      store.dispatch(UpdateUserAction(user));
      Navigator.of(context).pop();
      NavigatorUtils.goHome(context);
      UserManager.loginSuccess(user.id, user.token);
    }, onFailure: (code, err) {
      Navigator.of(context).pop();
      ToastWidget.showError(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GSState>(builder: (context, store) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _buildContainer(),
                    _buildEdit(context),
                    _buildLoginBtn(store)
                  ],
                ),
              )));
    });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
    super.dispose();
  }
}
