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
        title: const Text(
          'Messpeer',

        ),
      ),
      drawer: Drawer(
        child: ListView(

        ),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: testMap.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                child: ListTile(
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
            }
        )
      ),
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
