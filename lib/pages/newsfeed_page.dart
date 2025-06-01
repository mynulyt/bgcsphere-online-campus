import 'package:bgcsphere/pages/category_page.dart';
import 'package:bgcsphere/pages/main_page.dart';
import 'package:bgcsphere/pages/notifications_page.dart';
import 'package:flutter/material.dart';

class NewsfeedPage extends StatefulWidget {
  const NewsfeedPage({super.key});

  @override
  State<NewsfeedPage> createState() => _NewsfeedPageState();
}

class _NewsfeedPageState extends State<NewsfeedPage> {
  int _selectedIndex = 1;

  final List<Map<String, dynamic>> posts = [
    {
      'profilePic': 'images/profile1.jpg',
      'name': 'John Doe',
      'type': 'Student',
      'text':
          'Dart, the programming language, powers Flutter to craft visually stunning, natively compiled apps. Together, they enable seamless cross-platform development for Android, iOS, web, and more. Build faster, smarter, and with fewer limitations—embrace Dart and Flutter today!',
      'image': '',
      'time': '2h ago',
      'likes': 12,
      'comments': 3,
      'shares': 5,
    },
    {
      'profilePic': 'images/profile.jpg',
      'name': 'Umme Hafsa',
      'type': 'Student',
      'text':
          'BGC Trust University Bangladesh offers affordable education in a peaceful rural setting. With a variety of programs and modern facilities, it provides students with opportunities to grow academically and professionally.',
      'image': 'images/campus.png',
      'time': '20 min ago',
      'likes': 24,
      'comments': 5,
      'shares': 5,
    },
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
        break;
      case 1:
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NotificationsPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffA2ACE0).withOpacity(0.13),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 40, left: 20, right: 20, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search...",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: Image.asset('images/Filter.png'),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CategoryPage()),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return _buildPostContainer(posts[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xff6677CC).withOpacity(0.61),
        unselectedItemColor: Colors.black,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: 'Newsfeed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }

  Widget _buildPostContainer(Map<String, dynamic> post) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(post['profilePic']),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xff768FCF),
                          ),
                        ),
                        Text(
                          post['type'],
                          style: const TextStyle(
                            color: Color(0xff536471),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(post['text']),
          ),
          const SizedBox(height: 12),
          if (post['image'] != null && post['image'].isNotEmpty)
            Image.asset(
              post['image'],
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              post['time'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xff768FCF),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon:
                          const Icon(Icons.favorite, color: Color(0xffF94868)),
                      onPressed: () {},
                    ),
                    Text('${post['likes']}'),
                  ],
                ),
                const SizedBox(width: 10),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.messenger_outline),
                      onPressed: () {},
                    ),
                    Text('${post['comments']}'),
                  ],
                ),
                const SizedBox(width: 10),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {},
                    ),
                    Text('${post['shares']}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
