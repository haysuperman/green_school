import 'package:green_school/model/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'NewsModel.g.dart';

@JsonSerializable()
class NewsModel extends BaseModel{

  List<New> data;


  NewsModel(this.data, code, msg):super(code, msg);

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}

@JsonSerializable()
class New {

  int id;
  String createAt;
  String title;
  String firstPicture;
  String article;

  New(this.id, this.createAt, this.title, this.firstPicture, this.article);

  factory New.fromJson(Map<String, dynamic> json) =>
      _$NewFromJson(json);

  Map<String, dynamic> toJson() => _$NewToJson(this);
}