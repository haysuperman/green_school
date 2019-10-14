/*
 * ====================================================
 * package   : views.home_page
 * author    : Created by nansi.
 * time      : 2019/4/4  1:10 PM 
 * remark    : 
 * ====================================================
 */

import 'package:flutter/material.dart';
import 'package:green_school/manager/UserManager.dart';
import 'package:green_school/model/ActivityScoreModel.dart';
import 'package:green_school/model/SchoolAvtivityModel.dart';
import 'package:green_school/utils/Style.dart';

class ActivityScorePage extends StatefulWidget {
  final ActivityScore score;
  final SchoolActivity activity;

  ActivityScorePage(this.score, this.activity);

  @override
  State<StatefulWidget> createState() {
    return _ActivityScorePageState(score, activity);
  }
}

class _ActivityScorePageState extends State<ActivityScorePage> {
  final ActivityScore score;
  final SchoolActivity activity;

  _ActivityScorePageState(this.score, this.activity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        iconTheme: AppThemeData.appBarIconThemeData,
        title: Text("${activity.title}成绩评定", style: AppTextStyle.appBarTextStyle,),
      ),
      body: Container(
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: Colors.white ,
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Text("姓名：${UserManager.instance.user.name}", maxLines: 1, style: AppTextStyle.generate(17),),
                  Expanded(child: Text(activity.createAt.substring(0, 10), textAlign: TextAlign.end, style: AppTextStyle.generate(15, color: Colors.grey),))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                color: Colors.white,child: Text("学校：${activity.schoolName}", style: AppTextStyle.generate(17),)),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                color: Colors.white,child: Text("期号：${activity.periodNumber}", style: AppTextStyle.generate(17),)),

            Expanded(flex: 1,
                child: activity.type == 0 ? _buildPatriotismView():_buildSocialTrainingView())
            
          ],
        ),
      ),
    );
  }

  //爱国主义教育
  _buildPatriotismView() {
    return  ListView(
        children: <Widget>[
          _buildTile("爱国主义考核成绩", score.patriotismEducationLevel)
        ],
      );
  }

  // 社会主义时间活动
  _buildSocialTrainingView() {
    return  ListView(
      children: <Widget>[
        _buildTile("安全防灾知识笔试测试", score.safetyFangzaizijiubishiLevel),
        _buildTile("防灾自救技能测试", score.safetyFangzaizijiuLevel),
        _buildTile("消防自救技能测试", score.safetyXiaofangzijiuLevel),
        _buildTile("交通自护技能测试", score.safetyJiaotongzihuLevel),
        _buildTile("常见急救措施测试", score.safetyChangjianjijiuLevel),
        _buildTile("积极参加活动，态度端正", score.socialInitiativeLevel),
        _buildTile("团结协作、诚实守信", score.socialSolidarityLevel),
        _buildTile("弘扬个性、创新性", score.socialPersonalityLevel),
        _buildTile("独立性", score.socialIndependenceLevel),
        _buildTile("安全教育考核成绩", score.safetyEducationComprehensiveLevel),
        _buildTile("社会实践考核成绩", score.socialTrainingComprehensiveLevel),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("奖惩情况", style: AppTextStyle.generate(16),),
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 10, right: 10,top: 10, bottom: 20),
            child: Text(score.socialRewardAndPunishment)
        )
        
      ],
    );
  }


  _buildTile(title, value) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: BorderDirectional(bottom: BorderSide(width: 1, color: Colors.grey[300]))
      ),
      child: ListTile(
        leading: Text(title, style:AppTextStyle.generate(16),),
        trailing: _transformScore(value),
      ),
    );
  }

 Text _transformScore(raw) {
    String text = "未评测";
    Color color = Colors.grey;
    if (raw == "good") {
      text = "优秀";
      color = AppColor.themeColor;

    } else if (raw == "pass") {
      text = "及格";
      color = AppColor.themeColor;

    } else if (raw == "fail") {
      text = "不及格";
      color = Colors.red[400];
    }

    return Text(text, style: AppTextStyle.generate(16,color: color),);
  }
}
