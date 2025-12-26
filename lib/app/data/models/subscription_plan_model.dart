class SubscriptionPlanModel {
  bool? success;
  int? statusCode;
  String? message;
  List<PlanData>? data;

  SubscriptionPlanModel({this.success, this.statusCode, this.message, this.data});

  SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PlanData>[];
      json['data'].forEach((v) {
        data!.add(PlanData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlanData {
  String? id;
  String? title;
  List<String>? facilities;
  String? stripeProductId;
  String? stripePriceId;
  num? price;
  String? type;
  String? planFor;

  PlanData(
      {this.id,
      this.title,
      this.facilities,
      this.stripeProductId,
      this.stripePriceId,
      this.price,
      this.type,
      this.planFor});

  PlanData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['facilities'] != null) {
      facilities = List<String>.from(json['facilities']);
    }
    stripeProductId = json['stripeProductId'];
    stripePriceId = json['stripePriceId'];
    price = json['price'];
    type = json['type'];
    planFor = json['planFor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['facilities'] = facilities;
    data['stripeProductId'] = stripeProductId;
    data['stripePriceId'] = stripePriceId;
    data['price'] = price;
    data['type'] = type;
    data['planFor'] = planFor;
    return data;
  }
}
