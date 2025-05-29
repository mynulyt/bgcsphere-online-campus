import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Register> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Expanded(
                child: Container(color: Colors.white),
              ),
            ],
          ),
          // Login Form
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(10),
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
                      children: [
                        const SizedBox(height: 20),
                        _buildLoginForm(),
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

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Your Name"),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.4),
                fontWeight: FontWeight.normal),
            hintText: "Your Full Name",
            prefixIcon: const Icon(Icons.person_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text("Email address"),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.4),
                fontWeight: FontWeight.normal),
            hintText: "bgc@sphere.com",
            prefixIcon: const Icon(Icons.email_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text("Password"),
        const SizedBox(height: 5),
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.4),
                fontWeight: FontWeight.normal),
            hintText: "Enter your password",
            prefixIcon: const Icon(Icons.lock_outline),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text("Internal ID"),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.4),
                fontWeight: FontWeight.normal),
            hintText: "2402390****",
            prefixIcon: const Icon(Icons.roller_shades),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text("Phone Number"),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.4),
                fontWeight: FontWeight.normal),
            hintText: "019********",
            prefixIcon: const Icon(Icons.contact_emergency),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text("Blood Group"),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.4),
                fontWeight: FontWeight.normal),
            hintText: "Enter your Blood Group",
            prefixIcon: const Icon(Icons.bloodtype),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text("Division"),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.4),
                fontWeight: FontWeight.normal),
            hintText: "Enter your Division",
            prefixIcon: const Icon(Icons.add),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text("District"),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.4),
                fontWeight: FontWeight.normal),
            hintText: "Enter your District...",
            prefixIcon: const Icon(Icons.add),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text("Tana"),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.4),
                fontWeight: FontWeight.normal),
            hintText: "Enter your Tana...",
            prefixIcon: const Icon(Icons.add),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text("Union"),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.4),
                fontWeight: FontWeight.normal),
            hintText: "Enter your Union",
            prefixIcon: const Icon(Icons.add),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff6677CC),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {},
          child: const Text(
            "Register",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        const SizedBox(height: 20),
        const Center(child: Text("— OR —")),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialLoginButton("Google", "images/google.png"),
            const SizedBox(width: 15),
            _socialLoginButton("Facebook", "images/Facebook.png"),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _socialLoginButton(String text, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        onPressed: () {},
        icon: Image.asset(imagePath, height: 20),
        label: Text(text, style: const TextStyle(color: Colors.black)),
      ),
    );
  }
}
