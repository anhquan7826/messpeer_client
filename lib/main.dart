import 'package:flutter/material.dart';
import 'package:messpeer_client/chat_screen/chat.dart';
import 'package:messpeer_client/login_screen/login.dart';
import 'package:messpeer_client/overview_screen/overview.dart';
import 'loading_screen/loading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messpeer',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Chat(),
      // initialRoute: '/chat',
      // routes: {
      //   '/': (context) => Loading(),
      //   '/login': (context) => Login(),
      //   '/overview': (context) => Overview(),
      //   '/chat': (context) => Chat(),
      // },
    );
  }
}
