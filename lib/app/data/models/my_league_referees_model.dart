class MyLeagueRefereesModel {
  bool? success;
  int? statusCode;
  String? message;
  List<MyLeagueRefereesData>? data;

  MyLeagueRefereesModel(
      {this.success, this.statusCode, this.message, this.data});

  MyLeagueRefereesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MyLeagueRefereesData>[];
      json['data'].forEach((v) {
        data!.add(MyLeagueRefereesData.fromJson(v));
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

class MyLeagueRefereesData {
  String? id;
  String? status;
  String? requestedAt;
  String? respondedAt;
  String? notes;
  Referee? referee;

  MyLeagueRefereesData(
      {this.id,
      this.status,
      this.requestedAt,
      this.respondedAt,
      this.notes,
      this.referee});

  MyLeagueRefereesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    requestedAt = json['requestedAt'];
    respondedAt = json['respondedAt'];
    notes = json['notes'];
    referee =
        json['referee'] != null ? Referee.fromJson(json['referee']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['requestedAt'] = requestedAt;
    data['respondedAt'] = respondedAt;
    data['notes'] = notes;
    if (referee != null) {
      data['referee'] = referee!.toJson();
    }
    return data;
  }
}

class Referee {
  String? id;
  num? experience;
  String? location;
  String? certifyingAuthority;
  User? user;
  num? averageRating;
  num? totalMatches;
  String? badge;
  String? bio;

  Referee(
      {this.id,
      this.experience,
      this.location,
      this.certifyingAuthority,
      this.user,
      this.averageRating,
      this.totalMatches,
      this.badge,
      this.bio});

  Referee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    experience = json['experience'];
    location = json['location'];
    certifyingAuthority = json['certifyingAuthority'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    averageRating = json['averageRating'];
    totalMatches = json['totalMatches'];
    badge = json['badge'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['experience'] = experience;
    data['location'] = location;
    data['certifyingAuthority'] = certifyingAuthority;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['averageRating'] = averageRating;
    data['totalMatches'] = totalMatches;
    data['badge'] = badge;
    data['bio'] = bio;
    return data;
  }
}

class User {
  String? id;
  String? name;
  String? email;
  String? image;
  String? role;

  User({this.id, this.name, this.email, this.image, this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['image'] = image;
    data['role'] = role;
    return data;
  }
}
