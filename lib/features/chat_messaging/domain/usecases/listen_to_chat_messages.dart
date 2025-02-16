import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/entity/chat_message.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/repositories/chat_message_repository.dart';
import 'package:dartz/dartz.dart';

class ListenToChatMessagesUsecase  {
  final ChatMessageRepository chatMessageRepository;

  ListenToChatMessagesUsecase({required this.chatMessageRepository});

  Stream<Either<Failure, ChatMessage>> call({required param}) {
    return chatMessageRepository.receiveMessages();
  }
}

