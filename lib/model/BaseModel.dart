import 'package:json_annotation/json_annotation.dart';

part 'BaseModel.g.dart';

@JsonSerializable()
class BaseModel {
  int code;
  String msg;

  BaseModel(this.code, this.msg);

  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseModelToJson(this);
}