import 'package:bgcsphere/pages/club_details.dart';
import 'package:flutter/material.dart';

class ClubsPage extends StatelessWidget {
  final List<Map<String, dynamic>> clubItems;

  const ClubsPage({
    super.key,
    List<Map<String, dynamic>>? customItems,
  }) : clubItems = customItems ?? _defaultClubItems;

  static const List<Map<String, dynamic>> _defaultClubItems = [
    {
      'title': 'Clubs',
      'color': Color(0xFFA4A1E6),
      'icon': 'images/club.png'
    },
    {
      'title': 'Support',
      'color': Color(0xFF3CB5E0),
      'icon': 'images/support.png'
    },
    {
      'title': 'Blood Donation',
      'color': Color(0xFFFFC1B2),
      'icon': 'images/blooddonation.png'
    },
    {
      'title': 'Donation',
      'color': Color(0xFF528AE1),
      'icon': 'images/donation.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 25.0,
          mainAxisSpacing: 25.0,
        ),
        itemCount: clubItems.length,
        itemBuilder: (context, index) {
          final item = clubItems[index];
          return SizedBox(
            width: 91,
            height: 96,
            child: GestureDetector(
              onTap: () {
                if (item['onTap'] != null && item['onTap'] is Function) {
                  item['onTap']();
                } else {
                  _navigateToClubDetails(context);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: item['color'],
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: _buildClubItemContent(item),
              ),
            ),
          );
        },
      ),
    );
  }

  void _navigateToClubDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ClubDetails()),
    );
  }

  Widget _buildClubItemContent(Map<String, dynamic> item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            item['title'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
         const SizedBox(height: 10),
        Image.asset(
          item['icon'],
          height: 37,
          width: 37,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) =>
              const Icon(Icons.error_outline, size: 40),
        ),
       
      ],
    );
  }
}
