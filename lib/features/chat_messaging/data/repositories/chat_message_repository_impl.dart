import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/features/chat_messaging/data/datasources/chat_message_datasource.dart';
import 'package:bloc_clean_arch/features/chat_messaging/data/models/chat_message_model.dart';
import 'package:bloc_clean_arch/features/chat_messaging/data/models/filter_chat_messages_req_params.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/entity/chat_message.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/repositories/chat_message_repository.dart';
import 'package:dartz/dartz.dart';

class ChatMessageRepositoryImpl extends ChatMessageRepository {
  final ChatMessageDatasource chatMessageDatasource;


  ChatMessageRepositoryImpl({required this.chatMessageDatasource});

  @override
  Future<Either<Failure, String>> initializeSocketConnection() async {
    try {
      String status = await chatMessageDatasource.initializeSocketConnection();
      return Right(status);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> connect() async {
    try {
      String status = await chatMessageDatasource.connect();
      return Right(status);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> disconnect() async {
    try {
      String status = await chatMessageDatasource.disconnect();
      return Right(status);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ChatMessage>>> fetchPreviousChatMessages(
      FilterChatMessagesReqParams params) async {
    try {
      List<ChatMessageModel> chatMessagesModels =
          await chatMessageDatasource.fetchPreviousChatMessages(params);
      List<ChatMessage> chatMessages =
          chatMessagesModels.map((chatmodel) => chatmodel.toEntity()).toList();
      return Right(chatMessages);
    } catch (e) {
       return Left(Failure(message: e.toString()));
    }
  }

@override
  Stream<Either<Failure, ChatMessage>> receiveMessages() {
    return chatMessageDatasource
        .receiveMessages()
        .map<Either<Failure, ChatMessage>>(
          (message) => Right(message.toEntity()),
        )
        .handleError(
          (error) => Left(Failure(message: error.toString())),
        );
  }



  @override
  Future<Either<Failure, ChatMessage>> sendMessage(ChatMessage message) async {
    try {
    // Convert domain entity to data model
    final messageModel = ChatMessageModel(
      message.message,
      message.isUser,
      message.status,
      message.type,
      message.mediaUrl,
      id: message.id,
      senderId: message.senderId,
      timestamp: message.timestamp,
    );
    
    // Send through datasource and get saved message back
    final savedMessage = await chatMessageDatasource.sendMessage(messageModel);
    
    // Convert back to domain entity and return
    return Right(savedMessage.toEntity());
  } catch (e) {
    return Left(Failure(message: e.toString()));
  }
  }
  

}
