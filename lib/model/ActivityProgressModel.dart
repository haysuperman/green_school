import 'package:green_school/model/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ActivityProgressModel.g.dart';

@JsonSerializable()
class ActivityProgressModel extends BaseModel{
  ProgressModel data;

  ActivityProgressModel(this.data, code, msg) : super(code, msg);

  factory ActivityProgressModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityProgressModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityProgressModelToJson(this);
}

@JsonSerializable()
class ProgressModel {
  int payCount;
  int total;

  ProgressModel.empty();

  ProgressModel(this.payCount, this.total);

  factory ProgressModel.fromJson(Map<String, dynamic> json) =>
      _$ProgressModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProgressModelToJson(this);
}