import 'package:bgcsphere/pages/blood_type_selector.dart';
import 'package:flutter/material.dart';
import 'package:bgcsphere/pages/category_page.dart';
import 'package:bgcsphere/pages/clubs_page.dart';
import 'package:bgcsphere/pages/donor_list.dart';

class BloodDonation extends StatefulWidget {
  final List<Map<String, dynamic>>? customItems;

  const BloodDonation({super.key, this.customItems});

  static List<Map<String, dynamic>> defaultClubItems = [
    {
      'title': 'Donate',
      'color': const Color(0xFFA4A1E6),
      'icon': 'images/blood_bag.png',
      'donate': true,
    },
    {
      'title': 'Request',
      'color': const Color(0xFF94D1E6),
      'icon': 'images/request.png',
      'request': true,
    },
    {
      'title': 'Support',
      'color': const Color(0xFF36AD52).withOpacity(0.48),
      'icon': 'images/support.png',
      'support': true,
    },
  ];

  @override
  State<BloodDonation> createState() => _BloodDonationState();
}

class _BloodDonationState extends State<BloodDonation> {
  String selectedBloodType = 'O+';

  final List<String> bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          "Blood Donation",
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CategoryPage()),
                          );
                        },
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Center(
                    child: Image.asset(
                      'images/blood.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              'Select Blood Type',
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF768FCF),
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: BloodTypeSelector(
                bloodTypes: bloodTypes,
                selectedType: selectedBloodType,
                onSelected: (type) {
                  setState(() {
                    selectedBloodType = type;
                  });
                },
              ),
            ),
            const SizedBox(height: 0),
            HomeItems(
              customItems:
                  (widget.customItems ?? BloodDonation.defaultClubItems)
                      .map((item) {
                return {
                  ...item,
                  'onTap': () {
                    if (item['donate'] == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DonorList()),
                      );
                    } else if (item['request'] == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DonorList()),
                      );
                    } else if (item['support'] == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DonorList()),
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
