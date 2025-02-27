import 'package:bloc_clean_arch/features/chat_messaging/data/models/chat_message_model.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/entity/chat_message.dart';
import 'package:bloc_clean_arch/features/chat_messaging/presentation/widgets/full_screen_image_preview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.showAvatar,
  });

  final ChatMessage message;
  final bool showAvatar;

  @override
  Widget build(BuildContext context) {
    final bool isUser = message.isUser;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: showAvatar ? 8 : 2),
      child: Row(
                mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showAvatar & !isUser ? _buildAvatar(isUser ? 'U' : 'R') : const SizedBox(width: 30),
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: isUser ? const Color(0xFF0088CC) : Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(12),
                  bottomRight: const Radius.circular(12),
                  topLeft: isUser
                      ? const Radius.circular(12)
                      : const Radius.circular(2),
                  topRight: isUser
                      ? const Radius.circular(2)
                      : const Radius.circular(12),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Column(
                  // crossAxisAlignment: message.isUser
                  //     ? CrossAxisAlignment.end
                  //     : CrossAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildMessageContent(context),
                    const SizedBox(height: 2),
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ),
          showAvatar  & isUser
              ? _buildAvatar(isUser ? 'U' : 'R')
              : const SizedBox(width: 30),
        ],
      ),
    );
  }


    Widget _buildMessageContent(BuildContext context) {
    switch (message.type) {
      case MessageType.text:
        return Text(
          message.message,
          style: TextStyle(
            color: message.isUser ? Colors.white : Colors.black87,
            fontSize: 15,
            height: 1.3,
          ),
        );
      case MessageType.image:
      final heroTag = message.mediaUrl!; // or 'image-${message.id}';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => showDialog(
                context: context,
                builder: (context) => FullScreenImagePreview(imageUrl: message.mediaUrl!, heroTag: heroTag,
                ),
              ),
              child: Hero(
                tag: heroTag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6 // Limit image width
                    ),
                    child: AspectRatio(
                      aspectRatio: 1, // Default aspect ratio (square)
                      child: Image.network(
                        message.mediaUrl!,
                        fit: BoxFit
                            .cover, // Maintain aspect ratio and cover the space
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.error, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (message.message.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  message.message,
                  style: TextStyle(
                    color: message.isUser ? Colors.white : Colors.black87,
                    fontSize: 15,
                    height: 1.3,
                  ),
                ),
              ),
          ],
        );
      case MessageType.audio:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.mic,
              color: message.isUser ? Colors.white : Colors.black87,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              message.message,
              style: TextStyle(
                color: message.isUser ? Colors.white : Colors.black87,
                fontSize: 12,
              ),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }





  Widget _buildFooter() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          DateFormat('HH:mm').format(message.timestamp),
          style: TextStyle(
            fontSize: 12,
            color:
                message.isUser ? Colors.white.withOpacity(0.7) : Colors.black54,
          ),
        ),
        const SizedBox(width: 5,),
                            _buildStatusIcon(),

      ],
    );
  }

  Widget _buildStatusIcon() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          message.status == MessageStatus.read ? Icons.done_all : Icons.check,
          size: 14,
          color: message.isUser ? Colors.white : Colors.black87,
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  Widget _buildAvatar(String user) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: Colors.grey.shade500,
      child: Text(
        user,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
