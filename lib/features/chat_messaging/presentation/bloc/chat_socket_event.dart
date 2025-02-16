part of 'chat_socket_bloc.dart';

@immutable
sealed class ChatSocketEvent {}

final class ConnectChatSocket extends ChatSocketEvent {}

final class DisonnectChatSocket extends ChatSocketEvent {}

final class ChatSocketEmitMessage extends ChatSocketEvent {
  final String eventName;
  final dynamic data;

  ChatSocketEmitMessage({required this.data, required this.eventName});
}

final class ChatSocketListenToMessage extends ChatSocketEvent {}

final class ChatFetchPreviousMessages extends ChatSocketEvent {
  final FilterChatMessagesReqParams params;

  ChatFetchPreviousMessages({required this.params});
}
