// ignore_for_file: unnecessary_new, unnecessary_this, prefer_collection_literals

class League {
  final bool? success;
  final int? statusCode;
  final String? message;
  final Meta? meta;
  final List<Data>? data;

  League({this.success, this.statusCode, this.message, this.meta, this.data});

  factory League.fromJson(Map<String, dynamic> json) => League(
    success: json['success'],
    statusCode: json['statusCode'],
    message: json['message'],
    meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    data: (json['data'] as List?)?.map((v) => Data.fromJson(v)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'statusCode': statusCode,
    'message': message,
    'meta': meta?.toJson(),
    'data': data?.map((v) => v.toJson()).toList(),
  };
}

class Meta {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;
  final bool? hasNext;
  final bool? hasPrev;

  Meta({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
    this.hasNext,
    this.hasPrev,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    page: json['page'],
    limit: json['limit'],
    total: json['total'],
    totalPage: json['totalPage'],
    hasNext: json['hasNext'],
    hasPrev: json['hasPrev'],
  );

  Map<String, dynamic> toJson() => {
    'page': page,
    'limit': limit,
    'total': total,
    'totalPage': totalPage,
    'hasNext': hasNext,
    'hasPrev': hasPrev,
  };
}

class Data {
  final String? id;
  final String? organizationId;
  final int? founded;
  final String? country;
  final String? level;
  final String? userId;
  final User? user;
  final String? requestStatus;
  final bool? isRequestSent;
  bool? isSaved;
  final String? requestedAt;
  final String? requestId;

  Data({
    this.id,
    this.organizationId,
    this.founded,
    this.country,
    this.level,
    this.userId,
    this.user,
    this.requestStatus,
    this.isRequestSent,
    this.isSaved,
    this.requestedAt,
    this.requestId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json['id'],
    organizationId: json['organizationId'],
    founded: json['founded'],
    country: json['country'],
    level: json['level'],
    userId: json['userId'],
    user: json['user'] != null ? User.fromJson(json['user']) : null,
    requestStatus: json['requestStatus'],
    isRequestSent: json['isRequestSent'],
    isSaved: json['isSaved'],
    requestedAt: json['requestedAt'],
    requestId: json['requestId'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'organizationId': organizationId,
    'founded': founded,
    'country': country,
    'level': level,
    'userId': userId,
    'user': user?.toJson(),
    'requestStatus': requestStatus,
    'isRequestSent': isRequestSent,
    'isSaved': isSaved,
    'requestedAt': requestedAt,
    'requestId': requestId,
  };
}

class User {
  final String? id;
  final String? name;
  final String? image;

  User({this.id, this.name, this.image});

  factory User.fromJson(Map<String, dynamic> json) =>
      User(id: json['id'], name: json['name'], image: json['image']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'image': image};
}
