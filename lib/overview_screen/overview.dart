import 'package:flutter/material.dart';
import 'package:messpeer_client/utils/group_chat_service.dart';
import 'package:messpeer_client/utils/utils.dart';

class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  late TextEditingController _searchController;
  late GroupChatService gcService;

  @override
  Widget build(BuildContext context) {
    _searchController = TextEditingController();
    gcService = ModalRoute.of(context)!.settings.arguments as GroupChatService;

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
            onPressed: () {
              Navigator.pushNamed(context, '/overview/add');
            },
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
              itemCount: gcService.getGroupChatList().length,
              itemBuilder: (context, index) {
                // TODO: display group tile
                return _groupTile(
                    gcService.getGroupChatList()[index].getGroupID(),
                    gcService.getGroupChatList()[index].getName(),
                    gcService.getGroupChatList()[index].getLatestMessage() == Message.empty ?
                      null :
                      gcService.getGroupChatList()[index].getLatestMessage().getUsername() == username ?
                        'You: ${gcService.getGroupChatList()[index].getLatestMessage().getMessageContent()}' :
                        gcService.getGroupChatList()[index].getLatestMessage().getMessageContent()
                );
              })),
    );
  }

  Widget _groupTile(String id, String title, String? subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      child: ListTile(
        visualDensity: const VisualDensity(horizontal: 3, vertical: 0),
        contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        tileColor: Colors.blueGrey[700],
        selectedTileColor: Colors.blueGrey,
        textColor: Colors.white,
        onTap: () {
          Navigator.pushNamed(context, '/chat', arguments: gcService.getGroupChat(id));
        },
        title: Text(title, style: const TextStyle(fontSize: 20),),
        subtitle: subtitle == null ? null : Text(subtitle),
        // TODO: add group avatar
        leading: const CircleAvatar(
          child: Icon(
            Icons.people,
          ),
        ),
      ),
    );
  }
}
