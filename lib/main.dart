import 'package:flutter/material.dart';
import 'package:messpeer_client/chat_screen/chat.dart';
import 'package:messpeer_client/chat_screen/group_settings.dart';
import 'package:messpeer_client/login_screen/login.dart';
import 'package:messpeer_client/overview_screen/add_group.dart';
import 'package:messpeer_client/overview_screen/overview.dart';

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
          primarySwatch: Colors.blueGrey,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const Login(),
          '/overview': (context) => const Overview(),
          '/chat': (context) => const Chat(),
          '/chat/settings': (context) => const GroupSettings(),
          '/overview/add': (context) => const AddGroup(),
        },
        );
  }
}
