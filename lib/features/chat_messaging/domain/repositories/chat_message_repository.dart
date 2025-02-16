import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/features/chat_messaging/data/models/filter_chat_messages_req_params.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/entity/chat_message.dart';
import 'package:dartz/dartz.dart';

abstract class ChatMessageRepository {
  Future<Either<Failure, String>> connect();
  Future<Either<Failure, String>> disconnect();
  Future<Either<Failure, ChatMessage>> sendMessage(ChatMessage message);
  Stream<Either<Failure, ChatMessage>> receiveMessages();
  Future<Either<Failure, List<ChatMessage>>> fetchPreviousChatMessages(
      FilterChatMessagesReqParams params);
}
