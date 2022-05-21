import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey.shade900,
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: Center(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  child: TextField(
                    keyboardType: TextInputType.visiblePassword,
                    autocorrect: false,
                    enableSuggestions: false,
                    controller: _firstNameController,
                    obscureText: true,
                    style: const TextStyle(
                        color: Colors.white
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "First name...",
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
                    controller: _lastNameController,
                    obscureText: true,
                    style: const TextStyle(
                        color: Colors.white
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Last name...",
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
                    controller: _emailController,
                    obscureText: true,
                    style: const TextStyle(
                        color: Colors.white
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Email...",
                      hintStyle: const TextStyle(
                        color: Colors.white30,
                      ),
                      filled: true,
                      fillColor: Colors.blueGrey[700],
                    ),
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.navigate_next),
                  label: const Text('Continue'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
