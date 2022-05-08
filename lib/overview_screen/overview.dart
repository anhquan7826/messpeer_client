import 'package:flutter/material.dart';
import 'package:messpeer_client/utils/BackendMethod.dart';

class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  late TextEditingController _searchController;
  late List<String> groupList;

  @override
  void initState() {
    _searchController = TextEditingController();
    BackendMethod.getInstance()!.getGroupIDList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.blueGrey[900],
        leading: const Padding(
          padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
          child: CircleAvatar(
            child: Icon(
              Icons.person,
              size: 15.0,
            ),
          ),
        ),
        title: TextField(
          controller: _searchController,
          autocorrect: false,
          enableSuggestions: false,
          style: const TextStyle(
              color: Colors.white
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: "Search group...",
            hintStyle: const TextStyle(
              color: Colors.white30,
            ),
            filled: true,
            fillColor: Colors.blueGrey[800],
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {},
            label: const Text(
              'New group',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
            ),
            icon: const Icon(
              Icons.add,
              size: 15.0,
            ),
          )
        ],
      ),
      backgroundColor: Colors.blueGrey[900],
      body: Center(
          child: ListView.builder(
              itemCount: groupList.length,
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
                    onTap: () {
                      Navigator.pushNamed(context, '/chat', arguments: {
                        'groupID': groupList[index],
                      });
                    },
                    title: Text(BackendMethod.getInstance()!.getGroupChat(groupList[index]).getName()),
                    subtitle: Text(BackendMethod.getInstance()!.getGroupChat(groupList[index]).getLatestMessage().getMessage()),
                    leading: const CircleAvatar(
                      child: Icon(
                        Icons.person,
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}
