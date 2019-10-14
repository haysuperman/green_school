/*
 * ====================================================
 * package   : views.user_page
 * author    : Created by nansi.
 * time      : 2019/4/22  11:25 AM 
 * remark    : 
 * ====================================================
 */

import 'package:flutter/material.dart';
import 'package:green_school/manager/UserManager.dart';
import 'package:green_school/utils/Style.dart';

class UserInfoWidget extends StatelessWidget {
  List _infoList;

  @override
  Widget build(BuildContext context) {
    _infoList = [
      {
        "title" : "姓名:",
        "value" : UserManager.instance.user.name
      },
      {
        "title" : "学号:",
        "value" : UserManager.instance.user.studentNumber
      },
      {
        "title" : "班级:",
        "value" : UserManager.instance.user.className
      },
      {
        "title" : "学校:",
        "value" : UserManager.instance.user.schoolName
      }
    ];
    return Scaffold(
      appBar: AppBar(title: Text("个人信息", style: AppTextStyle.appBarTextStyle), iconTheme: AppThemeData.appBarIconThemeData,),
      body: Container(
        child: ListView.builder(
            itemCount: _infoList.length,
            itemBuilder: (context, index) {
            return Container(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 1),
              child: ListTile(
                title: Text(_infoList[index]["title"]),
                trailing: Text(_infoList[index]["value"], style: TextStyle(color: Colors.grey),),
              ),
            );
        }),
      ),
    );
  }
}
  
 