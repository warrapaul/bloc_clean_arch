class SocketEventsConstants {
    // Connection events
  static const String connect = 'connect';
  static const String disconnect = 'disconnect';
  static const String error = 'error';
  static const String reconnect = 'reconnect';

  // Custom events
  static const String newMessage = 'new_message';
  static const String messageReceived = 'message_received';
  static const String userTyping = 'user_typing';
  static const String userOnline = 'user_online';
  static const String userOffline = 'user_offline';
}