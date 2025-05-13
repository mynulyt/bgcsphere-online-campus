import 'package:bgcsphere/pages/category_page.dart';
import 'package:bgcsphere/pages/clubs_page.dart';
import 'package:bgcsphere/pages/codingclub_page.dart';
import 'package:flutter/material.dart';

class ClubDetails extends StatelessWidget {
  final List<Map<String, dynamic>>? customItems;

  const ClubDetails({super.key, this.customItems});

  static const List<Map<String, dynamic>> defaultClubItems = [
    {
      'title': 'Coding Club',
      'color': Color(0xFFA4A1E6),
      'icon': 'images/coding.png',
      'isCodingClub': true,
    },
    {
      'title': 'Cultural\n Club',
      'color': Color(0xFF3CB5E0),
      'icon': 'images/music.png'
    },
    {
      'title': 'Sports Club',
      'color': Color(0xFFFFC1B2),
      'icon': 'images/sports.png'
    },
    {
      'title': 'Robotics\n Club',
      'color': Color(0xFF528AE1),
      'icon': 'images/robotics.png'
    },       
      {
      'title': 'Research\n Club',
      'color': Color(0xFF528AE1),
      'icon': 'images/Frame.png'
    },     
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color(0xffA2ACE0).withOpacity(0.13),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                         icon: const Icon(Icons.arrow_back_ios_new),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Text(
                        "Clubs",
                        style: TextStyle(
                          fontSize: 20, 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
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
                        icon: const Icon(Icons.category, size: 30),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CategoryPage()
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
              Image.asset('images/clubs.png',),
            ClubsPage(
              customItems: (customItems ?? defaultClubItems).map((item) {
                return {
                  ...item,
                  'onTap': () {
                    if (item['isCodingClub'] == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CodingClubPage()
                        ),
                      );
                    } 
                  },
                };
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}