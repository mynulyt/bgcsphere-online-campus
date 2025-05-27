import 'package:flutter/material.dart';

class InfoCard extends StatefulWidget {
  final String name;
  final String subtitleLabel;
  final String subtitleValue;
  final String imagePath;

  const InfoCard({
    super.key,
    required this.name,
    required this.subtitleLabel,
    required this.subtitleValue,
    required this.imagePath,
  });

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  String selected = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xffF3F4FB),
        border: Border.all(color: const Color(0xFF768FCF)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundImage: AssetImage(widget.imagePath),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    color: Color(0xFF768FCF),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.subtitleLabel.isNotEmpty
                      ? "${widget.subtitleLabel}: ${widget.subtitleValue}"
                      : widget.subtitleValue,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff536471),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = 'call';
                          });
                        },
                        child: Container(
                          height: 39,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: selected == 'call'
                                ? const Color(0xFF768FCF)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFF768FCF)),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Call",
                            style: TextStyle(
                              fontSize: 16,
                              color: selected == 'call'
                                  ? Colors.white
                                  : const Color(0xFF24293E),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = 'message';
                          });
                        },
                        child: Container(
                          height: 39,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: selected == 'message'
                                ? const Color(0xFF768FCF)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFF768FCF)),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Message",
                            style: TextStyle(
                              fontSize: 16,
                              color: selected == 'message'
                                  ? Colors.white
                                  : const Color(0xFF24293E),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
void showPaymentMethodCard(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
        child: Align( 
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffE3EBFF),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new),
                        onPressed: () => Navigator.pop(context),
                        color: const Color(0xff6677CC),
                      ),
                      const SizedBox(width: 30),
                      const Expanded(
                        child: Text(
                          'Payment Method',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff6677CC),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  buildPaymentOption('images/card.png', 35),
                  const Divider(color: Color(0xff6677CC), thickness: 0.3),
                  buildPaymentOption('images/bkash.png', 51),
                  const Divider(color: Color(0xff6677CC), thickness: 0.3),
                  buildPaymentOption('images/nagad.png', 38),
                  const Divider(color: Color(0xff6677CC), thickness: 0.3),
                  buildPaymentOption('images/cod.png', 73),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget buildPaymentOption(String imagePath, double imageHeight) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: [
        Image.asset(imagePath, height: imageHeight),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios, color: Color(0xff6677CC)),
      ],
    ),
  );
}

class PostOptionItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const PostOptionItem({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Color(0xFF6677CC),
        size: 30,
      ),
      title: Text(
        label,
        style: const TextStyle(fontSize: 15),
      ),
      onTap: () {},
    );
  }
}



 Widget buildProfileButton(String title, IconData icon, VoidCallback onTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade100),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        leading: Icon(icon, color: Colors.blue),
        onTap: onTap,
      ),
    ),
  );
}




