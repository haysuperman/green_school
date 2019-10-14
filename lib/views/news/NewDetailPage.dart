/*
 * ====================================================
 * package   : views.news
 * author    : Created by nansi.
 * time      : 2019/4/8  9:05 AM 
 * remark    : 
 * ====================================================
 */

import 'package:flutter/material.dart';
import 'package:green_school/utils/Style.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewDetailPage extends StatelessWidget{
  final String title;
  final String url;

  NewDetailPage(this.title, this.url);

  @override
  Widget build(BuildContext context) {
    print(url);
    return Scaffold(
      appBar: AppBar(title: Text(title, style: AppTextStyle.appBarTextStyle,), iconTheme: AppThemeData.appBarIconThemeData,),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}