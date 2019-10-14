import 'dart:async';

import 'package:flutter/material.dart';

import 'package:green_school/utils/Style.dart';
import 'package:green_school/utils/GSImageResource.dart';
import 'package:green_school/views/home_page/HomePage.dart';
import 'package:green_school/views/user_page/UserPage.dart';
import 'package:green_school/widgets/ToastWidget.dart';
import 'package:green_school/views/news/NewsPage.dart';

/*
 * ====================================================
 * package   : views.tabbar_page
 * author    : Created by nansi.
 * time      : 2019/2/20  5:36 PM 
 * remark    : 
 * ====================================================
 */

class TabBarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TabBarState();
  }
}

class TabBarState extends State<TabBarPage> {
  int _selectedTab;

  static Color selectedColor = Color(AppColor.tabBarSelectedColor);
  static Color unselectedColor = Colors.grey;

  List _tabData = [
    {
      'text': '活动详情',
      'icon': Icon(GSIcon.icon_list, size: 19,),
//      'icon': new Icon(Icons.home, color: unselectedColor),
      'activeIcon': new Icon(
        GSIcon.icon_list,
        size: 19,
        color: selectedColor,
      )
    },
    {
      'text': '资讯',
      'icon': Icon(GSIcon.icon_news, size: 19,),
//      'icon': new Icon(Icons.home, color: unselectedColor),
      'activeIcon': new Icon(
        GSIcon.icon_news,
        size: 19,
        color: selectedColor,
      )
    },
    {
      'text': '个人中心',
//      'icon': GSImage.tabbar_home,
      'icon': new Icon(GSIcon.icon_user, size: 19, color: unselectedColor),
      'activeIcon': new Icon(GSIcon.icon_user, size: 19, color: selectedColor)
    }
  ];

  @override
  void initState() {
    super.initState();
    _selectedTab = 0;
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      items: _tabBarItems(),
      currentIndex: _selectedTab,
      onTap: (index) {
        if (_selectedTab != index) {
          setState(() {
            _selectedTab = index;
          });
        }
      },
    );
  }

  List<BottomNavigationBarItem> _tabBarItems() {
    List<BottomNavigationBarItem> myTabs = [];
    for (int i = 0; i < _tabData.length; i++) {
      myTabs.add(BottomNavigationBarItem(
          icon: _getTabBarIcon(i),
          title: _getTabBarTitle(i),
          activeIcon: _getTabBarActiveIcon(i)));
    }
    return myTabs;
  }

  Icon _getTabBarIcon(currentIndex) {
    return _tabData[currentIndex]['icon'];
  }

  Icon _getTabBarActiveIcon(currentIndex) {
    return _tabData[currentIndex]['activeIcon'];
  }

  Text _getTabBarTitle(currentIndex) {
    if (currentIndex == _selectedTab) {
      return Text(_tabData[currentIndex]['text'],
          style: TextStyle(color: selectedColor));
    } else {
      return Text(_tabData[currentIndex]['text'],
          style: TextStyle(color: unselectedColor));
    }
  }

  int _lastClickTime = 0;
  Future<bool> _onWillPop() {
    int nowTime = new DateTime.now().microsecondsSinceEpoch;
    if (_lastClickTime != 0 && nowTime - _lastClickTime > 1500) {
      return new Future.value(true);
    } else {
      _lastClickTime = new DateTime.now().microsecondsSinceEpoch;
      new Future.delayed(const Duration(milliseconds: 1500), () {
        _lastClickTime = 0;
      });
      ToastWidget.showInfo("再次点击退出应用", gravity: Gravity.BOTTOM);
      return new Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
        body:
        IndexedStack(
          children: <Widget>[HomePage(), NewsPage(),UserPage()],
          index: _selectedTab,
        ),
        bottomNavigationBar: Material(
          color: Theme
              .of(context)
              .primaryColor,
          child: _bottomNavigationBar(),
        )
    ), onWillPop: _onWillPop);
  }
}
