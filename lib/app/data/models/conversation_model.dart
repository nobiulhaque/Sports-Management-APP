class ConversationResponseModel {
  bool? success;
  int? statusCode;
  String? message;
  ConversationData? data;

  ConversationResponseModel({this.success, this.statusCode, this.message, this.data});

  ConversationResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? ConversationData.fromJson(json['data']) : null;
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

class ConversationData {
  String? id;
  String? user1Id;
  String? user2Id;
  List<MessageData>? messages;

  ConversationData({this.id, this.user1Id, this.user2Id, this.messages});

  ConversationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user1Id = json['user1Id'];
    user2Id = json['user2Id'];
    if (json['messages'] != null) {
      messages = <MessageData>[];
      json['messages'].forEach((v) {
        messages!.add(MessageData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user1Id'] = user1Id;
    data['user2Id'] = user2Id;
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MessageData {
  String? id;
  String? conversationId;
  String? senderId;
  String? receiverId;
  String? content;
  List<String>? files;
  bool? isRead;
  String? createdAt;

  MessageData(
      {this.id,
      this.conversationId,
      this.senderId,
      this.receiverId,
      this.content,
      this.files,
      this.isRead,
      this.createdAt});

  MessageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    conversationId = json['conversationId'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    content = json['content'];
    if (json['files'] != null) {
      files = List<String>.from(json['files']);
    }
    isRead = json['isRead'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['conversationId'] = conversationId;
    data['senderId'] = senderId;
    data['receiverId'] = receiverId;
    data['content'] = content;
    data['files'] = files;
    data['isRead'] = isRead;
    data['createdAt'] = createdAt;
    return data;
  }
}
