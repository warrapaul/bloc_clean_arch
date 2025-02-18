part of 'chat_socket_bloc.dart';

@immutable
sealed class ChatSocketState {
  final List<ChatMessage> messages;

  const ChatSocketState({
    this.messages = const [],
  });
}

final class ChatSocketInitial extends ChatSocketState {
  const ChatSocketInitial() : super();
}

final class ChatSocketInitializing extends ChatSocketState {
  const ChatSocketInitializing({required super.messages});
}

final class ChatSocketConnecting extends ChatSocketState {
  const ChatSocketConnecting({required super.messages});
}

final class ChatSocketConnected extends ChatSocketState {
  const ChatSocketConnected({required super.messages});
}

final class ChatSocketDisconnected extends ChatSocketState {
  const ChatSocketDisconnected({required super.messages});
}

final class ChatSocketSendingMessage extends ChatSocketState {
  const ChatSocketSendingMessage({required super.messages});
}

final class ChatSocketMessageReceived extends ChatSocketState {
  final ChatMessage newMessage;

  const ChatSocketMessageReceived({
    required this.newMessage,
    required super.messages,
  });
}

final class ChatSocketMessageSent extends ChatSocketState {
  final ChatMessage sentMessage;

  const ChatSocketMessageSent({
    required this.sentMessage,
    required super.messages,
  });
}

final class ChatSocketError extends ChatSocketState {
  final String message;

  const ChatSocketError({
    required this.message,
    required super.messages,
  });
}

final class ChatFetchingPreviousMessages extends ChatSocketState {
  const ChatFetchingPreviousMessages({required super.messages});
}

final class ChatFetchedPreviousMessages extends ChatSocketState {
  const ChatFetchedPreviousMessages({required super.messages});
}



// @immutable
// sealed class ChatSocketState {}

// final class ChatSocketInitial extends ChatSocketState {}

// final class ChatSocketConnecting extends ChatSocketState {}

// final class ChatSocketConnected extends ChatSocketState {}

// final class ChatSocketDisconnected extends ChatSocketState {}

// final class ChatSocketSendingMessage extends ChatSocketState {}

// final class ChatSocketMessageReceived extends ChatSocketState {
//   final dynamic newMessage;

//   ChatSocketMessageReceived({required this.newMessage});
// }

// final class ChatSocketMessageSent extends ChatSocketState {
//   final dynamic sentMessage;

//   ChatSocketMessageSent({required this.sentMessage});
// }

// class ChatSocketError extends ChatSocketState {
//   final String message;
  
//   ChatSocketError({required this.message});
// }

// final class ChatFetchingPreviousMessages extends ChatSocketState {}

// final class ChatFetchedPreviousMessages extends ChatSocketState {
//   final List<ChatMessage> messages;

//   ChatFetchedPreviousMessages({required this.messages});
// }
