import 'dart:async';

import 'package:bloc_clean_arch/core/constants/api_urls_constants.dart';
import 'package:bloc_clean_arch/core/constants/socket_events_constants.dart';
import 'package:bloc_clean_arch/core/network/dio_client.dart';
import 'package:bloc_clean_arch/core/network/socket_io_client.dart';
import 'package:bloc_clean_arch/core/network/socket_io_exception_handlers.dart';
import 'package:bloc_clean_arch/features/chat_messaging/data/models/chat_message_model.dart';
import 'package:bloc_clean_arch/features/chat_messaging/data/models/filter_chat_messages_req_params.dart';
import 'package:dio/dio.dart';

abstract class ChatMessageDatasource {
  Future<String> initializeSocketConnection();
  Future<String> connect();
  Future<String> disconnect();
  Future<ChatMessageModel> sendMessage(ChatMessageModel message);
  Stream<ChatMessageModel> receiveMessages();
  Future<List<ChatMessageModel>> fetchPreviousChatMessages(
      FilterChatMessagesReqParams params);
}

class ChatMessageDatasourceImpl extends ChatMessageDatasource {
  final SocketIoClient socketIoClient;
  final DioClient dioClient;

  final StreamController<ChatMessageModel> _messageController =
      StreamController<ChatMessageModel>.broadcast();

  ChatMessageDatasourceImpl({required this.socketIoClient, required this.dioClient}) {
    _setupMessageEventListener();
  }
  void _setupMessageEventListener() async{
    await  socketIoClient.on(SocketEventsConstants.messageReceived, (data) {
      try {
        final message = ChatMessageModel.fromJson(data);
        _messageController.add(message);
      } catch (e) {
        _messageController.addError(e);
      }
    });
  }

    @override
  Future<String> initializeSocketConnection()  async{
    try {
      await socketIoClient.initSocket();
      return 'socketInitialized';
    } catch (e) {
      throw CustomSocketIoException(
          message: 'Failed to initialize socket: ${e.toString()}');
    }
  }

  @override
  Future<String> connect() async {
    try {
      await socketIoClient.connect();
      return 'socketConnected';
    } catch (e) {
      throw CustomSocketIoException(
          message: 'Failed to connect: ${e.toString()}');
    }
  }

  @override
  Future<String> disconnect() async {
    try {
      await socketIoClient.disconnect();
      return 'socketDisconnected';
    } catch (e) {
      throw CustomSocketIoException(
          message: 'Failed to disconnect: ${e.toString()}');
    }
  }

  @override
  Future<List<ChatMessageModel>> fetchPreviousChatMessages(
      FilterChatMessagesReqParams param) async {
    try {
      Map<String, dynamic> parameters = {
        'limit': param.pageSize,
        'skip': param.page,
        'sortBy': param.sortBy,
        'order': param.sortOrder,
        'q': param.searchPhrase,
      }..removeWhere((key, value) => value == null);
      Response response = await dioClient.get(
        ApiUrlsConstants.fetchPreviousChatMessages,
        queryParameters: parameters,
      );
      List<dynamic> jsonData = response.data['messages'];
      List<ChatMessageModel> chatMessageModels =
          jsonData.map((json) => ChatMessageModel.fromJson(json)).toList();
      return chatMessageModels;
    } catch (e) {
      throw Exception('Error fetching previous chat messages ${e.toString()}');
    }
  }

  @override
  Stream<ChatMessageModel> receiveMessages() {
    try {
          return _messageController.stream;
    } catch (e) {
          throw Exception('Error receiving messages ${e.toString()}');
    }
  }

  @override
  Future<ChatMessageModel> sendMessage(ChatMessageModel message) async{
    try {
      await socketIoClient.emit(SocketEventsConstants.newMessage, message);
      // return the saved message - access via acknowledgement


       // Simulate server acknowledgment with a temporary ID
      final savedMessage = ChatMessageModel(
        message.message,
        message.isUser,
        message.status,
        message.type,
        message.mediaUrl,
        id: 'temp_${DateTime.now().millisecondsSinceEpoch}', // Temporary ID
        senderId: message.senderId,
        timestamp: DateTime.now(),
      );


      _messageController.add(message);
      return savedMessage;

    } catch (e) {
      _messageController.addError(e);
      throw Exception('Failed to send message: ${e.toString()}');
    }
  }
  

}
