import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:collection/collection.dart';

class Message extends Comparable {
  late DateTime _timestamp;
  late String _username;
  late String _message;

  Message(String timestamp, String username, String message) {
    _timestamp = DateTime.parse(timestamp);
    _username = username;
    _message = message;
  }

  String getMessage() {
    return _message;
  }

  String getUsername() {
    return _username;
  }

  DateTime getTimestamp() {
    return _timestamp;
  }

  @override
  int compareTo(other) {
    // TODO: implement compareTo
    return getTimestamp().compareTo(other.getTimestamp());
  }
}

class GroupChat {
  late final String _groupID;
  late StreamController<Message> _messageStream;

  GroupChat(this._groupID) {
    _messageStream = StreamController<Message>();
  }

  String getGroupID() {
    return _groupID;
  }

  Stream<Message> getMessageStream() {
    return _messageStream.stream;
  }

  void addMessage(Message message) {
    _messageStream.add(message);
  }
}

class MessageStream {
  late Stream<String> _stream;
}
