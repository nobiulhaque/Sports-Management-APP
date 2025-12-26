import 'package:get/get.dart';
import 'package:kaldmv/app/data/models/chat_list_model.dart';
import 'package:kaldmv/core/services/api_service.dart';

class MessageController extends GetxController {
  final isLoading = false.obs;
  final chatList = <ChatData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchChats();
  }

  Future<void> fetchChats() async {
    try {
      isLoading.value = true;
      final response = await ApiService().get('/chats/get-my-chat');
      
      if (response != null) {
        final model = ChatListModel.fromJson(response);
        if (model.success == true && model.data != null) {
          chatList.assignAll(model.data!);
        }
      }
    } catch (e) {
      print("Error fetching chats: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
