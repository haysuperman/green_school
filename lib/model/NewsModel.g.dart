// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NewsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) {
  return NewsModel(
      (json['data'] as List)
          ?.map(
              (e) => e == null ? null : New.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['code'],
      json['msg']);
}

Map<String, dynamic> _$NewsModelToJson(NewsModel instance) => <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data
    };

New _$NewFromJson(Map<String, dynamic> json) {
  return New(
      json['id'] as int,
      json['createAt'] as String,
      json['title'] as String,
      json['firstPicture'] as String,
      json['article'] as String);
}

Map<String, dynamic> _$NewToJson(New instance) => <String, dynamic>{
      'id': instance.id,
      'createAt': instance.createAt,
      'title': instance.title,
      'firstPicture': instance.firstPicture,
      'article': instance.article
    };
