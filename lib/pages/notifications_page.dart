import 'package:bgcsphere/main.dart';
import 'package:bgcsphere/pages/chat_page.dart';
import 'package:bgcsphere/pages/newsfeed_page.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NewsfeedPage()),
        );
        break;

      case 2:
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ChatPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Notifications',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: const Color(0xffF3F4FB),
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Container(
              padding: const EdgeInsets.only(right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: TabBar(
                      dividerColor: Color(0xffF3F4FB),
                      isScrollable: false,
                      labelColor: Color(0xFF6677CC),
                      unselectedLabelColor: Color(0xff697386),
                      indicatorColor: Color(0xFF6677CC),
                      tabs: [
                        Tab(text: 'All'),
                        Tab(text: 'Unread'),
                        Tab(text: 'Read'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 120,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF768FCF)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                        ),
                        child: const Text(
                          "Mark as all read",
                          style:
                              TextStyle(color: Color(0xFF24293E), fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            NotificationList(),
            Center(child: Text('Unread')),
            Center(child: Text('Read')),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: const Color(0xff6677CC).withOpacity(0.61),
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.feed_outlined),
              label: 'Newsfeed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              label: 'Chat',
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 16, left: 10, right: 10, bottom: 2),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('images/profile.jpg'),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Mynul Alam',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xff24293E)),
                            ),
                            TextSpan(
                              text: ' requested to approve his post.',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xff24293E)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      ApprovalButtons(),
                      SizedBox(height: 10),
                      Text(
                        "Last Wednesday at 9:42 AM",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
        Padding(
          padding:
              const EdgeInsets.only(top: 12, left: 10, right: 10, bottom: 10),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('images/bgc.png'),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Sahiba',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            TextSpan(text: ' commented on Mynul\'s post.'),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'BGC Trust University Bangladesh offers affordable education in a peaceful rural ...',
                        style: TextStyle(color: Colors.black87, fontSize: 16),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "20 min ago",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider()
      ],
    );
  }
}

class ApprovalButtons extends StatefulWidget {
  const ApprovalButtons({super.key});

  @override
  State<ApprovalButtons> createState() => _ApprovalButtonsState();
}

class _ApprovalButtonsState extends State<ApprovalButtons> {
  String selected = '';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selected = 'approve';
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: selected == 'approve'
                  ? const Color(0xFF768FCF)
                  : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF768FCF)),
            ),
            child: Text(
              "Approve",
              style: TextStyle(
                color: selected == 'approve'
                    ? Colors.white
                    : const Color(0xFF24293E),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            setState(() {
              selected = 'cancel';
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color:
                  selected == 'cancel' ? const Color(0xFF768FCF) : Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFF768FCF)),
            ),
            child: Text(
              "Cancel",
              style: TextStyle(
                color: selected == 'cancel'
                    ? Colors.white
                    : const Color(0xFF24293E),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
