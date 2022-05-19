import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:http/http.dart';

MethodChannel methodChannel = const MethodChannel('com.group2.messpeer_client');

Future<String> getTime() async {
  Response response = await get(Uri.parse("http://worldtimeapi.org/api/timezone/Asia/Ho_Chi_Minh"));
  Map data = jsonDecode(response.body);
  String time = data['datetime'];
  time = time.replaceAll('T', ' ');
  time = time.replaceRange(time.indexOf('+'), time.length, '');
  return time;
}

Set<String> _values = {
  '1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
  'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
};

String generateID(int length) {
  Random random = Random();
  StringBuffer sb = StringBuffer();
  for (int i = 0; i < length; i++) {
    sb.write(_values.elementAt(random.nextInt(_values.length - 1)));
  }
  return sb.toString();
}

class CallState {
  static const String CALLING = "CALLING";
  static const String IDLE = "IDLE";
  static const String TRUE = "TRUE";
  static const String FALSE = "FALSE";
  static const String ERROR = "ERROR";
}

late final String username;
void setUsername(String uname) {
  username = uname;
}