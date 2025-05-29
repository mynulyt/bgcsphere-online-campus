import 'package:bgcsphere/pages/percentage_page.dart';
import 'package:flutter/material.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = [
      {
        'name': 'Software Development Project-2',
        'teacher': 'Md. Asaduzzaman',
      },
      {
        'name': 'Computer Network',
        'teacher': 'Md. Salahuddin Chowdhury',
      },
      {
        'name': 'Simulation',
        'teacher': 'Fesdous Ara',
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                height: 81,
                color: const Color(0xffA2ACE0).withOpacity(0.13),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          "Attendance",
                          style: TextStyle(
                            fontSize: 24,
                            color: Color(0xff212329),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: courses.length,
                separatorBuilder: (context, index) => const Divider(
                  color: Color(0xff6677CC),
                  thickness: 0.3,
                ),
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PercentagePage(
                            courseName: course['name']!,
                            teacherName: course['teacher']!,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Course Name: ${course['name']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF768FCF),
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Course Teather: ${course['teacher']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            size: 24,
                            color: Color(0xFF6677CC),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
