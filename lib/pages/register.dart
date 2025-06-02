import 'package:bgcsphere/Database/auth_services.dart';

import 'package:bgcsphere/pages/main_page.dart';

import 'package:flutter/material.dart';

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

  final AuthService _authService = AuthService();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _registerUser() async {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        idController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        divisionController.text.trim().isEmpty ||
        districtController.text.trim().isEmpty ||
        tanaController.text.trim().isEmpty ||
        unionController.text.trim().isEmpty ||
        genderController.text.trim().isEmpty ||
        dobController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    if (_selectedBloodGroup == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select your blood group")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String? result = await _authService.signUp(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        internalId: idController.text.trim(),
        phone: phoneController.text.trim(),
        bloodGroup: _selectedBloodGroup!,
        division: divisionController.text.trim(),
        district: districtController.text.trim(),
        tana: tanaController.text.trim(),
        union: unionController.text.trim(),
        gender: genderController.text.trim(),
        dob: dobController.text.trim(),
      );

      if (result == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User registered successfully!")),
        );
        _clearFields();

        // ✅ Navigate to MainPage after successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration failed: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _clearFields() {
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
        _buildLabelAndField("Your Name", Icons.person_outlined,
            "Your Full Name", nameController),
        _buildLabelAndField("Email address", Icons.email_outlined,
            "bgc@sphere.com", emailController),
        _buildLabelAndField("Password", Icons.lock_outline,
            "Enter your password", passwordController,
            obscure: true),
        _buildLabelAndField(
            "Internal ID", Icons.roller_shades, "2402390****", idController),
        _buildLabelAndField("Phone Number", Icons.contact_emergency,
            "019********", phoneController),
        _buildDropdown("Blood Group"),
        _buildLabelAndField(
            "Gender", Icons.person, "Male / Female / Other", genderController),
        _buildDateField(),
        _buildLabelAndField(
            "Division", Icons.add, "Enter your Division", divisionController),
        _buildLabelAndField(
            "District", Icons.add, "Enter your District", districtController),
        _buildLabelAndField(
            "Tana", Icons.add, "Enter your Tana", tanaController),
        _buildLabelAndField(
            "Union", Icons.add, "Enter your Union", unionController),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff6677CC),
            minimumSize: const Size(double.infinity, 50),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          onPressed: _isLoading ? null : _registerUser,
          child: _isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text("Register",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildLabelAndField(String label, IconData icon, String hint,
      TextEditingController controller,
      {bool obscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
            hintText: hint,
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDropdown(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
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
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }
}
