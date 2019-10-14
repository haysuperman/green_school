// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ActivityProgressModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityProgressModel _$ActivityProgressModelFromJson(
    Map<String, dynamic> json) {
  return ActivityProgressModel(
      json['data'] == null
          ? null
          : ProgressModel.fromJson(json['data'] as Map<String, dynamic>),
      json['code'],
      json['msg']);
}

Map<String, dynamic> _$ActivityProgressModelToJson(
        ActivityProgressModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data
    };

ProgressModel _$ProgressModelFromJson(Map<String, dynamic> json) {
  return ProgressModel(json['payCount'] as int, json['total'] as int);
}

Map<String, dynamic> _$ProgressModelToJson(ProgressModel instance) =>
    <String, dynamic>{'payCount': instance.payCount, 'total': instance.total};
