// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ActivityModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) {
  return ActivityModel(
      (json['data'] as List)
          ?.map((e) =>
              e == null ? null : Activity.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['code'],
      json['msg']);
}

Map<String, dynamic> _$ActivityModelToJson(ActivityModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data
    };

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  return Activity(
      json['activityId'] as int,
      json['stuPayId'] as String,
      json['status'] as int,
      json['type'] as int,
      json['title'] as String,
      json['price'] as String,
      json['picUrl'] as String);
}

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'activityId': instance.activityId,
      'stuPayId': instance.stuPayId,
      'status': instance.status,
      'type': instance.type,
      'title': instance.title,
      'price': instance.price,
      'picUrl': instance.picUrl
    };
