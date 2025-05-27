import 'package:bgcsphere/pages/category_page.dart';
import 'package:flutter/material.dart';

class ClassesPage extends StatelessWidget {
  const ClassesPage({super.key});

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
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        "Classes",
                        style:
                            TextStyle(fontSize: 24, color: Color(0xff212329)),
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
                              builder: (context) => const CategoryPage()),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Container(
                width: 365,
                height: 210,
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Course Name: Software Development Project-2',
                      style: TextStyle(
                        color: Color(0xFF768FCF),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Course Teather: Md. Asaduzzaman',
                      style: TextStyle(
                        color:Color(0xff536471),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Row(
                      children: [
                        Icon(Icons.calendar_today,
                            size: 24, color:Color(0xff1E1E1E)),
                        SizedBox(width: 6),
                        Text(
                          'Tuesday, 15 May',
                          style: TextStyle(color:Color(0xff536471)),
                        ),
                        SizedBox(width: 16),
                        Icon(Icons.access_time, size: 24, color: Color(0xff1E1E1E)),
                        SizedBox(width: 6),
                        Text(
                          '9:00 PM',
                          style: TextStyle(color: Color(0xff536471)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        width: 287,
                        height: 42,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF6677CC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text(
                            'Join Class',
                            style: TextStyle(fontSize: 16,color: Color(0xffFFFFFF)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
