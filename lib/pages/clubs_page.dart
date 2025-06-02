import 'package:bgcsphere/Messenger/Screens%20Page/splash_screen.dart';
import 'package:bgcsphere/pages/blood_donation.dart';
import 'package:bgcsphere/pages/chat_page.dart';
import 'package:bgcsphere/pages/club_details.dart';
import 'package:bgcsphere/pages/classroom.dart';
import 'package:bgcsphere/pages/fund_raising.dart';
import 'package:bgcsphere/pages/notice_page.dart';
import 'package:flutter/material.dart';

class HomeItems extends StatelessWidget {
  final List<Map<String, dynamic>> clubItems;

  HomeItems({
    super.key,
    List<Map<String, dynamic>>? customItems,
  }) : clubItems = customItems ?? _defaultClubItems;

  static final List<Map<String, dynamic>> _defaultClubItems = [
    {
      'title': 'Clubs',
      'color': const Color(0xFFA4A1E6),
      'icon': 'images/club.png',
      'clubs': true,
    },
    {
      'title': 'Support',
      'color': const Color(0xFF3CB5E0),
      'icon': 'images/support.png',
      'support': true,
    },
    {
      'title': 'Blood Donation',
      'color': const Color(0xFFFFC1B2),
      'icon': 'images/blooddonation.png',
      'bloodDonation': true,
    },
    {
      'title': 'Fundraising',
      'color': const Color(0xFF528AE1),
      'icon': 'images/fund.png',
      'fund': true,
    },
    {
      'title': 'Classroom',
      'color': const Color(0xFF36AD52).withOpacity(0.48),
      'icon': 'images/class.png',
      'classroom': true,
    },
    {
      'title': 'Notices',
      'color': const Color(0xFFE59EC1),
      'icon': 'images/notice.png',
      'notice': true,
    },
    {
      'title': 'Let\' Chat',
      'color': const Color(0xFF36AD52).withOpacity(0.48),
      'icon': 'images/chatt.jfif',
      'chat': true,
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
            width: 96,
            height: 91,
            child: GestureDetector(
              onTap: () {
                if (item['onTap'] != null && item['onTap'] is Function) {
                  item['onTap']();
                } else {
                  _handleItemTap(context, item);
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

  void _handleItemTap(BuildContext context, Map<String, dynamic> item) {
    if (item['clubs'] == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ClubDetails()),
      );
    } else if (item['classroom'] == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Classroom()),
      );
    } else if (item['bloodDonation'] == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BloodDonation()),
      );
    } else if (item['notice'] == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NoticePage()),
      );
    } else if (item['fund'] == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FundRaising()),
      );
    } else if (item['chat'] == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SplashScreen2()),
      );
    }
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
          height: 28,
          width: 28,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) =>
              const Icon(Icons.error_outline, size: 40),
        ),
      ],
    );
  }
}
