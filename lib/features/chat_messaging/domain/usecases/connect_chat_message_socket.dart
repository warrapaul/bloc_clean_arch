import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/repositories/chat_message_repository.dart';
import 'package:dartz/dartz.dart';

class ConnectChatMessageSocketUsecase
    extends UseCase<Either<Failure, String>, dynamic> {
  final ChatMessageRepository chatMessageRepository;

  ConnectChatMessageSocketUsecase({required this.chatMessageRepository});

  @override
  Future<Either<Failure, String>> call({required param}) async {
    return await chatMessageRepository.connect();
  }
}


