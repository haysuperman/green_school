/*
 * ====================================================
 * package   : views.welcome_page
 * author    : Created by nansi.
 * time      : 2019/4/10  9:11 AM 
 * remark    : 
 * ====================================================
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:green_school/views/welcome_page/WelcomePage.dart';

class TransitionWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(microseconds: 500), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return WelcomeWidget();
      }));
    });
    return Container();
  }
}
  
 