import 'package:green_school/model/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'SchoolAvtivityModel.g.dart';

/*
 {
 "code": 1000,
 "msg": "查询成功",
 "data": {
  "payId": "4000000002019232901",
  "payCompleted": 0,
  "activity": {
   "id": 400000000,
   "createAt": "2019-03-22T11:30:18+08:00",
   "updatedAt": "0001-01-01T00:00:00Z",
   "DeletedAt": null,
   "type": 1,
   "title": "2019年参加国防爱国教育活动学校填报表",
   "price": "260",
   "periodNumber": "201903221130344323456",
   "schoolID": 2000000,
   "schoolName": "宁波中学",
   "name": "王世存",
   "cellphone": "18867626276",
   "password": "e10adc3949ba59abbe56e057f20f883e",
   "completed": 0
  }
 }
}
 */
@JsonSerializable()
class SchoolActivityModel extends BaseModel {
  @JsonKey(name: "data")
  List<PayModel> payModels;

  SchoolActivityModel(this.payModels, code, msg) : super(code, msg);

  factory SchoolActivityModel.fromJson(Map<String, dynamic> json) =>
      _$SchoolActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$SchoolActivityModelToJson(this);
}

@JsonSerializable()
class PayModel {
  SchoolActivity activity;
  String stuPayId;
  int payCompleted;
  int status;
  int type;
  String title;
  String price;
  String picUrl;

  PayModel(this.activity, this.stuPayId, this.payCompleted);

  factory PayModel.fromJson(Map<String, dynamic> json) =>
      _$PayModelFromJson(json);

  Map<String, dynamic> toJson() => _$PayModelToJson(this);
}

@JsonSerializable()
class SchoolActivity {
  int id;
  String createAt;
  String updateAt;
  @JsonKey(name: "DeletedAt")
  String deletedAt;
  int type;
  String title;
  String price;
  String periodNumber;
  int schoolID;
  String schoolName;
  String name;
  String cellphone;
  String password;
  int completed;
  String startTime;
  String endTime;
  String position;
  String classSchedulePic;


  SchoolActivity(this.id, this.createAt, this.updateAt, this.deletedAt,
      this.type, this.title, this.price, this.periodNumber, this.schoolID,
      this.schoolName, this.name, this.cellphone, this.password, this.completed,
      this.startTime, this.endTime, this.position, this.classSchedulePic);

  factory SchoolActivity.fromJson(Map<String, dynamic> json) =>
      _$SchoolActivityFromJson(json);

  Map<String, dynamic> toJson() => _$SchoolActivityToJson(this);
}
