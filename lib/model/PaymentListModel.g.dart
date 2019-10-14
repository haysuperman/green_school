// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PaymentListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentListModel _$PaymentListModelFromJson(Map<String, dynamic> json) {
  return PaymentListModel(
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : PaymentModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['code'],
      json['msg']);
}

Map<String, dynamic> _$PaymentListModelToJson(PaymentListModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data
    };

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) {
  return PaymentModel(json['title'] as String, json['price'] as String);
}

Map<String, dynamic> _$PaymentModelToJson(PaymentModel instance) =>
    <String, dynamic>{'title': instance.title, 'price': instance.price};
