import 'package:green_school/model/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ActivityModel.g.dart';
/*
  {
   "stuPayId": "120190006",
   "status": 0,
   "type": 1,
   "title": "国防爱国教育",
   "price": "300",
   "picUrl": "aiguo"
  }
   */
@JsonSerializable()
class ActivityModel extends BaseModel{
  List<Activity> data;


  ActivityModel(this.data, code, msg): super(code, msg);

  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);
}

@JsonSerializable()
class Activity{
  int activityId;
  String stuPayId;
  int status;
  int type;
  String title;
  String price;
  String picUrl;

  Activity(this.activityId, this.stuPayId, this.status, this.type, this.title, this.price,
      this.picUrl);

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}