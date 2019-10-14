// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
      json['data'] == null
          ? null
          : User.fromJson(json['data'] as Map<String, dynamic>),
      json['code'],
      json['msg']);
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.user
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      json['id'] as int,
      json['name'] as String,
      json['schoolName'] as String,
      json['studentNumber'] as String,
      json['class'] as String,
      json['gender'] as int,
      json['token'] as String,
      json['cellphone'] as String);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'schoolName': instance.schoolName,
      'studentNumber': instance.studentNumber,
      'class': instance.className,
      'gender': instance.gender,
      'token': instance.token,
      'cellphone': instance.cellphone
    };
