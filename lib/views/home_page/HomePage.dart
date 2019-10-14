import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:green_school/Daos/ActivityDao.dart';
import 'package:green_school/Daos/HomeDao.dart';
import 'package:green_school/manager/UserManager.dart';
import 'package:green_school/model/ActivityScoreModel.dart';
import 'package:green_school/model/SchoolAvtivityModel.dart';
import 'package:green_school/net/Address.dart';
import 'package:green_school/redux/GSState.dart';
import 'package:green_school/utils/Constants.dart';
import 'package:green_school/utils/GSDialog.dart';
import 'package:green_school/utils/GSImageResource.dart';
import 'package:green_school/utils/NavigatorUtils.dart';
import 'package:green_school/utils/Style.dart';
import 'package:green_school/views/login_page/LoginPage.dart';
import 'package:green_school/widgets/ToastWidget.dart';
import 'package:redux/redux.dart';

/*
 * ====================================================
 * package   : views.home_page
 * author    : Created by nansi.
 * time      : 2019/2/20  6:43 PM 
 * remark    : 
 * ====================================================
 */
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  ScrollController _refreshController;

  bool isGreen = false;
  List<PayModel> _activities = List();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  Store<GSState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  void deactivate() {
    if (UserManager.shouldRefresh) {
      _loadActivities();
      print("刷新");
      UserManager.shouldRefresh = false;
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreBuilder<GSState>(
      builder: (context, store) {
        return Scaffold(
          backgroundColor: Colors.grey[200],
            appBar: AppBar(
              title: Text('首页', style: AppTextStyle.appBarTextStyle),
              actions: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 5),
                  child: Row(children: <Widget>[
                    Text(store.state.user.schoolName, style: AppTextStyle.appBarItemTextStyle,),
                    Icon(Icons.location_on, size:16 , color: Colors.white,)
                  ],),
                )
              ],
            ),
            body: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Expanded(flex: 1, child: _buildEasyRefresh())
              ],
            ));
      },
    );
  }

  EasyRefresh _buildEasyRefresh() {
    return EasyRefresh(
      autoLoad: false,
      firstRefresh: true,
      outerController: _refreshController,
      behavior: ScrollOverBehavior(),
      refreshHeader: _buildHeader(),
//          refreshFooter: _buildFooter(),
      onRefresh: _onRefresh,
//          loadMore: () {},
      child: ListView.builder(
          itemCount: _activities.length,
          itemBuilder: (context, index) {
            PayModel payModel = _activities[index];
            return _buildCard(payModel, index, context);
          }),
    );
  }

  Card _buildCard(PayModel payModel, int index, BuildContext context) {
    return Card(
            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: RawMaterialButton(
                child: Container(
                  padding:
                      EdgeInsets.only(left: 12, right: 10, bottom: 10),
                  margin: EdgeInsets.all(0),
                  child: _buildItem(index, payModel),
                ),
                onPressed: () {
                  PayModel payActivity = _activities[index];

                  NavigatorUtils.goToActivitySignUp(context, payActivity);
                  return;
                }),
          );
  }

  _buildHeader() {
    return ClassicsHeader(
      key: _headerKey,
      refreshText: "下拉刷新",
      refreshReadyText: "松开刷新活动",
      refreshingText: "正在加载" + "...",
      refreshedText: "加载完成",
//      moreInfo: "updateAt",
      bgColor: Colors.transparent,
      textColor: Colors.black87,
      moreInfoColor: Colors.black54,
      showMore: true,
    );
  }

  _buildItem(index, PayModel payModel) {
    bool isSignUp = payModel.status > 2 && payModel.status != 4;
    String title = "查看详情" ;
    SchoolActivity activity = payModel.activity;
    Color currentColor =  isSignUp ? AppColor.themeColor : Colors.grey[600];
    String periodStr = activity.periodNumber == null || activity.periodNumber.length == 0 ? "暂无" : activity.periodNumber;
    String address = activity.position == null || activity.position.length == 0 ? "暂无" : activity.position;
    String registerTime = "${activity.startTime.substring(0, 10)} ~ ${activity.endTime.substring(0, 10)}";

    String stateString;
    switch (payModel.status) {
      case 0: //不能报名的
        stateString = "当前不可报名";
        currentColor = Colors.grey[600];
        if (payModel.stuPayId == null || payModel.stuPayId.length == 0) {
          registerTime = "暂未设置时间";
        }
        break;
      case 1: //未报名的
        stateString = "未报名";
        currentColor = AppColor.themeColor;
        break;
      case 2: //报名未缴费的
        stateString = "未缴费";
        currentColor = Colors.orange[600];
        break;
      case 3: //已缴费的
        stateString = "已缴费";
        currentColor = Colors.red[600];
        break;
      case 4: //已缴费的
        stateString = "已超过缴费时间";
        currentColor = Colors.grey[600];
        break;
      default:
        stateString = "";
    }

    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(35))
                        ),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: Address.pic_prefix + payModel.picUrl,
                          placeholder: (context, url) {
                            return Container(height: 150, child: new Icon(Icons.image, size: 80, color: Colors.grey[300],));
                          },
                          errorWidget: (context, url, error) {
                            return Container(height: 150, child: new Icon(Icons.error, size: 80,));
                          },
                        ),
                      ),
                     Container(width: 10,),
                     Expanded(child:
                     Column(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Text(
                           _activities[index].title,
                           maxLines: 1,
                           overflow: TextOverflow.ellipsis,
                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                         ),
                         Container(height: 10,),
                         Text(
                           "期号: $periodStr",
                           style: AppTextStyle.generate(14, color: Colors.grey[600]),
                         ),
                         Container(height: 3,),
                         Text(
                           "起止时间: $registerTime",
//                           "起止时间: 2019年4月1日~2019年4月3日",
                           style: AppTextStyle.generate(14, color: Colors.grey[600]),
                         ),
                         Container(height: 3,),
                         Text(
                           "集合地点: $address",
//                           "集合地点: 海蓝宝重创空间",
                           style: AppTextStyle.generate(14, color: Colors.grey[600]),
                         ),
                       ],
                     ),)
                    ],
                  )
                ],
              ),
              Divider(height: 21, color: Colors.grey[400],),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(title, style: AppTextStyle.generate(16, color: currentColor)),
                  Container(width: 6,),
                  Icon(Icons.arrow_forward_ios, size: 18, color: currentColor,)
                ],
              )
            ],
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(GSIcon.icon_tag, color: currentColor,),
            Container(
              margin: EdgeInsets.only(right: 5, top: 5),
                child: Text(stateString, style: AppTextStyle.generate(14, color: currentColor),))
          ],
        )
      ],
    );
  }

  _buildFooter() {
    return ClassicsFooter(
      key: _footerKey,
      loadText: "pushToLoad",
      loadReadyText: "releaseToLoad",
      loadingText: "loading",
      loadedText: "loaded",
      noMoreText: "noMore",
      moreInfo: "updateAt",
      bgColor: Colors.transparent,
      textColor: Colors.black87,
      moreInfoColor: Colors.black54,
      showMore: true,
    );
  }

  Future<void> _onRefresh() async {
    _loadActivities();
  }

  _loadActivities() {
    HomeDao.loadActivities(
        _getStore().state.user.token, _getStore().state.user.id,
        onSuccess: (data, int code, String msg) {
      setState(() {
        _activities.clear();
        _activities.addAll(data);
      });
    }, onFailure: (code, err) {
      ToastWidget.showError(err);
    });
  }
}
