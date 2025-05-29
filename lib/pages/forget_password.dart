import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff6677CC),
        title: const Text(
          "Forget Password",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Email address"),
            const SizedBox(height: 5),
            TextFormField(
              decoration: InputDecoration(
                hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontWeight: FontWeight.normal),
                hintText: "mynul@gmail.com",
                prefixIcon: const Icon(Icons.email_outlined),
                suffixIcon: const Icon(
                  Icons.info,
                  color: Colors.blueAccent,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
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
                "Send E-mail",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
