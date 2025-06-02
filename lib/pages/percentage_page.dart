import 'package:flutter/material.dart';

class PercentagePage extends StatelessWidget {
  final String courseName;
  final String teacherName;

  const PercentagePage({
    super.key,
    required this.courseName,
    required this.teacherName,
  });

  @override
  Widget build(BuildContext context) {
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
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Course Name: ${courseName.split(' ').take(2).join(' ')}\n${courseName.split(' ').skip(2).join(' ')}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF768FCF),
                              fontSize: 16,
                            ),
                            softWrap: true, // Ensures text wraps to next line
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Course Teacher: $teacherName',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
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
            const Divider(
              color: Color(0xff6677CC),
              thickness: 0.3,
              indent: 20,
              endIndent: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 475,
                width: 374,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffF3F4FB),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      courseName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF768FCF),
                        fontSize: 20,
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: SizedBox(
                            width: 270,
                            height: 260,
                            child: CircularProgressIndicator(
                              value: 0.54,
                              strokeWidth: 20,
                              backgroundColor: Colors.grey[200],
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Color(0xFF768FCF)),
                            ),
                          ),
                        ),
                        const Text(
                          '54%',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF768FCF),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Total Present',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xff6677CC),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 287,
                      height: 38,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6677CC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Close",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
