import 'package:flutter/material.dart';

class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  Map testMap = {
    'Alice': 'hello',
    'Bob': 'what cha doin?',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        leadingWidth: 70.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.blueGrey[900],
        title: ElevatedButton.icon(
          onPressed: () {},
          icon: const CircleAvatar(
            child: Icon(Icons.person),
            radius: 25.0,
          ),
          label: const Text('Current User'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            elevation: MaterialStateProperty.all(0)
          ),
        ),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                fixedSize: MaterialStateProperty.all(const Size(5.0, 5.0))
            ),
              onPressed: () {},
              child: const Icon(Icons.add)
          ),
        ],
      ),
      backgroundColor: Colors.blueGrey[900],
      body: Center(
          child: ListView.builder(
              itemCount: testMap.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                  child: ListTile(
                    visualDensity: const VisualDensity(horizontal: 3, vertical: 0),
                    contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    tileColor: Colors.blueGrey[700],
                    selectedTileColor: Colors.blueGrey,
                    textColor: Colors.white,
                    onTap: () {},
                    title: Text(testMap.keys.elementAt(index)),
                    subtitle: Text(testMap.values.elementAt(index)),
                    leading: const CircleAvatar(
                      child: Icon(
                        Icons.person,
                      ),
                    ),
                  ),
                );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/chat');
        },
        child: const Icon(
          Icons.add,
          semanticLabel: 'New message',
        ),
      ),
    );
  }
}
