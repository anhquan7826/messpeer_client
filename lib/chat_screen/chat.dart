import 'dart:convert';

import 'package:flutter/material.dart';
import '../utils/group_chat_service.dart';
import '../utils/utils.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late TextEditingController _messageController;
  late GroupChat _groupChat;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _groupChat = ModalRoute.of(context)!.settings.arguments as GroupChat;
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.blueGrey[900],
        title: Row(
          children: <Widget>[
            const SizedBox(
              width: 2,
            ),
            const CircleAvatar(
              child: Icon(Icons.people),
              maxRadius: 20,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _groupChat.getName(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              )),
            ),
            onPressed: () {},
            child: const Icon(Icons.call)
          ),
          const SizedBox(
            width: 3.0,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              )),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/chat/settings', arguments: _groupChat);
            },
            child: const Icon(Icons.settings)
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          _messageView(),
          _inputBox(),
        ],
      ));
  }

  Widget _inputBox() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _messageController,
              style: const TextStyle(
                  color: Colors.white
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: "Your message here...",
                hintStyle: const TextStyle(
                  color: Colors.white30,
                ),
                filled: true,
                fillColor: Colors.blueGrey[800],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              mini: false,
              elevation: 0,
              child: const Icon(Icons.send),
              onPressed: () {
                setState(() {
                  if (_messageController.text.isNotEmpty) {
                    _sendMessage(_messageController.text);
                    _messageController.clear();
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _messageView() {
    return Expanded(
      child: _groupChat.getMessageList().isEmpty ? Center(
        child: Text(
            'Start conversation.',
            style: TextStyle(color: Colors.grey.shade700)),
      ) : ListView.builder(
        reverse: true,
        cacheExtent: 10,
        itemCount: _groupChat.getMessageList().length,
        itemBuilder: (context, index) {
          return Padding(
            padding: _groupChat.getMessageList().toList()[index].getUsername() == username ?
            const EdgeInsets.only(left: 50, right: 14, top: 5, bottom: 5) :
            const EdgeInsets.only(left: 14, right: 50, top: 5, bottom: 5),
            child: Column(
              children: [
                Align(
                  alignment: _groupChat.getMessageList().toList()[index].getUsername() == username
                      ? Alignment.topRight
                      : Alignment.topLeft,
                  child: Text(
                    _groupChat.getMessageList().toList()[index].getUsername(),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10,

                    ),
                  ),
                ),
                const SizedBox(height: 2.0),
                Align(
                  alignment: _groupChat.getMessageList().toList()[index].getUsername() == username
                      ? Alignment.topRight
                      : Alignment.topLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: _groupChat.getMessageList().toList()[index].getUsername() == username
                          ? Colors.blueGrey
                          : Colors.blueGrey[700],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      _groupChat.getMessageList().toList()[index].getMessageContent(),
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ));
  }

  Future<void> _sendMessage(String content) async {
    Map<String, String> message = {};
    message['message_id'] = generateID(20);
    message['username'] = username;
    message['group_id'] = _groupChat.getGroupID();
    message['timestamp'] = await getTime();
    message['content'] = content;
    _groupChat.addMessage(Message(message));
    methodChannel.invokeMethod('sendMessage', {'message': jsonEncode(message)});
  }
}
