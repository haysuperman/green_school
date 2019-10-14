import 'package:green_school/model/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class UserModel extends BaseModel{
  @JsonKey(name: "data")
  User user;

  UserModel(this.user, code, msg) : super(code, msg);

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}


@JsonSerializable()
class User {
  int id;
  String name;
  String schoolName;
  String studentNumber;

  @JsonKey(name: "class")
  String className;

  int gender;
  String token;
  String cellphone;


  User(this.id, this.name, this.schoolName, this.studentNumber, this.className,
      this.gender, this.token, this.cellphone);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  // 命名构造函数
  User.empty() {
    this.id = 0;
    this.name = "";
    this.schoolName = "";
    this.studentNumber = "";
    this.className = "";
    this.gender = 0;
    this.token = "";
    this.cellphone = "";
  }
}