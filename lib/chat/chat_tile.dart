import 'package:chat_app_firebase/models/chat_model.dart';
import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  final Chat chat;
  final String otherUserEmail;
  final VoidCallback onTap;

  const ChatTile({
    super.key,
    required this.chat,
    required this.otherUserEmail,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: Text(otherUserEmail),
      subtitle: Text(
        chat.lastMessage.isEmpty
            ? 'No messages yet'
            : chat.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: chat.lastMessageTime == null
          ? null
          : Text(
              _formatTime(chat.lastMessageTime!),
              style: const TextStyle(fontSize: 12),
            ),
      onTap: onTap,
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    if (now.difference(time).inDays == 0) {
      return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
    }
    return "${time.day}/${time.month}";
  }
}
