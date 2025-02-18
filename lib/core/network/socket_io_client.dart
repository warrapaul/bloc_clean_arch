import 'dart:async';
import 'package:bloc_clean_arch/core/constants/api_urls_constants.dart';
import 'package:bloc_clean_arch/core/network/auth_token_manager.dart';
import 'package:bloc_clean_arch/core/network/soket_io_logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIoClient {
  final tokenManager;
  final SocketLogger _logger = SocketLogger();
  IO.Socket? _socket;
  final _initCompleter = Completer<void>();
  Future<void> get initialized => _initCompleter.future;
  int _reconnectionAttempts = 0;

  SocketIoClient({required this.tokenManager}) {}

  Future<void> initSocket() async {
    try {
      const authToken =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJlYTMyNThkNy0zOTExLTQzYzMtOTNiZC03NDEyODE5ZTUyYTIiLCJlbWFpbCI6IndhcmFwYXVsQGdtYWlsLmNvbSIsImlhdCI6MTczOTYyMTcyNCwiZXhwIjoxNzQ1NjY5NzI0fQ.dwBW20rft-Y__D35D9OjoFIL3zVk0qMIhp_4Su7Mm64';
      // final authToken = await tokenManager.getToken();

      if (authToken == null) {
        throw Exception('No auth token available');
      }

      final options = {
        'path': ApiUrlsConstants.socketPath,
        'transports': ['websocket'],
        'extraHeaders': {'Authorization': 'Bearer $authToken'},
        // 'auth': {'Authorization': 'Bearer $authToken'},
        'reconnectionAttempts': 10,
        'reconnectionDelay': 2000,
        'reconnectionDelayMax': 10000,
      };

      _logger.logConnection(ApiUrlsConstants.socketUrl, options);

      // _socket = IO.io(
      //   ApiUrlsConstants.socketUrl,
      //   IO.OptionBuilder()
      //       .setPath(options['path'] as String)
      //       .setTransports(options['transports'] as List<String>)
      //       .setExtraHeaders(options['extraHeaders'] as Map<String, String>)
      //       // .setAuth(options['auth'] as Map<String, String>)
      //       .setReconnectionAttempts(options['reconnectionAttempts'] as int)
      //       .setReconnectionDelay(options['reconnectionDelay'] as int)
      //       .setReconnectionDelayMax(options['reconnectionDelayMax'] as int)
      //       .enableAutoConnect()
      //       .build(),
      // );

      _socket = IO.io(
        ApiUrlsConstants.socketUrl,
        IO.OptionBuilder()
            .setPath(ApiUrlsConstants.socketPath)
            .setTransports(['websocket']) //,'polling'
            .enableAutoConnect()
            // .setExtraHeaders({'Authorization': 'Bearer $authToken'})
            .setAuth({ 'Authorization': 'Bearer $authToken'})
            .setReconnectionAttempts(10)
            .setReconnectionDelay(2000)
            .setReconnectionDelayMax(10000)
            .build(),
      );

      _setupSocketListeners();
      _initCompleter.complete();
    } catch (e) {
      _logger.logConnectionError(e);
      _initCompleter.completeError(e);
    }
  }

  void _setupSocketListeners() {
    _socket?.onConnect((_) {
      _logger.logConnectionSuccess(_socket);
      _reconnectionAttempts = 0;
    });

    _socket?.onDisconnect((_) {
      _logger.logDisconnection('Client disconnected');
    });

    _socket?.onError((error) {
      _logger.logConnectionError(error);
    });

    _socket?.onReconnect((_) {
      _reconnectionAttempts++;
      _logger.logReconnect(_reconnectionAttempts);
    });

    // ===========================================================
    _socket?.on('error', (error) {
      _logger.logConnectionError('Socket Error Event: $error');
    });

    // Listen for 'connect_error' events
    _socket?.on('connect_error', (error) {
      _logger.logConnectionError('Socket Connect Error: $error');
    });

    // Listen for 'message' events
    _socket?.on('message', (data) {
      _logger.logReceive('message', data);
    });

    _socket?.on('message:new', (data) {
      _logger.logReceive('broadcastMessage', data);
    });

    // Wildcard listener to log all incoming events
    _socket?.onAny((event, data) {
      _logger.logReceive(event, data);
    });
    // ===================================================
  }

  Future<void> connect() async {
    await initialized;
    if (_socket != null && !_socket!.connected) {
      _socket!.connect();
    }
  }

  Future<void> emit(String event, dynamic data) async {
    await initialized;
    if (_socket != null) {
      _logger.logEmit(event, data);
      _socket!.emit(event, data);
    }
  }

  Future<void> on(String event, Function(dynamic) handler) async {
    await initialized;
    if (_socket != null) {
      _socket!.on(event, (data) {
        _logger.logListenerAdded(event);
        handler(data);
      });
    }
  }

  Future<void> off(String event) async {
    await initialized;
    if (_socket != null) {
      _socket!.off(event);
      _logger.logListenerRemoved(event);
    }
  }

  Future<void> disconnect() async {
    await initialized;
    if (_socket != null) {
      _socket!.disconnect();
      _logger.logDisconnection('nnnn');
    }
  }

  Future<bool> isConnected() async {
    await initialized;
    return _socket?.connected ?? false;
  }
}
