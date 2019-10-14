/*
 * ====================================================
 * package   : utils
 * author    : Created by nansi.
 * time      : 2019/3/23  9:36 AM 
 * remark    : 
 * ====================================================
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPUtil {
  static setString(key, String value) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(key, value);
  }

  static Future<String> getString(key) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

  static Future<bool> remove(key) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }

  static setInt(key, int value) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setInt(key, value);
  }

  static Future<int> getInt(key) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key);
  }

  static setBool(key, value) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool(key, value);
  }

  static Future<bool> getBool(key) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key);
  }
}