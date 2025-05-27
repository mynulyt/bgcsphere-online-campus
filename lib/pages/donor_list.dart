import 'package:bgcsphere/pages/assetpage.dart';
import 'package:flutter/material.dart';
import 'package:bgcsphere/pages/category_page.dart';


class DonorList extends StatelessWidget {
  const DonorList({super.key});

  final List<Map<String, String>> donors = const [
    {
      "name": "Salma Morsheda",
      "date": "24 March 2024",
      "image": "images/profile.jpg",
    },
    {
      "name": "Arju Akter",
      "date": "16 April 2025",
      "image": "images/profile1.jpg",
    },
    {
      "name": "Umme Hafsa",
      "date": "12 June 2024",
      "image": "images/profile2.jpeg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 144,
            color: const Color(0xffA2ACE0).withOpacity(0.13),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        "Donor List",
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xff212329),
                        ),
                      ),
                    ],
                  ),
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
                          builder: (context) => const CategoryPage(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: donors.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                final donor = donors[index];
                return InfoCard(
                  name: donor["name"]!,
                  subtitleLabel: "Last Donation Date",
                  subtitleValue: donor["date"]!,
                  imagePath: donor["image"]!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
