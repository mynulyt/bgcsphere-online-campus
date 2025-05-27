import 'package:bgcsphere/pages/ExcursionCard.dart';
import 'package:bgcsphere/pages/category_page.dart';
import 'package:flutter/material.dart';

class Departmental extends StatelessWidget {
  const Departmental({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: const Color(0xffA2ACE0).withOpacity(0.13),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                const SizedBox(height: 10),
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
                      "Deparmental",
                      style: TextStyle(fontSize: 24, color: Color(0xff212329)),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
                const SizedBox(height: 6),
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
          ExcursionCard(
            purpose: "Excursion",
            date: "18 April 2025",
            place: "Saint Martin",
            duration: "2 days",
            totalFund: "****tk",
            totalCollected: "****tk",
            lastDate: "17 April 2025",
            imagePath: 'images/saint.png',
            onViewCostTable: () {},
            onViewContributors: () {},
            onProceed: () {},
          )
        ],
      ),
    );
  }
}
