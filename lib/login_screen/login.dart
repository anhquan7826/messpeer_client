import 'package:flutter/material.dart';
import 'package:messpeer_client/utils/BackendMethod.dart';

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

  Future<void> _login(String username, String password) async {
    setState(() {
      _isLoading = true;
    });
    _loginResult = await BackendMethod.getInstance()!.authenticate(username, password);
    setState(() {
      _isLoading = false;
      if (_loginResult) {
        Navigator.pushReplacementNamed(context, '/overview', arguments: {
          // TODO: get userdata
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.blueGrey[900],
              title: const Text(
                'Error',
                style: TextStyle(
                    color: Colors.white
                ),
              ),
              content: const Text(
                'Incorrect username or password!',
                style: TextStyle(
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
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Column(
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
            padding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
            child: TextField(
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
            child: ElevatedButton(
              onPressed: () {
                String username = _usernameController.text;
                String password = _passwordController.text;
                _login(username, password);
              },
              child: _isLoading ? const CircularProgressIndicator(
                color: Colors.white,
              ) : const Text('Sign in'),
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minimumSize: const Size(400.0, 50.0)
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
              onPressed: () {  },
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
    );
  }
}
