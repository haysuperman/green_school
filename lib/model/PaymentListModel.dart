import 'package:green_school/model/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'PaymentListModel.g.dart';

@JsonSerializable()
class PaymentListModel extends BaseModel{
  List<PaymentModel> data;


  PaymentListModel(this.data, code, msg) : super(code, msg);

  factory PaymentListModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentListModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentListModelToJson(this);
}


@JsonSerializable()
class PaymentModel {
  String title;
  String price;


  PaymentModel(this.title, this.price);

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}