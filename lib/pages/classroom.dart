import 'package:bgcsphere/assignment.dart';
import 'package:bgcsphere/pages/admitcard.dart';
import 'package:bgcsphere/pages/attendance_page.dart';
import 'package:bgcsphere/pages/category_page.dart';
import 'package:bgcsphere/pages/classes_page.dart';
import 'package:bgcsphere/pages/clubs_page.dart';
import 'package:bgcsphere/pages/result_page.dart';
import 'package:bgcsphere/pages/routine.dart';
import 'package:flutter/material.dart';

class Classroom extends StatelessWidget {
  final List<Map<String, dynamic>>? customItems;

  const Classroom({super.key, this.customItems});

  static List<Map<String, dynamic>> defaultClubItems = [
    {
      'title': 'Classes',
      'color': const Color(0xFF36AD52).withOpacity(0.48),
      'icon': 'images/class.png',
      'classes': true,
    },
    {
      'title': 'Attendance',
      'color': const Color(0xFF94D1E6),
      'icon': 'images/attendance.png',
      'attendance': true,
    },
    {
      'title': 'Routine',
      'color': const Color(0xFFA4A1E6),
      'icon': 'images/routine.png',
      'routine': true,
    },
    {
      'title': 'Admit Card',
      'color': const Color(0xFFFFC2B2),
      'icon': 'images/admitcard.png',
      'admit': true,
    },
    {
      'title': 'Assignment',
      'color': const Color(0xFF528AE1),
      'icon': 'images/assignment.png',
      'assignment': true,
    },
    {
      'title': 'Result',
      'color': const Color(0xFFE59EC1),
      'icon': 'images/result.png',
      'result': true,
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
                        "Classroom",
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
                      'images/clubs.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
              ],
            ),
            HomeItems(
              customItems: (customItems ?? defaultClubItems).map((item) {
                return {
                  ...item,
                  'onTap': () {
                    if (item['classes'] == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ClassesPage()),
                      );
                    }
                    if (item['routine'] == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Routine()),
                      );
                    }
                    if (item['admit'] == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Admitcard()),
                      );
                    }
                    if (item['result'] == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ResultPage(),
                        ),
                      );
                    }
                    if (item['attendance'] == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AttendancePage(),
                        ),
                      );
                    }
                    if (item['assignment'] == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Assignment()),
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
