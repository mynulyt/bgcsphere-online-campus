import 'package:bgcsphere/pages/notice_details.dart';
import 'package:flutter/material.dart';
import 'package:bgcsphere/pages/category_page.dart';
import 'notice_card.dart';


class NoticePage extends StatelessWidget {
  const NoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 144,
              color: const Color(0xffA2ACE0).withOpacity(0.13),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
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
                        "Notice Board",
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xff212329),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                  const SizedBox(height: 5),
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
                            builder: (context) => const CategoryPage(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            NoticeCard(
              title:
                  'Special Retake Examination Schedule for MBA Programs, Session- Summer-2024 (July - December).',
              date: 'Tuesday, 15 May',
              onViewPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NoticeDetails(),
                  ),
                );
              },
            ),
            NoticeCard(
              title:
                  'Tuition fees related notice for 8th semester students of all undergraduate programs.',
              date: 'Thursday, 23 May',
              onViewPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NoticeDetails(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
