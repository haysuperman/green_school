/*
 * ====================================================
 * package   : widgets
 * author    : Created by nansi.
 * time      : 2019/4/21  4:25 PM 
 * remark    : 
 * ====================================================
 */

import 'package:flutter/material.dart';

import 'package:flutter_drag_scale/flutter_drag_scale.dart';


class ImagePreviewWidget extends StatefulWidget {
  final String url;

  ImagePreviewWidget(this.url);

  @override
  State<StatefulWidget> createState() {
    return _ImagePreviewWidgetState(url);
  }
}

class _ImagePreviewWidgetState extends State<ImagePreviewWidget> {
  final String url;
  _ImagePreviewWidgetState(this.url);

  @override
  Widget build(BuildContext context) {
    print("url--------- $url");
    return Scaffold(
      body: SafeArea(child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child:  DragScaleContainer(
                  doubleTapStillScale: true,
                  child: new Image(
                    image: new NetworkImage(url),
                  ),
                ),),
            ],
          ),
          Container(
            width: 40,
            height: 40,
            margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.white,) , onPressed: () {
                Navigator.of(context).pop();
              })
          )
        ],
      ))
    );
  }
}

