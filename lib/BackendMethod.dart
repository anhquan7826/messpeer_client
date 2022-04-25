import 'package:flutter/services.dart';

class BackendMethod {
  static const methodChannel =
      MethodChannel('com.group2.messpeer_client/communication');

  Future<bool> authenticate(String username, String password) async {
    return await methodChannel.invokeMethod('authenticate',
        <String, String>{'username': username, 'password': password});
  }

  Future<void> sendMessage(
      String username, String groupID, String message) async {
    await methodChannel.invokeMethod('sendMessage', <String, String>{
      'username': username,
      'groupID': groupID,
      'message': message
    });
  }

  Future<void> createGroupChat(String name) async {
    await methodChannel.invokeMethod('createGroupChat', {'name': name});
  }
}
