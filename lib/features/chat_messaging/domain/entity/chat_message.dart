
import 'package:bloc_clean_arch/features/chat_messaging/data/models/chat_message_model.dart';

class ChatMessage {
  final String id;
  final String message;
  final bool isUser;
  final String senderId;
  final DateTime timestamp;
  final MessageStatus status;
  final MessageType type;
  final String? mediaUrl;

  ChatMessage(
    this.message,
    this.isUser,
    this.status,
    this.type,
    this.mediaUrl, {
    required this.id,
    required this.senderId,
    required this.timestamp,
  });
}
