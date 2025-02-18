import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/features/chat_messaging/data/models/filter_chat_messages_req_params.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/entity/chat_message.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/repositories/chat_message_repository.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/usecases/connect_chat_message_socket.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/usecases/disconnect_chat_message_socket.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/usecases/fetch_previous_chat_messages.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/usecases/initialize_socket_connection.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/usecases/listen_to_chat_messages.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/usecases/send_chat_message.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'chat_socket_event.dart';
part 'chat_socket_state.dart';

class ChatSocketBloc extends Bloc<ChatSocketEvent, ChatSocketState> {
  final SendChatMessageSocketUsecase sendChatMessageUsecase;
  final DisconnectChatMessageSocketUsecase disconnectChatMessageSocketUsecase;
  final ConnectChatMessageSocketUsecase connectChatMessageSocketUsecase;
  final FetchPreviousChatMessagesUsecase fetchPreviousChatMessagesUsecase;
  final ListenToChatMessagesUsecase listenToChatMessagesUsecase; 
  final InitializeSocketConnectionUsecase initializeSocketConnectionUsecase;

  // StreamSubscription? _messageSubscription;
  StreamSubscription<Either<Failure, ChatMessage>>? _messageSubscription;

  ChatSocketBloc({
    required this.fetchPreviousChatMessagesUsecase,
    required this.sendChatMessageUsecase,
    required this.disconnectChatMessageSocketUsecase,
    required this.connectChatMessageSocketUsecase,
    required this.listenToChatMessagesUsecase,
    required this.initializeSocketConnectionUsecase,

  }) : super(ChatSocketInitial()) {
    on<InitializeChatSocket>(_handleInitializeChatSocket);
    on<ConnectChatSocket>(_handleConnectChatSocket);
    on<DisonnectChatSocket>(_handleDisonnectChatSocket);
    on<ChatSocketEmitMessage>(_handleChatSocketEmitMessage);
    on<ChatSocketListenToMessage>(_handleChatSocketListenToMessage);
    on<ChatFetchPreviousMessages>(_handleChatFetchPreviousMessages);
  }

  @override
  Future<void> close() async{
    await _messageSubscription?.cancel();
    await disconnectChatMessageSocketUsecase(param: null);
    return super.close();
  }

FutureOr<void> _handleInitializeChatSocket(
      InitializeChatSocket event, Emitter<ChatSocketState> emit) async {
    emit(ChatSocketInitializing(messages: state.messages));
    try {
      final result = await initializeSocketConnectionUsecase(param: null);
      result.fold(
        (failure) => emit(ChatSocketError(
          message: failure.message,
          messages: state.messages,
        )),
        (data) {
          emit(ChatSocketConnected(messages: state.messages));
          add(ChatSocketListenToMessage());
        },
      );
    } catch (e) {
      emit(ChatSocketError(
        message: e.toString(),
        messages: state.messages,
      ));
    }
  }


FutureOr<void> _handleConnectChatSocket(
      ConnectChatSocket event, Emitter<ChatSocketState> emit) async {
    emit(ChatSocketConnecting(messages: state.messages));
    try {
      final result = await connectChatMessageSocketUsecase(param: null);
      result.fold(
        (failure) => emit(ChatSocketError(
          message: failure.message,
          messages: state.messages,
        )),
        (data) {
          emit(ChatSocketConnected(messages: state.messages));
          add(ChatSocketListenToMessage());
        },
      );
    } catch (e) {
      emit(ChatSocketError(
        message: e.toString(),
        messages: state.messages,
      ));
    }
  }

  FutureOr<void> _handleDisonnectChatSocket(
      DisonnectChatSocket event, Emitter<ChatSocketState> emit) async {
    try {
      await disconnectChatMessageSocketUsecase(param: null);
      _messageSubscription?.cancel();
      emit(ChatSocketDisconnected(messages: state.messages));
    } catch (e) {
      emit(ChatSocketError(
        message: e.toString(),
        messages: state.messages,
      ));
    }
  }
FutureOr<void> _handleChatSocketEmitMessage(
      ChatSocketEmitMessage event, Emitter<ChatSocketState> emit) async {
    emit(ChatSocketSendingMessage(messages: state.messages));
    try {
      final result = await sendChatMessageUsecase(param: event.data);
      result.fold(
        (failure) => emit(ChatSocketError(
          message: failure.message,
          messages: state.messages,
        )),
        (data) => emit(ChatSocketMessageSent(
          sentMessage: data,
          messages: [...state.messages, data],
        )),
      );
    } catch (e) {
      emit(ChatSocketError(
        message: e.toString(),
        messages: state.messages,
      ));
    }
  }

  FutureOr<void> _handleChatSocketListenToMessage(
    ChatSocketListenToMessage event,
    Emitter<ChatSocketState> emit,
  ) {
    _messageSubscription?.cancel();
    _messageSubscription = listenToChatMessagesUsecase(param: null).listen(
      (messageEither) {
        messageEither.fold(
          (failure) => emit(ChatSocketError(
            message: failure.message,
            messages: state.messages,
          )),
          (message) => emit(ChatSocketMessageReceived(
            newMessage: message,
            messages: [...state.messages, message],
          )),
        );
      },
      onError: (error) {
        emit(ChatSocketError(
          message: error.toString(),
          messages: state.messages,
        ));
      },
    );
  }

  FutureOr<void> _handleChatFetchPreviousMessages(
      ChatFetchPreviousMessages event, Emitter<ChatSocketState> emit) async {
    emit(ChatFetchingPreviousMessages(messages: state.messages));
    try {
      final result =
          await fetchPreviousChatMessagesUsecase(param: event.params);
      result.fold(
        (failure) => emit(ChatSocketError(
          message: failure.message,
          messages: state.messages,
        )),
        (data) => emit(ChatFetchedPreviousMessages(messages: data)),
      );
    } catch (e) {
      emit(ChatSocketError(
        message: e.toString(),
        messages: state.messages,
      ));
    }
  }











//   FutureOr<void> _handleConnectChatSocket(
//       ConnectChatSocket event, Emitter<ChatSocketState> emit) async {
//     emit(ChatSocketConnecting());
//     try {
//       final result = await connectChatMessageSocketUsecase(param: null);
//       result.fold((failure) => emit(ChatSocketError(message: failure.message)),
//           (data) {
//         emit(ChatSocketConnected());
//         add(ChatSocketListenToMessage());
//       });
//     } catch (e) {
//       emit(ChatSocketError(message: e.toString()));
//     }
//   }

//   FutureOr<void> _handleDisonnectChatSocket(
//       DisonnectChatSocket event, Emitter<ChatSocketState> emit) async {
//     try {
//       await disconnectChatMessageSocketUsecase(param: null);
//       _messageSubscription?.cancel();
//       emit(ChatSocketDisconnected());
//     } catch (e) {
//       emit(ChatSocketError(message: e.toString()));
//     }
//   }

//   FutureOr<void> _handleChatSocketEmitMessage(
//       ChatSocketEmitMessage event, Emitter<ChatSocketState> emit) async {
//     emit(ChatSocketSendingMessage());
//     try {
//       final result = await sendChatMessageUsecase(param: event.data);
//       result.fold(
//         (failure) => emit(ChatSocketError(message: failure.message)),
//         (data) => {
//           emit(ChatSocketMessageSent(sentMessage: data))
//         });
//     } catch (e) {
//       emit(ChatSocketError(message: e.toString()));
//     }
//   }




// FutureOr<void> _handleChatSocketListenToMessage(
//     ChatSocketListenToMessage event,
//     Emitter<ChatSocketState> emit,
//   ) {
//     _messageSubscription?.cancel();
//     _messageSubscription = listenToChatMessagesUsecase(param:  null).listen(
//       (messageEither) {
//         messageEither.fold(
//           (failure) => emit(ChatSocketError(message: failure.message)),
//           (message) => emit(ChatSocketMessageReceived(newMessage: message)),
//         );
//       },
//       onError: (error) {
//         emit(ChatSocketError(message: error.toString()));
//       },
//     );
//   }

//   FutureOr<void> _handleChatFetchPreviousMessages(
//       ChatFetchPreviousMessages event, Emitter<ChatSocketState> emit) async {
//     emit(ChatFetchingPreviousMessages());
//     try {
//       final result =
//           await fetchPreviousChatMessagesUsecase(param: event.params);
//       result.fold((failure) => emit(ChatSocketError(message: failure.message)),
//           (data) => emit(ChatFetchedPreviousMessages(messages: data)));
//     } catch (e) {
//       emit(ChatSocketError(message: e.toString()));
//     }
//   }
}
