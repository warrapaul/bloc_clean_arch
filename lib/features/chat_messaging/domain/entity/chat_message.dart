enum MessageStatus { sent, delivered, read }

enum MessageType { text, image, audio, video }

class ChatMessage {
  final String message;
  final bool isUser;
  final DateTime timestamp;
  final MessageStatus status;
  final MessageType type;
  final String? mediaUrl;

  ChatMessage({
    required this.message,
    required this.isUser,
    required this.timestamp,
    this.status = MessageStatus.sent,
    this.type = MessageType.text,
    this.mediaUrl,
  });
}
