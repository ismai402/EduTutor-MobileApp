// ignore_for_file: prefer_const_constructors, deprecated_member_use, sort_child_properties_last

import 'package:flutter/material.dart';
import '../../services/gemini_service.dart';

class StudentManagementScreen extends StatelessWidget {
  const StudentManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example student data
    final students = [
      {
        'name': 'Alice Johnson',
        'email': 'alice@email.com',
        'avatar': 'https://randomuser.me/api/portraits/women/1.jpg',
        'status': 'Active',
      },
      {
        'name': 'Bob Smith',
        'email': 'bob@email.com',
        'avatar': 'https://randomuser.me/api/portraits/men/2.jpg',
        'status': 'Active',
      },
      {
        'name': 'Cathy Lee',
        'email': 'cathy@email.com',
        'avatar': 'https://randomuser.me/api/portraits/women/3.jpg',
        'status': 'Inactive',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Management'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFe3f2fd), Color(0xFFbbdefb)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Manage Students',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.group, color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search students...',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            // ...rest of your widgets...
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(student['avatar']!),
                      ),
                      title: Text(student['name']!),
                      subtitle: Text(student['email']!),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: student['status'] == 'Active'
                              ? Colors.green[100]
                              : Colors.red[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          student['status']!,
                          style: TextStyle(
                            color: student['status'] == 'Active'
                                ? Colors.green
                                : Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(student['name']!),
                            content: Text(
                              'Email: ${student['email']}\nStatus: ${student['status']}',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.smart_toy),
        tooltip: 'Ask Gemini AI',
        onPressed: () async {
          final TextEditingController promptController =
              TextEditingController();
          String? aiResponse;
          await showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return AlertDialog(
                    title: Text('Ask Gemini AI'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: promptController,
                          decoration: InputDecoration(
                              hintText: 'Enter your question...'),
                        ),
                        SizedBox(height: 16),
                        if (aiResponse != null)
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              aiResponse!,
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Close'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            aiResponse = 'Loading...';
                          });
                          final gemini = GeminiService(
                              apiKey:
                                  'AIzaSyCPbd9y1ucsuMnRWVs3GFDg_67SGV3gFGs');
                          final response = await gemini
                              .generateContent(promptController.text);
                          setState(() {
                            aiResponse = response ?? 'No response from AI.';
                          });
                        },
                        child: Text('Ask'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
