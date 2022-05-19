import 'package:flutter/services.dart';
import 'package:messpeer_client/utils/utils.dart';

class AuthenticationService {
  late final MethodChannel _methodChannel;

  AuthenticationService(this._methodChannel);

  Future<bool> authenticate({required String username, required String password}) async {
    var _loginResult = CallState.CALLING;
    while (_loginResult == CallState.CALLING) {
      _loginResult = await _methodChannel.invokeMethod('authenticate',
          <String, String>{'username': username, 'password': password});
    }
    if (_loginResult == CallState.TRUE) {
      return true;
    }
    return false;
  }
}