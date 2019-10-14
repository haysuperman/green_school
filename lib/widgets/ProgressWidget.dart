/*
 * ====================================================
 * package   : widgets
 * author    : Created by nansi.
 * time      : 2019/3/23  11:04 AM 
 * remark    : 
 * ====================================================
 */

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProgressWidget extends StatelessWidget {
  final Widget childView;
  final bool isShow;

  ProgressWidget({Key key, this.childView, this.isShow}): assert(childView != null), super(key: key);


  _widgetList() {
    List<Widget> list = List();
    list.add(childView);
    if(isShow) {
      list.add( Opacity(
          opacity: 0.5,
          child: Container(color: Colors.black87,)));

      list.add(Center(
        child: Container(
          child: SpinKitFadingCircle(
            itemBuilder: (_, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.white : Colors.white,
                ),
              );
            },
          ),
        ),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _widgetList()
    );
  }
}
