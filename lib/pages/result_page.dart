import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: BoxDecoration(
              color: const Color(0xffA2ACE0).withOpacity(0.13),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Result",
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xff212329),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Semester:',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff6677CC)),
                            ),
                            Text(
                              ' 251 (Spring 2025)',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff3D3D3D)),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Student:',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff6677CC)),
                            ),
                            Text(
                              ' Tasnova Hasan',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff3D3D3D)),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Student Id:',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff6677CC)),
                            ),
                            Text(
                              '220239022',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff3D3D3D)),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Adviser:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Color(0xff6677CC)),
                        ),
                        Divider(),
                        SizedBox(height:4 ),
                        Text(
                          'CGPA : 3.86',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Total Credit Hours Completed: 104.0',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          'Number of courses completed before this semester: 38',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          'Number of courses completed in this semester: 10',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          'Total number of courses completed: 48',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Semester Wise GPA',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Color(0xff6677CC)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Table(
                    border: TableBorder.all(color: Colors.grey.withOpacity(0.3)),
                    columnWidths: const {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(3),
                      2: FlexColumnWidth(2),
                      3: FlexColumnWidth(2),
                    },
                    
                    children: [
                      _buildTableRow(['Semester', 'Credit Hours\nCompleted', 'GPA', 'CGPA'], isHeader: true),
                      _buildTableRow(['233', '20.0', '3.640', '3.640']),
                      _buildTableRow(['231', '21.0', '3.770', '3.710']),
                      _buildTableRow(['223', '22.0', '3.860', '3.780']),
                      _buildTableRow(['241', '19.0', '4.000', '3.820']),
                      _buildTableRow(['243', '20.0', '4.000', '3.860']),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Result of Completed Courses',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Color(0xff6677CC)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Table(
                    border: TableBorder.all(color: Colors.grey.withOpacity(0.3)),
                    columnWidths: const {
                      0: FlexColumnWidth(1.5),
                      1: FlexColumnWidth(2),
                      2: FlexColumnWidth(4),
                      3: FlexColumnWidth(1.5),
                      4: FlexColumnWidth(1.5),
                    },
                    children: [
                      _buildTableRow(['Semester', 'Course ID', 'Course Title', 'Credit', 'Result'], isHeader: true),
                      _buildTableRow(['223', 'CSE 1101', 'Computer Fundamentals and Applications', '3.0', 'A']),
                      _buildTableRow(['223', 'CSE 1103', 'Structured Programming Language', '3.0', 'A']),
                      _buildTableRow(['223', 'PHY 1101', 'Physics-I', '3.0', 'A']),
                      _buildTableRow(['223', 'ENG 1201', 'English Language Course', '2.0', 'A-']),
                      _buildTableRow(['223', 'CSE 1102', 'Principle of Learning and Language', '2.0', 'A']),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  Center(
                    child: SizedBox(
                                  height: 50,
                                  width: 287,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6677CC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                                    ),
                                    child: const Text(
                    'Download',
                    style: TextStyle(fontSize: 20, color: Color(0xffFFFFFF)),
                                    ),
                                  ),
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
}

TableRow _buildTableRow(List<String> cells, {bool isHeader = false}) {
  return TableRow(
    decoration: BoxDecoration(color: isHeader ? const Color(0xff6677CC): null),
    children: cells.map((cell) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          cell,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            color: isHeader?   Colors.white:Colors.black,
            fontSize: 12
          ),
        ),
      );
    }).toList(),
  );
}
