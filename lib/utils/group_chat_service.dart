import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:messpeer_client/utils/utils.dart';
import 'package:collection/collection.dart';

class Message extends Comparable {
  late String _messageID;
  late DateTime _timestamp;
  late String _username;
  late String _content;

  Message(Map message) {
    _messageID = message['message_id'];
    _timestamp = DateTime.parse(message['timestamp']);
    _username = message['username'];
    _content = message['content'];
  }

  String getMessageID() {
    return _messageID;
  }

  String getMessageContent() {
    return _content;
  }

  String getUsername() {
    return _username;
  }

  DateTime getTimestamp() {
    return _timestamp;
  }

  static final Message empty = Message({'message_id': 'empty', 'timestamp': '1970-01-01 00:00:00', 'username': 'empty', 'content': 'empty'});

  @override
  int compareTo(other) {
    return other.getTimestamp().compareTo(getTimestamp());
  }

  @override
  int get hashCode => _messageID.hashCode;

  @override
  bool operator ==(Object other) {
    return hashCode == other.hashCode;
  }

  @override
  String toString() {
    return _messageID + ':' + _username + ':' + _timestamp.toString() + ':' + _content;
  }
}

class GroupChat extends Comparable {
  late PriorityQueue<Message> _messageList;
  late final String _id;
  late String _name;
  late String _host;

  GroupChat(this._id, this._name) {
    _messageList = PriorityQueue<Message>();
  }

  String getGroupID() {
    return _id;
  }

  PriorityQueue<Message> getMessageList() {
    return _messageList;
  }

  void addMessage(Message message) {
    _messageList.add(message);
  }

  Message getLatestMessage() {
    if (_messageList.isEmpty) return Message.empty;
    return _messageList.first;
  }

  String getName() {
    return _name;
  }

  void setName(String name) {
    _name = name;
  }

  String getHost() {
    return _host;
  }

  @override
  String toString() {
    return _name + "-" + _id;
  }

  @override
  int compareTo(other) {
    return getLatestMessage().compareTo(other.getLatestMessage());
  }
}

class GroupChatService {
  late MethodChannel _methodChannel;
  late String _username;
  late Map<String, GroupChat> _groupChat;

  GroupChatService({required MethodChannel methodChannel, required String username}) {
    _groupChat = {};
    _methodChannel = methodChannel;
    _username = username;
  }

  Future<void> initService() async {
    await _initGroup();
    _initMessage();
  }

  Future<void> _initMessage() async {
    while (true) {
      String? message = await methodChannel.invokeMethod('getMessage');
      if (message == null) continue;
      Map msgObj = jsonDecode(message);
      _groupChat[msgObj["group_id"]]?.addMessage(Message(msgObj));
    }
  }

  Future<void> _initGroup() async {
    dynamic groupList = CallState.CALLING;
    while (groupList == CallState.CALLING) {
      groupList = await _methodChannel.invokeMethod('getGroupChatList');
    }
    groupList = groupList as Map;
    groupList.forEach((key, value) {
      _groupChat.addAll({key: GroupChat(key, value)});
    });
  }

  GroupChat? getGroupChat(String id) {
    return _groupChat[id];
  }

  Future<void> sendMessage({required String id, required String content}) async {
    Map message = {
      'message_id': generateID(20),
      'group_id': id,
      'username': _username,
      'timestamp': getTime(),
      'content': content
    };
    _methodChannel.invokeMethod('sendMessage', jsonEncode(message));
    _groupChat[id]!.addMessage(Message(message));
  }

  List<GroupChat> getGroupChatList() {
    return _groupChat.values.toList();
  }

  @override
  String toString() {
    return _groupChat.values.toString();
  }
}