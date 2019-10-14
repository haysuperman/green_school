/*
 * ====================================================
 * package   : model
 * author    : Created by nansi.
 * time      : 2019/2/28  10:26 AM 
 * remark    : 
 * ====================================================
 */

import 'package:json_annotation/json_annotation.dart';

part 'Info.g.dart';

@JsonSerializable()
class Info{
  String ha;

  Info(this.ha);
}