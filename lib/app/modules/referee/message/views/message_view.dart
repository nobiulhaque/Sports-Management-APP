import 'package:cached_network_image/cached_network_image.dart';
import 'package:kaldmv/app/data/models/chat_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../widgets/app_bar_widgets.dart';
import '../controllers/message_controller.dart';
import 'chat_detail_view.dart';

class MessageView extends GetView<MessageController> {
  MessageView({super.key});
final controller = Get.put(MessageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Chat'),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (controller.chatList.isEmpty) {
          return const Center(child: Text("No conversations found"));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.chatList.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final chat = controller.chatList[index];
            return _buildChatItem(chat);
          },
        );
      }),
    );
  }

  Widget _buildChatItem(ChatData chat) {
    final user = chat.user;
    final name = user?.name ?? "Unknown User";
    final lastMessage = chat.lastMessage ?? "No messages yet";
    final time = chat.lastMessageDate ?? "";
    final image = user?.image ?? "";

    return GestureDetector(
      onTap: () {
        // Navigate to chat detail screen
        if (user?.id != null) {
          Get.to(() => ChatDetailView(), arguments: {
            'name': name,
            'userId': user!.id,
            'image': image
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // User Image
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: image.isNotEmpty && image.startsWith('http')
                    ? CachedNetworkImage(
                        imageUrl: image,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Icon(Icons.person, size: 24, color: Colors.grey),
                        errorWidget: (context, url, error) => const Icon(Icons.person, size: 24, color: Colors.grey),
                      )
                    : SvgPicture.asset(
                        'assets/icons/chat_ligue_icon.svg',
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(width: 12),

            // Chat Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lastMessage.length > 25 ? '${lastMessage.substring(0, 25)}...' : lastMessage + (time.isNotEmpty ? ' | $time' : ''),
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Menu Icon with Popup
            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                color: Colors.grey[600],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (value) {
                if (value == 'mute') {
                  _showMuteDialog(name);
                } else if (value == 'delete') {
                  _showDeleteDialog(name);
                }
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem<String>(
                  value: 'mute',
                  child: Row(
                    children: [
                      Icon(Icons.notifications_off_outlined, size: 20),
                      SizedBox(width: 12),
                      Text('Mute'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline, size: 20, color: Colors.red),
                      SizedBox(width: 12),
                      Text('Delete', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMuteDialog(String leagueName) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Mute Conversation'),
        content: Text('Do you want to mute notifications from $leagueName?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                'Muted',
                'Notifications from $leagueName have been muted',
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 2),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F4CDD),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Mute'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(String leagueName) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Delete Conversation'),
        content: Text('Are you sure you want to delete the conversation with $leagueName?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                'Deleted',
                'Conversation with $leagueName has been deleted',
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 2),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
