import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kaldmv/app/data/models/conversation_model.dart';
import 'package:kaldmv/core/services/api_service.dart';

class ChatDetailController extends GetxController {
  final TextEditingController messageController = TextEditingController();

  late String leagueName;
  late String receiverId;
  String? conversationId;
  String? chatImage;

  final isLoading = false.obs;
  final messages = <MessageData>[].obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is Map) {
      leagueName = args['name'] ?? 'Chat';
      receiverId = args['userId'] ?? '';
      chatImage = args['image'];
      fetchMessages();
    }
  }

  Future<void> fetchMessages() async {
    if (receiverId.isEmpty) return;
    
    try {
      isLoading.value = true;
      // Note: User provided CURL uses GET with body. Dio/Http supports body in GET but it's non-standard.
      // However, usually "get conversation" by ID suggests fetching via Query Param or POST. 
      // Based on typical backend behavior matching the curl: we will try passing data in body.
      final response = await ApiService().get(
        '/chats/conversation', 
        data: {'userId': receiverId} 
      );

      if (response != null) {
        final model = ConversationResponseModel.fromJson(response);
        if (model.success == true && model.data != null) {
          conversationId = model.data!.id;
          if (model.data!.messages != null) {
            messages.assignAll(model.data!.messages!);
          }
        }
      }
    } catch (e) {
      print("Error fetching conversation: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage() async {
    final content = messageController.text.trim();
    if (content.isEmpty || conversationId == null) return;

    try {
      messageController.clear(); // Optimistic clear
      
      final response = await ApiService().post(
        path: '/chats/message',
        data: {
          'conversationId': conversationId,
          'receiverId': receiverId,
          'content': content
        },
      );
      
      if (response != null && response['success'] == true && response['data'] != null) {
        final newMessage = MessageData.fromJson(response['data']);
        messages.add(newMessage);
      } else {
        // Handle error (maybe restore text)
      }

    } catch (e) {
      print("Error sending message: $e");
    }
  }

  Future<void> pickAndSendFile() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
       await sendFile(File(image.path));
    }
  }

  Future<void> sendFile(File file) async {
    if (conversationId == null) return;
    try {
      // Step 1: Upload File
      final formData = dio.FormData.fromMap({
        'conversationId': conversationId,
        'receiverId': receiverId,
        'files': await dio.MultipartFile.fromFile(file.path),
      });

      final uploadResponse = await ApiService().post(
        path: '/chats/send-file',
        data: formData,
      );

      // Step 2: If upload success, send message with file URL
      if (uploadResponse != null && uploadResponse['success'] == true && uploadResponse['data'] != null) {
        var data = uploadResponse['data'];
        if (data['filesUrl'] != null) {
           List<String> filesUrl = List<String>.from(data['filesUrl']);
           
           // Call send message API with the files
           final messageResponse = await ApiService().post(
            path: '/chats/message',
            data: {
              'conversationId': conversationId,
              'receiverId': receiverId,
              'files': filesUrl,
            },
           );

           if (messageResponse != null && messageResponse['success'] == true && messageResponse['data'] != null) {
             final newMessage = MessageData.fromJson(messageResponse['data']);
             messages.add(newMessage);
           }
        }
      }
    } catch (e) {
      print("Error sending file: $e");
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}

