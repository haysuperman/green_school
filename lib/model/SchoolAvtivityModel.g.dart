// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SchoolAvtivityModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchoolActivityModel _$SchoolActivityModelFromJson(Map<String, dynamic> json) {
  return SchoolActivityModel(
      (json['data'] as List)
          ?.map((e) =>
              e == null ? null : PayModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['code'],
      json['msg']);
}

Map<String, dynamic> _$SchoolActivityModelToJson(
        SchoolActivityModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.payModels
    };

PayModel _$PayModelFromJson(Map<String, dynamic> json) {
  return PayModel(
      json['activity'] == null
          ? null
          : SchoolActivity.fromJson(json['activity'] as Map<String, dynamic>),
      json['stuPayId'] as String,
      json['payCompleted'] as int)
    ..status = json['status'] as int
    ..type = json['type'] as int
    ..title = json['title'] as String
    ..price = json['price'] as String
    ..picUrl = json['picUrl'] as String;
}

Map<String, dynamic> _$PayModelToJson(PayModel instance) => <String, dynamic>{
      'activity': instance.activity,
      'stuPayId': instance.stuPayId,
      'payCompleted': instance.payCompleted,
      'status': instance.status,
      'type': instance.type,
      'title': instance.title,
      'price': instance.price,
      'picUrl': instance.picUrl
    };

SchoolActivity _$SchoolActivityFromJson(Map<String, dynamic> json) {
  return SchoolActivity(
      json['id'] as int,
      json['createAt'] as String,
      json['updateAt'] as String,
      json['DeletedAt'] as String,
      json['type'] as int,
      json['title'] as String,
      json['price'] as String,
      json['periodNumber'] as String,
      json['schoolID'] as int,
      json['schoolName'] as String,
      json['name'] as String,
      json['cellphone'] as String,
      json['password'] as String,
      json['completed'] as int,
      json['startTime'] as String,
      json['endTime'] as String,
      json['position'] as String,
      json['classSchedulePic'] as String);
}

Map<String, dynamic> _$SchoolActivityToJson(SchoolActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createAt': instance.createAt,
      'updateAt': instance.updateAt,
      'DeletedAt': instance.deletedAt,
      'type': instance.type,
      'title': instance.title,
      'price': instance.price,
      'periodNumber': instance.periodNumber,
      'schoolID': instance.schoolID,
      'schoolName': instance.schoolName,
      'name': instance.name,
      'cellphone': instance.cellphone,
      'password': instance.password,
      'completed': instance.completed,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'position': instance.position,
      'classSchedulePic': instance.classSchedulePic
    };
