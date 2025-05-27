import 'package:flutter/material.dart';

class ExcursionCard extends StatelessWidget {
  final String purpose;
  final String date;
  final String? place;
  final String? duration;
  final String totalFund;
  final String totalCollected;
  final String lastDate;
  final String imagePath;
  final VoidCallback onViewCostTable;
  final VoidCallback onViewContributors;
  final VoidCallback onProceed;

  const ExcursionCard({
    super.key,
    required this.purpose,
    required this.date,
    this.place,
    this.duration,
    required this.totalFund,
    required this.totalCollected,
    required this.lastDate,
    required this.imagePath,
    required this.onViewCostTable,
    required this.onViewContributors,
    required this.onProceed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Purpose: $purpose",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xff768FCF),
              ),
            ),
            const SizedBox(height: 4),
            Text("Date: $date",
                style:
                    const TextStyle(color: Color(0xff536471), fontSize: 16)),
            if (place != null && place!.isNotEmpty)
              Text("Place: $place",
                  style:
                      const TextStyle(color: Color(0xff536471), fontSize: 16)),
            if (duration != null && duration!.isNotEmpty)
              Text("Duration: $duration",
                  style:
                      const TextStyle(color: Color(0xff536471), fontSize: 16)),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                height: 183,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text("Total Fund: $totalFund",
                style:
                    const TextStyle(color: Color(0xff536471), fontSize: 16)),
            Text("Total collected: $totalCollected",
                style:
                    const TextStyle(color: Color(0xff536471), fontSize: 16)),
            Text("Last date: $lastDate",
                style:
                    const TextStyle(color: Color(0xff536471), fontSize: 16)),
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Total Cost table",
                  style:
                      TextStyle(color: Color(0xff536471), fontSize: 16)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: onViewCostTable,
            ),
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Contributor List",
                  style:
                      TextStyle(color: Color(0xff536471), fontSize: 16)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: onViewContributors,
            ),
            const Divider(),
            Center(
              child: SizedBox(
                width: 287,
                height: 42,
                child: ElevatedButton(
                  onPressed: onProceed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6677CC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Proceed',
                    style: TextStyle(fontSize: 16, color: Color(0xffFFFFFF)),
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
