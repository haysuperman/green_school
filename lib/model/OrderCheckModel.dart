import 'package:green_school/model/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'OrderCheckModel.g.dart';

@JsonSerializable()
class OrderCheckModel extends BaseModel{

  String data;

  OrderCheckModel(this.data, code, msg) :super(code, msg);

  factory OrderCheckModel.fromJson(Map<String, dynamic> json) =>
      _$OrderCheckModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCheckModelToJson(this);
}