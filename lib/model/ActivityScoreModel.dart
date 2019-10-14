import 'package:green_school/model/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ActivityScoreModel.g.dart';

@JsonSerializable()
class ActivityScoreModel extends BaseModel{
  @JsonKey(name: "data")
  ActivityScore score;


  ActivityScoreModel(this.score, code, msg) :super(code, msg);

  factory ActivityScoreModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityScoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityScoreModelToJson(this);
}

@JsonSerializable()
class ActivityScore {
  int id;
  String createAt;
  int enterNameStudentId;
  String patriotismEducationLevel;
  String socialTrainingComprehensiveLevel;
  String safetyEducationComprehensiveLevel;
  String safetyFangzaizijiubishiLevel;
  String safetyFangzaizijiuLevel;
  String safetyXiaofangzijiuLevel;
  String safetyJiaotongzihuLevel;
  String safetyChangjianjijiuLevel;
  String socialInitiativeLevel;
  String socialSolidarityLevel;
  String socialPersonalityLevel;
  String socialIndependenceLevel;
  String socialRewardAndPunishment;

  ActivityScore.mock() {
    this.id = 1;
    this.createAt="0000-00-00";
    this.enterNameStudentId=1212;
    this.patriotismEducationLevel="尚未评测";
    this.socialTrainingComprehensiveLevel="尚未评测";
    this.safetyEducationComprehensiveLevel="尚未评测";
    this.safetyFangzaizijiubishiLevel="尚未评测";
    this.safetyFangzaizijiuLevel="尚未评测";
    this.safetyXiaofangzijiuLevel="尚未评测";
    this.safetyJiaotongzihuLevel="尚未评测";
    this.safetyChangjianjijiuLevel="尚未评测";
    this.socialInitiativeLevel="尚未评测";
    this.socialSolidarityLevel="尚未评测";
    this.socialPersonalityLevel="尚未评测";
    this.socialIndependenceLevel="尚未评测";
    this.socialRewardAndPunishment= "尚未评测";
  }

  ActivityScore(
      this.id,
      this.createAt,
      this.enterNameStudentId,
      this.patriotismEducationLevel,
      this.socialTrainingComprehensiveLevel,
      this.safetyEducationComprehensiveLevel,
      this.safetyFangzaizijiubishiLevel,
      this.safetyFangzaizijiuLevel,
      this.safetyXiaofangzijiuLevel,
      this.safetyJiaotongzihuLevel,
      this.safetyChangjianjijiuLevel,
      this.socialInitiativeLevel,
      this.socialSolidarityLevel,
      this.socialPersonalityLevel,
      this.socialIndependenceLevel,
      this.socialRewardAndPunishment);

  factory ActivityScore.fromJson(Map<String, dynamic> json) =>
      _$ActivityScoreFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityScoreToJson(this);
}