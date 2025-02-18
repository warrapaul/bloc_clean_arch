import 'package:bloc_clean_arch/core/constants/socket_events_constants.dart';
import 'package:bloc_clean_arch/features/chat_messaging/data/models/chat_message_model.dart';
import 'package:bloc_clean_arch/features/chat_messaging/data/models/filter_chat_messages_req_params.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/entity/chat_message.dart';
import 'package:bloc_clean_arch/features/chat_messaging/presentation/bloc/chat_socket_bloc.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatMessageT extends StatefulWidget {
  const ChatMessageT({super.key});

  @override
  State<ChatMessageT> createState() => _ChatMessageTState();
}

class _ChatMessageTState extends State<ChatMessageT> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<ChatSocketBloc>()
            ..add(InitializeChatSocket())
            ..add(ConnectChatSocket())
            ..add(ChatFetchPreviousMessages(
              params: FilterChatMessagesReqParams(
                page: 0,
                pageSize: 50,
              ),
            )),
        )
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Chat')),
        body: BlocConsumer<ChatSocketBloc, ChatSocketState>(
          listenWhen: (previous, current) =>
              current is ChatSocketMessageSent ||
              current is ChatSocketMessageReceived,
          listener: (context, state) {
            // Scroll to bottom when new message arrives
            _scrollToBottom();
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(8),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      return MessageBubble(message: message);
                    },
                  ),
                ),
                if (state is ChatSocketSendingMessage)
                  const LinearProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: const InputDecoration(
                            hintText: 'Type a message...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          if (_messageController.text.isNotEmpty) {
                            final message = ChatMessage(
                              _messageController.text,
                              true, // isUser
                              MessageStatus.sent,
                              MessageType.text,
                              null, // mediaUrl
                              id: DateTime.now().toString(), // temporary ID
                              senderId: 'current_user_id', // Replace with actual user ID
                              timestamp: DateTime.now(),
                            );

                            context.read<ChatSocketBloc>().add(
                                  ChatSocketEmitMessage(
                                    eventName: SocketEventsConstants.newMessage,
                                    data: message,
                                  ),
                                );
                            _messageController.clear();
                            _scrollToBottom(); // Scroll after sending
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}



class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isCurrentUser = message.isUser;

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.message,
              style: TextStyle(
                color: isCurrentUser ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat('HH:mm').format(message.timestamp),
                  style: TextStyle(
                    fontSize: 12,
                    color: isCurrentUser ? Colors.white70 : Colors.black54,
                  ),
                ),
                if (isCurrentUser) ...[
                  const SizedBox(width: 4),
                  Icon(
                    _getStatusIcon(message.status),
                    size: 12,
                    color: Colors.white70,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getStatusIcon(MessageStatus status) {
    switch (status) {
      case MessageStatus.sent:
        return Icons.check;
      case MessageStatus.delivered:
        return Icons.done_all;
      case MessageStatus.read:
        return Icons.done_all;
    }
  }
}



