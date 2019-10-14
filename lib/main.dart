import 'package:flutter/material.dart';

import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:green_school/Daos/LoginDaos.dart';
import 'package:green_school/net/Address.dart';
import 'package:green_school/redux/GSState.dart';
import 'package:green_school/utils/Constants.dart';
import 'package:green_school/utils/SPUtil.dart';
import 'package:green_school/views/welcome_page/WelcomePage.dart';
import 'package:oktoast/oktoast.dart';
import 'package:redux/redux.dart';

import 'model/User.dart';
import 'views/tabbar_page/TabbarPage.dart';
import 'package:green_school/redux/UserRedux.dart';

void main() {

  //TODO : 切换环境
  Address.toggleEnvironment(false);

  fluwx.register(appId: AppInfo.WX_APP_KEY);
  final store = Store<GSState>(appReducer,
      initialState: GSState(
          user: User.empty(),
          themeData:
          ThemeData(brightness: Brightness.light, primaryColor: Color.fromARGB(255, 36, 191, 104))));

  runApp(MyApp(store));
}

class MyApp extends StatefulWidget {
  final Store<GSState> store;

  MyApp(this.store);

  @override
  State<StatefulWidget> createState() {
    return AppState(store);
  }
}

class AppState extends State<MyApp> {
  final Store<GSState> store;

  AppState(this.store);

  @override
  void initState() {
    super.initState();
    _initFluwx();
  }

  _initFluwx() async {
    await fluwx.register(
        appId: AppInfo.WX_APP_KEY,
        doOnAndroid: true,
        doOnIOS: true,
        enableMTA: false);
    var result = await fluwx.isWeChatInstalled();
    print("wechat is installed $result");
  }

  @override
  Widget build(BuildContext context) {

    return StoreProvider<GSState>(
        store: store,
        child: StoreBuilder<GSState>(builder: (context, store) {
          return OKToast(
            child: MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,  // 设置这一属性即可
              theme: store.state.themeData,
              home: WelcomeWidget(),
            ),
          );
        }));
  }
}
