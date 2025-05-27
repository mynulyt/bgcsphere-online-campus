import 'package:flutter/material.dart';

class NoticeCard extends StatelessWidget {
  final String title;
  final String date;
  final VoidCallback onViewPressed;

  const NoticeCard({
    Key? key,
    required this.title,
    required this.date,
    required this.onViewPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
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
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF768FCF),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.edit_document,
                    size: 24, color: Color(0xff1E1E1E)),
                const SizedBox(width: 6),
                Text(
                  date,
                  style: const TextStyle(color: Color(0xff536471)),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Center(
              child: SizedBox(
                width: 287,
                height: 50,
                child: ElevatedButton(
                  onPressed: onViewPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6677CC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'View',
                    style: TextStyle(fontSize: 18, color: Color(0xffFFFFFF)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
