import 'package:bgcsphere/pages/category_page.dart';

import 'package:bgcsphere/pages/clubs_page.dart';
import 'package:bgcsphere/pages/departmental.dart';
import 'package:bgcsphere/pages/donation.dart';

import 'package:bgcsphere/pages/support.dart';
import 'package:flutter/material.dart';

class FundRaising extends StatelessWidget {
  final List<Map<String, dynamic>>? customItems;

  const FundRaising({super.key, this.customItems});

  static List<Map<String, dynamic>> defaultClubItems = [
    {
      'title': 'Deaprtmental',
      'color': Color(0xFFA4A1E6),
      'icon': 'images/dept.png',
      'dept': true,
    },
    {
      'title': 'Donation',
      'color': Color(0xFF94D1E6),
      'icon': 'images/donation.png',
      'donation': true,
    },
    {
      'title': 'Support',
      'color': Color(0xFF36AD52).withOpacity(0.48),
      'icon': 'images/support.png',
      'support': true,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        "Clubs",
                        style:
                            TextStyle(fontSize: 24, color: Color(0xff212329)),
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
                        icon: Image.asset('images/Filter.png'),
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
            Stack(
              children: [
                Center(
                    child: Image.asset(
                  'images/Vector.png',
                  color: const Color(0xffF3F4FB),
                  height: 280,
                  width: 316,
                )),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Center(
                    child: Image.asset(
                      'images/fundr.png',
                      width: 198,
                      height: 189,
                    ),
                  ),
                ),
              ],
            ),
            ClubsPage(
              customItems: (customItems ?? defaultClubItems).map((item) {
                return {
                  ...item,
                  'onTap': () {
                    if (item['dept'] == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Departmental()),
                      );
                    }
                    if (item['donation'] == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Donation()),
                      );
                    }
                    if (item['support'] == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Support()),
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
