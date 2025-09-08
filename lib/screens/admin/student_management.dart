// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';

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
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _StatCard(
                      label: 'Total',
                      value: students.length.toString(),
                      color: Colors.blueAccent),
                  const SizedBox(width: 12),
                  _StatCard(
                      label: 'Active',
                      value: students
                          .where((s) => s['status'] == 'Active')
                          .length
                          .toString(),
                      color: Colors.green),
                  const SizedBox(width: 12),
                  _StatCard(
                      label: 'Inactive',
                      value: students
                          .where((s) => s['status'] == 'Inactive')
                          .length
                          .toString(),
                      color: Colors.redAccent),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(student['avatar']!),
                        radius: 28,
                      ),
                      title: Text(student['name']!,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
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
                        // Show student details or actions
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(student['name']!),
                            content: Text(
                                'Email: ${student['email']}\nStatus: ${student['status']}'),
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
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _StatCard(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(value,
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 13, color: color)),
          ],
        ),
      ),
    );
  }
}
