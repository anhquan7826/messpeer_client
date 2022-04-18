import 'package:flutter/material.dart';

Widget chatBox(TextEditingController _messageController) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _messageController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              hintText: "Your text here...",
            ),
            onChanged: (value) {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            mini: false,
            elevation: 0,
            child: const Icon(
              Icons.send,
            ),
            onPressed: () {},
          ),
        )
      ],
    ),
  );
}