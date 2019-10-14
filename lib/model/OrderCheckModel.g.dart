// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderCheckModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCheckModel _$OrderCheckModelFromJson(Map<String, dynamic> json) {
  return OrderCheckModel(json['data'] as String, json['code'], json['msg']);
}

Map<String, dynamic> _$OrderCheckModelToJson(OrderCheckModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data
    };
