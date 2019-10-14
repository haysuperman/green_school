/*
 * ====================================================
 * package   : views.news
 * author    : Created by nansi.
 * time      : 2019/4/7  12:14 PM 
 * remark    : 
 * ====================================================
 */

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:green_school/Daos/NewsDao.dart';
import 'package:green_school/model/NewsModel.dart';
import 'package:green_school/net/Address.dart';
import 'package:green_school/utils/NavigatorUtils.dart';
import 'package:green_school/utils/Style.dart';

class NewsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewsPageState();
  }
}

class _NewsPageState extends State<NewsPage> {
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();

  List<New> newList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "资讯",
          style: AppTextStyle.appBarTextStyle,
        ),
      ),
      body: EasyRefresh(
        firstRefresh: true,
        child: ListView.builder(
            itemCount: newList.length,
            itemBuilder: (context, index) {
              New model = newList[index];
              return _buildRows(model, index == newList.length - 1, index);
            }),
        behavior: ScrollOverBehavior(),
        onRefresh: _loadNews,
        refreshHeader: _buildRefreshHeader(),
      ),
    );
  }

  _buildRefreshHeader() {
    return ClassicsHeader(
      key: _headerKey,
      refreshText: "下拉刷新",
      refreshReadyText: "松开加载更多资讯",
      refreshingText: "正在加载" + "...",
      refreshedText: "加载完成",
//      moreInfo: "updateAt",
      bgColor: Colors.transparent,
      textColor: Colors.black87,
      moreInfoColor: Colors.black54,
      showMore: true,
    );
  }

  _buildRows(New model, bool isLast, int index) {
    var titles = ["爱国主义教育专栏", "社会实践活动专栏"];
    var list = ["https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1554878545&di=5e4a986fa4ed5e8e6caf1eb0980d9d4b&src=http://i7.hexun.com/2018-09-30/194460719.jpg","http://imgsrc.baidu.com/imgad/pic/item/0823dd54564e9258bb8483fd9682d158ccbf4e74.jpg" ];
    return Card(
      elevation: 4.0,
      //设置shape，这里设置成了R角
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),),
      //对Widget截取的行为，比如这里 Clip.antiAlias 指抗锯齿
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: isLast ? 10 : 0),
      child: MaterialButton(
            padding: EdgeInsets.all(0),
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
//                      _newImage(list[index]),
                      _newImage(Address.pic_prefix + model.firstPicture),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
//                          titles[index],
                          model.title ,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0, right: 8.0, bottom: 8.0),
                        child: Text(model.createAt.substring(0, 10), style: AppTextStyle.generate(15, color: Colors.grey),),
                      )
                    ],
            ),
            onPressed: () {
//              NavigatorUtils.goNewsDetail(context, model.title, NewsAddress.news_prefix + model.article);
              NavigatorUtils.goNewsDetail(context, model.title, "http://lsxx.jbedu.net/newsInfo.aspx?pkId=980");
            }),
    );
  }

  _newImage(url) {
    print(url);
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: Container(
        child: LimitedBox(
          maxHeight: 200,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: url,
            placeholder: (context, url) {
              return Container(height: 150, child: new Icon(Icons.image, size: 80, color: Colors.grey[300],));
          },
            errorWidget: (context, url, error) {
              return Container(height: 150, child: new Icon(Icons.error, size: 80,));
            },
          ),
        ),
      ),
    );
  }

  Future<void> _loadNews() async {
    NewsDao.getNews(
        onSuccess: (data, code, msg) {
          setState(() {
            newList.clear();
            newList.addAll(data);
            print(newList.length);
          });
        },
        onFailure: (code, msg) {});
  }
}
