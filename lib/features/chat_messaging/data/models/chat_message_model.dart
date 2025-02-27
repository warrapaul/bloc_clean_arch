
import 'package:bloc_clean_arch/features/chat_messaging/domain/entity/chat_message.dart';

enum MessageStatus { sent, delivered, read }

enum MessageType { text, image, audio, video }

class ChatMessageModel {
  final String id;
  final String message;
  final bool isUser;
  final String senderId;
  final DateTime timestamp;
  final MessageStatus status;
  final MessageType type;
  final String? mediaUrl;

  ChatMessageModel(
    this.message,
    this.isUser,
    this.status,
    this.type,
    this.mediaUrl, {
    required this.id,
    required this.senderId,
    required this.timestamp,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      json['message'],
      json['isUser'],
      MessageStatus.values
          .firstWhere((e) => e.toString() == 'MessageStatus.${json['status']}'),
      MessageType.values
          .firstWhere((e) => e.toString() == 'MessageType.${json['type']}'),
      json['mediaUrl'],
      id: json['id'],
      senderId: json['senderId'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'isUser': isUser,
      'senderId': senderId,
      'timestamp': timestamp.toIso8601String(),
      'status': status.toString().split('.').last,
      'type': type.toString().split('.').last,
      'mediaUrl': mediaUrl,
    };
  }

  ChatMessage toEntity() {
    return ChatMessage(
      message,
      isUser,
      status,
      type,
      mediaUrl,
      id: id,
      senderId: senderId,
      timestamp: timestamp,
    );
  }


}

