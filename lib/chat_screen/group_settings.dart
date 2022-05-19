import 'package:flutter/material.dart';
import 'package:messpeer_client/utils/group_chat_service.dart';

class GroupSettings extends StatefulWidget {
  const GroupSettings({Key? key}) : super(key: key);

  @override
  State<GroupSettings> createState() => _GroupSettingsState();
}

class _GroupSettingsState extends State<GroupSettings> {
  late GroupChat _groupChat;

  @override
  Widget build(BuildContext context) {
    _groupChat = ModalRoute.of(context)!.settings.arguments as GroupChat;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage ${_groupChat.getName()}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22.0
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.blueGrey[900],
      ),
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: ListView.builder(
          itemCount: tiles.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: tiles[index],
            );
          }
        ),
      ),
    );
  }

  final tiles = [
    ListTile(
      visualDensity: const VisualDensity(horizontal: 3, vertical: 0),
      contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      tileColor: Colors.blueGrey[700],
      selectedTileColor: Colors.blueGrey,
      textColor: Colors.white,
      onTap: () {},
      title: const Text('View Members.'),
      leading: const Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: Icon(
          Icons.people,
          color: Colors.white,
        ),
      ),
    ),
    ListTile(
      visualDensity: const VisualDensity(horizontal: 3, vertical: 0),
      contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      tileColor: Colors.blueGrey[700],
      selectedTileColor: Colors.blueGrey,
      textColor: Colors.white,
      onTap: () {},
      title: const Text('Leave Group.'),
      leading: const Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: Icon(
          Icons.directions_run_outlined,
          color: Colors.orange,
        ),
      ),
    ),
    ListTile(
      visualDensity: const VisualDensity(horizontal: 3, vertical: 0),
      contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      tileColor: Colors.blueGrey[700],
      selectedTileColor: Colors.blueGrey,
      textColor: Colors.white,
      onTap: () {},
      title: const Text('Delete Group.'),
      leading: const Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: Icon(
          Icons.delete_outline_outlined,
          color: Colors.red,
        ),
      ),
    )
  ];
}
