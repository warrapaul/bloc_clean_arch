import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/entity/chat_message.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/repositories/chat_message_repository.dart';
import 'package:dartz/dartz.dart';


class SendChatMessageSocketUsecase
    extends UseCase<Either<Failure, ChatMessage>, ChatMessage> {
  final ChatMessageRepository chatMessageRepository;

  SendChatMessageSocketUsecase({required this.chatMessageRepository});

  @override
  Future<Either<Failure, ChatMessage>> call({required ChatMessage param}) async {
    return await chatMessageRepository.sendMessage(param);
  }
}
