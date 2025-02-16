import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_clean_arch/features/chat_messaging/data/models/filter_chat_messages_req_params.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/entity/chat_message.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/repositories/chat_message_repository.dart';
import 'package:dartz/dartz.dart';

class FetchPreviousChatMessagesUsecase extends UseCase<
    Either<Failure, List<ChatMessage>>, FilterChatMessagesReqParams> {
  final ChatMessageRepository chatMessageRepository;

  FetchPreviousChatMessagesUsecase({required this.chatMessageRepository});
  @override
  Future<Either<Failure, List<ChatMessage>>> call(
      {required FilterChatMessagesReqParams param}) async {
    return await chatMessageRepository.fetchPreviousChatMessages(param);
  }
}
