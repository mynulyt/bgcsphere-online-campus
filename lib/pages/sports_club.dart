import 'package:flutter/material.dart';

class SportsClubPage extends StatelessWidget {
  const SportsClubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffA2ACE0).withOpacity(0.13),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Sports Club',
          style: TextStyle(
            letterSpacing: -0.2,
            height: 24,
            color: Color(0xff212329),
            fontSize: 24,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'images/sports.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Executive Panel',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    Container(
                      height: 85,
                      width: 85,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('images/profile.jpg'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Mynul Alam',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff768FCF),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      'President',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff536471),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildMember('images/profile1.jpg', 'Alisa', ['Treasurer']),
                    _buildMember('images/profile2.jpeg', 'Wizdan',
                        ['Programming', 'Executive']),
                    _buildMember(
                        'images/bgc.png', 'Alex', ['Executive', 'Member']),
                  ],
                ),
                const SizedBox(height: 25),
                const Text(
                  'Join Us',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildJoinIcon(
                        Icons.facebook_rounded, const Color(0xffFFFFFF)),
                    const SizedBox(width: 20),
                    _buildJoinIcon(
                        Icons.call_outlined, const Color(0xffFFFFFF)),
                    const SizedBox(width: 20),
                    _buildJoinIcon(Icons.send, const Color(0xffFFFFFF)),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Contact Us',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.phone, color: Colors.blue),
                    SizedBox(width: 8),
                    Text('123 456 789'),
                  ],
                ),
                const SizedBox(height: 3),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.email, color: Colors.blue),
                    SizedBox(width: 8),
                    Text('hola@gmail.com'),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMember(String imagePath, String name, List<String> roleLines) {
    return Column(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(imagePath),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          name,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xff768FCF),
            fontWeight: FontWeight.w600,
          ),
        ),
        Column(
          children: roleLines
              .map(
                (line) => Text(
                  line,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff536471),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildJoinIcon(IconData icon, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xff6677CC).withOpacity(0.58),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 24, color: bgColor),
    );
  }
}
