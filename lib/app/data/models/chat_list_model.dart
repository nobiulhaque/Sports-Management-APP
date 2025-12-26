class ChatListModel {
  bool? success;
  int? statusCode;
  String? message;
  List<ChatData>? data;

  ChatListModel({this.success, this.statusCode, this.message, this.data});

  ChatListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ChatData>[];
      json['data'].forEach((v) {
        data!.add(ChatData.fromJson(v));
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

class ChatData {
  String? conversationId;
  ChatUser? user;
  String? lastMessage;
  String? lastMessageDate;

  ChatData({this.conversationId, this.user, this.lastMessage, this.lastMessageDate});

  ChatData.fromJson(Map<String, dynamic> json) {
    conversationId = json['conversationId'];
    user = json['user'] != null ? ChatUser.fromJson(json['user']) : null;
    lastMessage = json['lastMessage'];
    lastMessageDate = json['lastMessageDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['conversationId'] = conversationId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['lastMessage'] = lastMessage;
    data['lastMessageDate'] = lastMessageDate;
    return data;
  }
}

class ChatUser {
  String? id;
  String? name;
  String? image;
  String? email;

  ChatUser({this.id, this.name, this.image, this.email});

  ChatUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['email'] = email;
    return data;
  }
}
