import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:messpeer_client/utils/authentication_service.dart';
import 'package:messpeer_client/utils/group_chat_service.dart';
import '../utils/utils.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  bool _isLoading = false;
  bool _loginResult = false;
  late GroupChatService gcService;

  Future<void> _login(String username, String password) async {
    setState(() {
      _isLoading = true;
    });
    _loginResult = await AuthenticationService(methodChannel).authenticate(username: username, password: password);
    if (_loginResult) {
      setUsername(username);
      gcService = GroupChatService(methodChannel: methodChannel, username: username);
      await gcService.initService();
    }
    setState(() {
      if (_loginResult) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, '/overview', arguments: gcService);
        });
      } else {
        _isLoading = false;
        showDialog(
          context: context,
          builder: (context) {
            return errorAlert('Error!', 'Incorrect username or password. Please try again!');
          },
        );
      }
    });
  }

  bool _validate(String username, String password) {
    // TODO: add more username and password requirements
    if (username.length < 6) {
      showDialog(context: context, builder: (context) {
        return errorAlert('Error!', 'Username has to have at least 6 characters!');
      });
      return false;
    }
    if (password.length < 8) {
      showDialog(context: context, builder: (context) {
        return errorAlert('Error!', 'Password has to have at least 8 characters!');
      });
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Messpeer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              const Text(
                'Please enter your credential...',
                style: TextStyle(
                    color: Colors.white60,
                    fontSize: 15.0
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                child: TextField(
                  autocorrect: false,
                  enableSuggestions: false,
                  controller: _usernameController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                      color: Colors.white
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Username...",
                    hintStyle: const TextStyle(
                      color: Colors.white30,
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey[700],
                  ),
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  autocorrect: false,
                  enableSuggestions: false,
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(
                      color: Colors.white
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Password...",
                    hintStyle: const TextStyle(
                      color: Colors.white30,
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey[700],
                  ),
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(height: 40.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: ElevatedButton.icon(
                  autofocus: true,
                  onPressed: () {
                    String username = _usernameController.text;
                    String password = _passwordController.text;
                    if (_validate(username, password)) {
                      _login(username, password);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: const Size(400.0, 50.0)
                  ),
                  label: _isLoading ? (_loginResult ? Text('Welcome ' + username + '!') : const Text('Signing in...')) : const Text('Sign in'),
                  icon: _isLoading ? const CircularProgressIndicator(
                    color: Colors.white,
                  ) : const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              const Divider(
                indent: 40.0,
                endIndent: 40.0,
                height: 40.0,
              ),
              const Text(
                "Don't have an account?",
                style: TextStyle(
                  color: Colors.white60,
                ),
              ),
              const SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: ElevatedButton(
                  autofocus: true,
                  onPressed: () {
                    // Navigator.pushNamed(context, '/login/signup');
                    showDialog(context: context, builder: (context) {
                      return errorAlert('Sign up', 'Please contact your manager to create your account!');
                    });
                  },
                  child: const Text('Sign up'),
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: const Size(400.0, 50.0)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget errorAlert(String title, String content) {
    return AlertDialog(
      backgroundColor: Colors.blueGrey[900],
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.white
        ),
      ),
      content: Text(
        content,
        style: const TextStyle(
            color: Colors.white
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        )
      ],
    );
  }
}
