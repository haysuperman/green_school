import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:green_school/manager/UserManager.dart';
import 'package:green_school/model/User.dart';
import 'package:green_school/redux/UserRedux.dart';
import 'package:green_school/utils/NavigatorUtils.dart';
import 'package:green_school/utils/SPUtil.dart';
import 'package:package_info/package_info.dart';

import 'package:green_school/utils/Style.dart';
import 'package:green_school/redux/GSState.dart';
import 'package:green_school/utils/GSImageResource.dart';
import 'package:redux/redux.dart';

/*
 *====================================================
 * package   : views.user_page
 * author    : Created by nansi.
 * time      : 2019/2/20  2:00 PM
 * remark    :
 *====================================================
 */

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserPageState();
  }
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  List items = [
    {
      "title": "我的报名",
      "icon": Image.asset(
        GSImage.home_pay,
        color: Colors.grey,
      )
    },
    {
      "title": "关于我们",
      "icon": Icon(Icons.phone, color: Colors.grey,)
    },
    {"title": "退出", "icon": Image.asset(GSImage.home_out, color: Colors.grey)},
  ];

  @override
  bool get wantKeepAlive => true;

  ListView _initListView(store) {
    return ListView.separated(
        itemCount: items.length + 1,
        separatorBuilder: (context, index) {
          return Divider(
            height: 1,
            color: Colors.grey[200],
          );
        },
        itemBuilder: (context, index) {
          if (index == 0) {
            return _nameRow(store);
          }

          if (index == items.length) {
            return Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 20),
              child: RawMaterialButton(
                  child: ListTile(
                    title: Text(items[index - 1]["title"]),
                    leading: items[index - 1]["icon"],
                  ),
                  onPressed: () {
                    _showDialog(context, store);
                  }),
            );
          }

          return RawMaterialButton(
              fillColor: Colors.white,
              elevation: 0,
              highlightElevation: 0,
              child: ListTile(
                title: Text(items[index - 1]["title"]),
                leading: items[index - 1]["icon"],
              ),
              onPressed: () {
                switch (index) {
                  case 1:
                    NavigatorUtils.goToOrderPage(context);
                    break;
                  case 2:
                    print("hehehe");
                    PackageInfo.fromPlatform().then((value) {
                      print(value);
                      showAboutDialog(context, value);
                    });
                    break;
                }
              });
        });
  }

  showAboutDialog(BuildContext context, value) {
    value.version ??= "Null";
    showDialog(
        context: context,
        builder: (BuildContext context) => AboutDialog(
          applicationName: "绿色学校",
          applicationVersion: value.version,
          applicationIcon: new Image(image: new AssetImage(GSImage.icon), width: 50.0, height: 50.0),
          applicationLegalese: "http://lsxx.jbedu.net/index.aspx",
        ));
  }

  Widget _nameRow(store) {
    return Container(
        padding: EdgeInsets.only(top: 10, bottom: 20),
        child: RawMaterialButton(
            child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(right: 5),
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      GSImage.icon,
                      height: 100,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          store.state.user.name ?? "请先登录",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(fontSize: 18),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 3),
                          child: Text(
                            store.state.user.schoolName ?? "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                        )
                      ],
                    )),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey[400],
                    )
                  ],
                )),
            onPressed: () {
                  NavigatorUtils.goUserInfo(context);
            }));
  }

  void _showDialog(BuildContext context, Store store) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              "提示",
              style: TextStyle(fontSize: 17),
            ),
            content: Text("退出后将清空账号信息, 确定退出吗?"),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text("取消"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: Text("确定"),
                  onPressed: () {
                    UserManager.logout();
                    store.dispatch(UpdateUserAction(User.empty()));
                    Navigator.pop(context);
                    NavigatorUtils.goLogin(context);
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreBuilder<GSState>(builder: (context, store) {
      return Scaffold(
        appBar:
            AppBar(title: Text('个人中心', style: AppTextStyle.appBarTextStyle)),
        body: Container(color: Colors.grey[200], child: _initListView(store)),
      );
    });
  }
}
