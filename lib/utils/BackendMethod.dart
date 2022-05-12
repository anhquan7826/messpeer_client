import 'package:flutter/services.dart';
import 'package:messpeer_client/utils/message_stream.dart';

class BackendMethod {
  static BackendMethod? _instance;

  BackendMethod._() {
    _createMessageStream();
    _chatGroups = {};
  }

  static BackendMethod? getInstance() {
    _instance ??= BackendMethod._();
    return _instance;
  }

  static const _methodChannel = MethodChannel('com.group2.messpeer_client/communication');
  late Map<String, GroupChat> _chatGroups;

  Future<void> _createMessageStream() async {
    while (true) {
      String? receivedMessage = await _methodChannel.invokeMethod('getMessage');
      if (receivedMessage == null) {
        continue;
      }
      String username = receivedMessage.split(':')[1].split(' ')[0];
      String groupID = receivedMessage.split(':')[1].split(' ')[1];
      String message = receivedMessage.split(':')[1].split(' ')[2];

      // TODO: process message.
      Message obj = Message('null', username, message);

      if (_chatGroups.containsKey(groupID)) {
        _chatGroups[groupID]!.addMessage(obj);
      } else {
        _chatGroups[groupID] = GroupChat(groupID);
        _chatGroups[groupID]!.addMessage(obj);
      }
    }
  }

  GroupChat getGroupChat(String groupID) {
    return _chatGroups[groupID]!;
  }

  Future<dynamic> getGroupIDList() async {
    return await _methodChannel.invokeMethod('getGroupChatList');
  }

  Future<String> authenticate(String username, String password) async {
    return await _methodChannel.invokeMethod('authenticate',
        <String, String>{'username': username, 'password': password});
  }

  Future<String> isAuthenticated() async {
    return await _methodChannel.invokeMethod('isAuthenticated');
  }

  Future<void> sendMessage(String username, String groupID, String message) async {
    await _methodChannel.invokeMethod('sendMessage', <String, String>{
      'username': username,
      'groupID': groupID,
      'message': message
    });
  }

  Future<bool> groupChatCreate(String name) async {
    return await _methodChannel.invokeMethod('groupChatCreate', {'name': name});
  }

  Future<bool> groupChatDelete(String groupID) async {
    return await _methodChannel.invokeMethod('groupChatDelete', {'groupChatID': groupID});
  }

  Future<bool> groupChatAdd(String username, String groupID) async {
    return await _methodChannel.invokeMethod('groupChatAdd', {'username': username,'groupChatID': groupID});
  }

  Future<bool> groupChatKick(String username, String groupID) async {
    return await _methodChannel.invokeMethod('groupChatKick', {'username': username,'groupChatID': groupID});
  }

  Future<bool> groupChatChangeHost(String username, String groupID) async {
    return await _methodChannel.invokeMethod('groupChatChangeHost', {'username': username,'groupChatID': groupID});
  }
}
