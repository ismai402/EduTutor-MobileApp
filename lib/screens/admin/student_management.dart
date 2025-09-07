import 'package:flutter/material.dart';

class StudentManagementScreen extends StatelessWidget {
  const StudentManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Management'),
      ),
      body: Center(
        child: Text(
          'Student Management Panel',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
