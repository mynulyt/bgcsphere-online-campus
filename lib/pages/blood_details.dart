import 'package:bgcsphere/pages/blood_type_selector.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BloodDetails extends StatefulWidget {
  const BloodDetails({super.key});

  @override
  State<BloodDetails> createState() => _BloodDetailsState();
}

class _BloodDetailsState extends State<BloodDetails> {
  int age = 24;
  String selectedGender = 'female';
  String selectedBlood = 'O+';
  DateTime? donationDate;

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

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: donationDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        donationDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4FF),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("images/profile.jpg"),
                ),
                Positioned(
                  right: 4,
                  bottom: 4,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(3),
                    child:
                        const Icon(Icons.edit, size: 16, color: Colors.black54),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Gender :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff536471),
                                      fontSize: 16)),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  _genderIcon("female", Icons.female),
                                  const SizedBox(width: 10),
                                  _genderIcon("male", Icons.male),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Age: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff536471),
                                      fontSize: 16)),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  CircleAvatar(
                                    child: IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () => setState(
                                          () => age = age > 0 ? age - 1 : 0),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text("$age",
                                      style: const TextStyle(fontSize: 18)),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  CircleAvatar(
                                    child: IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () => setState(() => age++),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Blood Type',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF536471),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: BloodTypeSelector(
                          bloodTypes: bloodTypes,
                          selectedType: selectedBlood,
                          onSelected: (type) {
                            setState(() {
                              selectedBlood = type;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text("Last Blood Donation Date",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff536471),
                              fontSize: 16)),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: _pickDate,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xff768FCF)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                donationDate != null
                                    ? DateFormat('dd  MMMM  yyyy')
                                        .format(donationDate!)
                                    : 'Select Date',
                                style: const TextStyle(
                                    fontSize: 16, color: Color(0xff536471)),
                              ),
                              const Icon(
                                Icons.calendar_month,
                                color: Color(0xff768FCF),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Row(
                        children: [
                          Icon(Icons.check_circle_outline,
                              color: Color(0xFF6677CC)),
                          SizedBox(width: 6),
                          Text("I agree all the "),
                          Text(
                            "Terms and Conditions",
                            style: TextStyle(
                              color: Color(0xFF6677CC),
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6677CC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            "Save",
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Sign Out",
              style: TextStyle(
                color: Color(0xFF768FCF),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _genderIcon(String gender, IconData icon) {
    final isSelected = selectedGender == gender;
    return GestureDetector(
      onTap: () => setState(() => selectedGender = gender),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6677CC) : const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: isSelected ? Colors.white : Colors.black54),
      ),
    );
  }
}
