import 'package:kaldmv/app/data/models/my_league_referees_model.dart';

class RefereeDetailsModel {
  bool? success;
  int? statusCode;
  String? message;
  Referee? data;

  RefereeDetailsModel({this.success, this.statusCode, this.message, this.data});

  RefereeDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Referee.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
