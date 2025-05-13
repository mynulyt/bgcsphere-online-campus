import 'package:flutter/material.dart';
import 'package:bgcsphere/pages/login.dart';

class JoinAsScreen extends StatefulWidget {
  const JoinAsScreen({super.key});

  @override
  _JoinAsScreenState createState() => _JoinAsScreenState();
}

class _JoinAsScreenState extends State<JoinAsScreen> {
  String selectedRole = "Student";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  height: 438,
                  width: 438,
                  color: const Color(0xff768FCF),
                  child: Image.asset(
                    "images/wow.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(color: Colors.white),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.40),
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Join as",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF212329),
                          ),
                        ),
                        const SizedBox(height: 30),
                        buildRoleButton("Student"),
                        const SizedBox(height: 15),
                        buildRoleButton("Teacher"),
                        const SizedBox(height: 15),
                        buildRoleButton("Alumni"),
                        const SizedBox(height: 15),
                        buildRoleButton("Authority"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRoleButton(String role) {
    bool isSelected = selectedRole == role;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = role;
        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      },
      child: Container(
        width: 324,
        height: 52,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6677CC) : Colors.transparent,
          border: Border.all(
            color: const Color(0xFF6677CC),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            role,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF141466),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
