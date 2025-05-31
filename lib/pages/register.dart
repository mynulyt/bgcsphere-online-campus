import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController divisionController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController tanaController = TextEditingController();
  final TextEditingController unionController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  final List<String> _bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
  ];
  String? _selectedBloodGroup;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _registerUser() async {
    if (_selectedBloodGroup == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select your blood group")),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('users').add({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
        'internal_id': idController.text.trim(),
        'phone': phoneController.text.trim(),
        'blood_group': _selectedBloodGroup,
        'division': divisionController.text.trim(),
        'district': districtController.text.trim(),
        'tana': tanaController.text.trim(),
        'gender': genderController.text.trim(),
        'union': unionController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
        'dob': dobController.text.trim(), // 👈 Add this line
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User registered successfully!")),
      );

      // Clear fields
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      idController.clear();
      phoneController.clear();
      divisionController.clear();
      districtController.clear();
      tanaController.clear();
      unionController.clear();
      genderController.clear();
      dobController.clear();

      setState(() => _selectedBloodGroup = null);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child: Container(width: MediaQuery.of(context).size.width)),
              Expanded(child: Container(color: Colors.white)),
            ],
          ),
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
                            spreadRadius: 2),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        _buildRegisterForm(),
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

  Widget _buildRegisterForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Your Name"),
        const SizedBox(height: 5),
        _buildTextField(
            Icons.person_outlined, "Your Full Name", nameController),
        const SizedBox(height: 20),
        const Text("Email address"),
        const SizedBox(height: 5),
        _buildTextField(
            Icons.email_outlined, "bgc@sphere.com", emailController),
        const SizedBox(height: 20),
        const Text("Password"),
        const SizedBox(height: 5),
        _buildTextField(
            Icons.lock_outline, "Enter your password", passwordController,
            obscure: true),
        const SizedBox(height: 20),
        const Text("Internal ID"),
        const SizedBox(height: 5),
        _buildTextField(Icons.roller_shades, "2402390****", idController),
        const SizedBox(height: 20),
        const Text("Phone Number"),
        const SizedBox(height: 5),
        _buildTextField(
            Icons.contact_emergency, "019********", phoneController),
        const SizedBox(height: 20),
        const Text("Blood Group"),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          value: _selectedBloodGroup,
          hint: const Text("Select your Blood Group"),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.bloodtype),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          items: _bloodGroups.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() => _selectedBloodGroup = newValue);
          },
        ),
        const SizedBox(height: 20),
        const Text("Gender"),
        const SizedBox(height: 5),
        _buildTextField(
            Icons.person, "Male / Female / Other", genderController),
        const SizedBox(height: 20),
        const Text("Date of Birth"),
        const SizedBox(height: 5),
        TextFormField(
          controller: dobController,
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime(2000),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              String formattedDate =
                  "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
              setState(() {
                dobController.text = formattedDate;
              });
            }
          },
          decoration: InputDecoration(
            hintText: "Select your date of birth",
            prefixIcon: const Icon(Icons.calendar_today),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 20),
        const Text("Division"),
        const SizedBox(height: 5),
        _buildTextField(Icons.add, "Enter your Division", divisionController),
        const SizedBox(height: 20),
        const Text("District"),
        const SizedBox(height: 5),
        _buildTextField(
            Icons.add, "Enter your District...", districtController),
        const SizedBox(height: 20),
        const Text("Tana"),
        const SizedBox(height: 5),
        _buildTextField(Icons.add, "Enter your Tana...", tanaController),
        const SizedBox(height: 20),
        const Text("Union"),
        const SizedBox(height: 5),
        _buildTextField(Icons.add, "Enter your Union", unionController),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff6677CC),
            minimumSize: const Size(double.infinity, 50),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          onPressed: _registerUser,
          child: const Text("Register",
              style: TextStyle(color: Colors.white, fontSize: 20)),
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

  Widget _buildTextField(
      IconData icon, String hint, TextEditingController controller,
      {bool obscure = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
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
              blurRadius: 8),
        ],
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        onPressed: () {
          // TODO: Social login logic
        },
        icon: Image.asset(imagePath, height: 20),
        label: Text(text, style: const TextStyle(color: Colors.black)),
      ),
    );
  }
}
