import 'package:flutter/material.dart';

class AddGroup extends StatefulWidget {
  const AddGroup({Key? key}) : super(key: key);

  @override
  State<AddGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey[900],
        title: const Text('Add new group...'),
      ),
      backgroundColor: Colors.blueGrey[900],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Enter group name...',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _controller,
                  style: const TextStyle(
                      color: Colors.white
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Name...",
                    hintStyle: const TextStyle(
                      color: Colors.white30,
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey[700],
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                width: 120,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_controller.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.blueGrey[900],
                            title: const Text(
                              'Error!',
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                            content: const Text(
                              'Group name cannot be empty!',
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
                        }
                      );
                    } else {

                    }
                  },
                  label: const Text('Create'),
                  icon: const Icon(Icons.add),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
