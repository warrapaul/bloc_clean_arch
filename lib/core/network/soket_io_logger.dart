import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketLogger {
  final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      colors: true,
      printEmojis: true,
    ),
  );

  void logConnection(String url, Map<String, dynamic> options) {
    logger.i('''
        SOCKET CONNECTION ATTEMPT
        URL: $url
        Options: {
          Path: ${options['path']}
          Transports: ${options['transports']}
          Headers: ${options['extraHeaders']}
          Auth: ${options['auth']}
          Reconnection Attempts: ${options['reconnectionAttempts']}
          Reconnection Delay: ${options['reconnectionDelay']}
        }
    ''');
  }

 void logConnectionSuccess(Socket? socket) {
    logger.i('''
      ✅ SOCKET CONNECTION ESTABLISHED
      ✅ Status: Connected
      ✅ Socket ID: ${socket?.id}
      ✅ Transport: ${socket?.io.engine?.transport?.name}
      ✅ Timestamp: ${DateTime.now()}
  ''');
  }

  void logConnectionError(dynamic error) {
    logger.e('''
        SOCKET CONNECTION ERROR
        Event: ${error.toString()}
        Timestamp: ${DateTime.now()}
    ''');
  }

  void logDisconnection(String reason) {
    logger.w('''
        SOCKET DISCONNECTED
        Reason: $reason
        Timestamp: ${DateTime.now()}
    ''');
  }

  void logEmit(String event, dynamic data) {
    logger.i('''
        SOCKET EVENT EMITTED
        Event: $event
        Payload: $data
        Timestamp: ${DateTime.now()}
    ''');
  }

  void logReceive(String event, dynamic data) {
    logger.d('''
        SOCKET EVENT RECEIVED
        Event: $event
        Data: $data
        Timestamp: ${DateTime.now()}
    ''');
  }

  void logReconnect(int attempt) {
    logger.w('''
        SOCKET RECONNECTION
        Attempt: $attempt
        Timestamp: ${DateTime.now()}
    ''');
  }


  void logListenerAdded(String event) {
    logger.w('''
        SOCKET EVENT LISTENER ADDED
        Event: $event
        Timestamp: ${DateTime.now()}
    ''');
  }

  void logListenerRemoved(String event) {
    logger.w('''
        SOCKET EVENT LISTENER REMOVED
        Event: $event
        Timestamp: ${DateTime.now()}
    ''');
  }



}
