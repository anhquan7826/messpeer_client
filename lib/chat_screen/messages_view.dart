import 'package:flutter/material.dart';
import 'dart:math';

Widget messageView() {
  List<String> message = [];
  return Expanded(
    child: StreamBuilder(
        stream: testString(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('Start conversation.'),
            );
          } else {
            message.insert(0, snapshot.data.toString());
            return ListView.builder(
                reverse: true,
                cacheExtent: 10,
                itemCount: message.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: message[index].split(':')[0] == 'true'
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: message[index].split(':')[0] == 'true'
                              ? Colors.grey.shade200
                              : Colors.blue[200],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          message[index].split(':')[1],
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
        }),
  );
}

Stream<String> testString() async* {
  while (true) {
    await Future.delayed(const Duration(seconds: 2));
    yield getRandomString(10);
  }
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) {
  return _rnd.nextBool().toString() +
      ':' +
      String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
