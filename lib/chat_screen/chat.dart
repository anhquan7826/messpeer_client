import 'package:flutter/material.dart';
import 'package:messpeer_client/chat_screen/chat_box.dart';
import 'package:messpeer_client/chat_screen/messages_view.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'MessPeer',
          ),
          centerTitle: true,

        ),
        body: Column(
          children: <Widget>[
            messageView(),
            chatBox(_messageController),
          ],
        )
    );
  }
}
