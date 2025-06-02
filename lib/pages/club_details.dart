import 'package:bgcsphere/pages/category_page.dart';
import 'package:bgcsphere/pages/clubs_page.dart';
import 'package:bgcsphere/pages/codingclub_page.dart';
import 'package:bgcsphere/pages/cultural_club.dart';

import 'package:bgcsphere/pages/rechearch_club.dart';
import 'package:bgcsphere/pages/robotices_club.dart';
import 'package:bgcsphere/pages/sports_club.dart';

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
      'icon': 'images/music.png',
      'isCulturalClub': true,
    },
    {
      'title': 'Sports Club',
      'color': Color(0xFFFFC1B2),
      'icon': 'images/sports.png',
      'isSportsClub': true,
    },
    {
      'title': 'Robotics\n Club',
      'color': Color(0xFF528AE1),
      'icon': 'images/robotics.png',
      'isRoboticsClub': true,
    },
    {
      'title': 'Research\n Club',
      'color': Color(0xFF528AE1),
      'icon': 'images/Frame.png',
      'isResearchClub': true,
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
                              builder: (context) => const CategoryPage()),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Image.asset('images/clubs.png'),
            HomeItems(
              customItems: (customItems ?? defaultClubItems).map((item) {
                return {
                  ...item,
                  'onTap': () {
                    if (item['isCodingClub'] == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CodingClubPage()),
                      );
                    } else if (item['isCulturalClub'] == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CulturalClub()),
                      );
                    } else if (item['isSportsClub'] == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SportsClubPage()),
                      );
                    } else if (item['isRoboticsClub'] == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RoboticesClubPage()),
                      );
                    } else if (item['isResearchClub'] == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResearchClubPage()),
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
