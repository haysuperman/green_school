// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ActivityScoreModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityScoreModel _$ActivityScoreModelFromJson(Map<String, dynamic> json) {
  return ActivityScoreModel(
      json['data'] == null
          ? null
          : ActivityScore.fromJson(json['data'] as Map<String, dynamic>),
      json['code'],
      json['msg']);
}

Map<String, dynamic> _$ActivityScoreModelToJson(ActivityScoreModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.score
    };

ActivityScore _$ActivityScoreFromJson(Map<String, dynamic> json) {
  return ActivityScore(
      json['id'] as int,
      json['createAt'] as String,
      json['enterNameStudentId'] as int,
      json['patriotismEducationLevel'] as String,
      json['socialTrainingComprehensiveLevel'] as String,
      json['safetyEducationComprehensiveLevel'] as String,
      json['safetyFangzaizijiubishiLevel'] as String,
      json['safetyFangzaizijiuLevel'] as String,
      json['safetyXiaofangzijiuLevel'] as String,
      json['safetyJiaotongzihuLevel'] as String,
      json['safetyChangjianjijiuLevel'] as String,
      json['socialInitiativeLevel'] as String,
      json['socialSolidarityLevel'] as String,
      json['socialPersonalityLevel'] as String,
      json['socialIndependenceLevel'] as String,
      json['socialRewardAndPunishment'] as String);
}

Map<String, dynamic> _$ActivityScoreToJson(ActivityScore instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createAt': instance.createAt,
      'enterNameStudentId': instance.enterNameStudentId,
      'patriotismEducationLevel': instance.patriotismEducationLevel,
      'socialTrainingComprehensiveLevel':
          instance.socialTrainingComprehensiveLevel,
      'safetyEducationComprehensiveLevel':
          instance.safetyEducationComprehensiveLevel,
      'safetyFangzaizijiubishiLevel': instance.safetyFangzaizijiubishiLevel,
      'safetyFangzaizijiuLevel': instance.safetyFangzaizijiuLevel,
      'safetyXiaofangzijiuLevel': instance.safetyXiaofangzijiuLevel,
      'safetyJiaotongzihuLevel': instance.safetyJiaotongzihuLevel,
      'safetyChangjianjijiuLevel': instance.safetyChangjianjijiuLevel,
      'socialInitiativeLevel': instance.socialInitiativeLevel,
      'socialSolidarityLevel': instance.socialSolidarityLevel,
      'socialPersonalityLevel': instance.socialPersonalityLevel,
      'socialIndependenceLevel': instance.socialIndependenceLevel,
      'socialRewardAndPunishment': instance.socialRewardAndPunishment
    };
