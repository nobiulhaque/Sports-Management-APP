import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../../../../data/models/conversation_model.dart';
import '../../../../widgets/app_bar_widgets.dart';
import '../controllers/chat_detail_controller.dart';

class ChatDetailView extends GetView<ChatDetailController> {
  ChatDetailView({super.key});
  // Note: Controller lifecycle is managed by Get.to() binding or manual put. 
  // Should ideally relying on binding, but keeping consistent with existing pattern.
  @override
  final controller = Get.put(ChatDetailController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: CustomAppBar(title: 'Chat'),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // League Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Get.back(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: controller.chatImage != null && controller.chatImage!.startsWith('http')
                      ? CachedNetworkImage(
                          imageUrl: controller.chatImage!,
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                           placeholder: (context, url) => const Icon(Icons.person),
                           errorWidget: (context, url, error) => const Icon(Icons.person),
                        )
                      : const Icon(Icons.person, size: 30, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    controller.leagueName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // Messages
            Expanded(
              child: Obx(
                () => ListView.builder(
                  reverse: true, // Start from bottom
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    // Reverse index to show newest at bottom (index 0 of ListView is bottom)
                    final message = controller.messages[controller.messages.length - 1 - index];
                    
                    // If sender is NOT the receiver (the person we are talking to), then it's ME.
                    final isSent = message.senderId != controller.receiverId; 
                    final time = _formatTime(message.createdAt);

                    return _buildMessage(
                      message,
                      isSent,
                      time,
                    );
                  },
                ),
              ),
            ),

            // Input Area
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: controller.pickAndSendFile,
                    icon: const Icon(Icons.attach_file, color: Colors.grey),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: controller.messageController,
                        decoration: const InputDecoration(
                          hintText: 'Type here',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: const Color(0xFF2F4CDD),
                    radius: 24,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white, size: 20),
                      onPressed: controller.sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(MessageData message, bool isSent, String time) {
    final text = message.content ?? '';
    final files = message.files;
    final hasImage = files != null && files.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isSent) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: controller.chatImage != null && controller.chatImage!.startsWith('http')
                  ? CachedNetworkImage(
                      imageUrl: controller.chatImage!,
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                    )
                  : SvgPicture.asset( // Fallback icon
                      'assets/icons/chat_ligue_icon.svg',
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                    ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
               crossAxisAlignment: isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                  if (hasImage) 
                  GestureDetector(
                    onTap: () {
                      Get.to(() => Scaffold(
                        backgroundColor: Colors.black,
                        appBar: AppBar(
                          backgroundColor: Colors.black,
                          iconTheme: const IconThemeData(color: Colors.white),
                        ),
                        body: Center(
                          child: CachedNetworkImage(
                            imageUrl: files!.first,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: files!.first, // Showing first image for now
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            width: 200, 
                            height: 200, 
                            color: Colors.grey[300],
                            child: const Center(child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                if (text.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSent ? const Color(0xFF2F4CDD) : const Color(0xFFE8EAFF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 14,
                      color: isSent ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isSent) ...[
            const SizedBox(width: 8),
            const CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFFE0E0E0),
              child: Icon(Icons.person, size: 18, color: Colors.white),
            ),
          ],
        ],
      ),
    );
  }
  
  String _formatTime(String? createdAt) {
    if (createdAt == null) return '';
    try {
      final date = DateTime.parse(createdAt).toLocal();
      return DateFormat('hh:mm a').format(date);
    } catch (e) {
      return '';
    }
  }
}
