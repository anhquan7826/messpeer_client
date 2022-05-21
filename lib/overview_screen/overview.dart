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
  late GroupChatService _gcService;
  late PageController _pageController;
  int _selectedIndex = 0;
  late List<AppBar> _appBars;
  late List<Widget> _bodies;

  @override
  Widget build(BuildContext context) {
    _searchController = TextEditingController();
    _gcService = ModalRoute.of(context)!.settings.arguments as GroupChatService;
    _pageController = PageController();

    _appBars = [
      AppBar(
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
            fillColor: Colors.blueGrey[900],
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/overview/add');
            },
            label: const Text(
              'New group',
            ),
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
      ),
      AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        elevation: 0,
        title: Row(
          children: const [
            SizedBox(width: 5),
            Icon(Icons.notifications_none_outlined),
            SizedBox(width: 10),
            Text(
              'Announcements',
              style: TextStyle(
                fontSize: 20
              ),
            ),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Subscribe'),
          )
        ],
      ),
      AppBar(
        toolbarHeight: 200,
        backgroundColor: Colors.blueGrey.shade900,
        centerTitle: true,
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              child: Icon(
                Icons.person,
                size: 60,
              ),
              radius: 60,
            ),
            const SizedBox(height: 20),
            Text(
              username,
            )
          ],
        ),
      )
    ];

    _bodies = [
      Center(
        child: ListView.builder(
          itemCount: _gcService.getGroupChatList().length,
          itemBuilder: (context, index) {
            // TODO: display group tile
            return _groupTile(
              _gcService.getGroupChatList()[index].getGroupID(),
              _gcService.getGroupChatList()[index].getName(),
              _gcService.getGroupChatList()[index].getLatestMessage() == Message.empty ?
              null :
              _gcService.getGroupChatList()[index].getLatestMessage().getUsername() == username ?
              'You: ${_gcService.getGroupChatList()[index].getLatestMessage().getMessageContent()}' :
              _gcService.getGroupChatList()[index].getLatestMessage().getMessageContent()
            );
          }
        )
      ),
      const Center(
        child: Text(
          'Subscribe to an announcer to get announcements.',
          style: TextStyle(
            color: Colors.grey
          ),
        ),
      ),
      Center(
        child: ListView.builder(
          itemCount: _userSettingsTiles.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: _userSettingsTiles[index],
            );
          }
        ),
      )
    ];

    return Scaffold(
      appBar: _appBars.elementAt(_selectedIndex),
      backgroundColor: Colors.blueGrey.shade800,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _bodies,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Overview',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined),
            label: 'Announcements'
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: username
          )
        ],
        backgroundColor: Colors.blueGrey.shade900,
        elevation: 0,
        unselectedItemColor: Colors.grey.shade700,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
          });
        },
      ),
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
          Navigator.pushNamed(context, '/chat', arguments: _gcService.getGroupChat(id));
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

  final List<Widget> _userSettingsTiles = [
    ListTile(
      visualDensity: const VisualDensity(horizontal: 3, vertical: 0),
      contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      tileColor: Colors.blueGrey[700],
      selectedTileColor: Colors.blueGrey,
      textColor: Colors.white,
      onTap: () {},
      title: const Text('Log out.'),
      leading: const Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: Icon(
          Icons.logout,
          color: Colors.red,
        ),
      )
    )
  ];
}
