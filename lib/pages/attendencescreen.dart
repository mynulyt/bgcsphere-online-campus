import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String? selectedSubject;
  List<String> subjects = ["Math", "Science", "English"];

  String? selectedSemester;
  List<String> semesters = ["Semester 1", "Semester 2"];

  String? selectedSection;
  List<String> sections = ["A", "B", "C"];

  String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  Map<int, bool?> attendance = {};

  int get totalPresent => attendance.values.where((val) => val == true).length;
  int get totalAbsent => attendance.values.where((val) => val == false).length;

  void _submitAttendance() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Attendance Submitted Successfully!")),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        selectedDate = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Attendance Handling',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Semester, Date (Calendar), Section Dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: selectedSemester,
                  hint: const Text("Select Semester"),
                  items: semesters.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedSemester = newValue;
                    });
                  },
                ),
                DropdownButton<String>(
                  value: selectedSection,
                  hint: const Text("Select Section"),
                  items: sections.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedSection = newValue;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Date picker (using calendar)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Date: $selectedDate",
                  style:
                      const TextStyle(fontSize: 16, color: Colors.blueAccent),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Text("Select Date"),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Subject Dropdown and Mark Attendance Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: selectedSubject,
                  hint: const Text("Select Subject"),
                  items: subjects.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedSubject = newValue;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Mark Attendance"),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Present and Absent counters
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCounter("Present", totalPresent, Colors.green),
                _buildCounter("Absent", totalAbsent, Colors.red),
              ],
            ),
            const SizedBox(height: 20),

            // Student List with Attendance Buttons
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Text(
                          "S$index",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text("Student $index"),
                      subtitle: Text("ID:22023903$index"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.check,
                              color: attendance[index] == true
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                attendance[index] = true;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              color: attendance[index] == false
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                attendance[index] = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Submit Attendance Button
            ElevatedButton(
              onPressed: _submitAttendance,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Submit Attendance",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Counter widget for Present and Absent count
  Widget _buildCounter(String label, int count, Color color) {
    return Column(
      children: [
        Text(
          "$count",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
