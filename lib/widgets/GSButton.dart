/*
 * ====================================================
 * package   : widgets
 * author    : Created by nansi.
 * time      : 2019/3/19  5:50 PM 
 * remark    : 
 * ====================================================
 */

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class GSButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color disableColor;
  final Color textColor;
  final Color disableTextColor;
  final VoidCallback onPress;
  final double fontSize;
  final double elevation;
  final double padding;
  final double radius;
  final double minHeight;
  final double absoluteWidth;
  final bool enable;

  GSButton(
      {Key key,
      this.text,
      this.color,
      this.textColor = Colors.white,
      this.disableTextColor = Colors.white,
      this.disableColor = Colors.grey,
      this.onPress,
      this.fontSize = 15,
      this.elevation = 0,
      this.padding = 80,
      this.minHeight = 36,
      this.absoluteWidth,
      this.enable = true,
      this.radius = 18})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: absoluteWidth ?? null,
      child: CupertinoButton(
        minSize: minHeight,
        color: color,
        pressedOpacity: 0.8,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize, color: textColor),
        ),
        disabledColor: disableColor,
        padding:
            EdgeInsets.only(left: padding, right: padding, top: 0, bottom: 0),
        onPressed: enable?onPress:null,
      ),
    );
  }
}
