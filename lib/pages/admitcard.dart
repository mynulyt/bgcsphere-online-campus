import 'package:flutter/material.dart';

class Admitcard extends StatelessWidget {
  const Admitcard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 81,
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
                        "Admit Card",
                        style:
                            TextStyle(fontSize: 24, color: Color(0xff212329)),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                child: Image.asset('images/admit.png'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: 287,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6677CC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Download',
                  style: TextStyle(fontSize: 20, color: Color(0xffFFFFFF)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
