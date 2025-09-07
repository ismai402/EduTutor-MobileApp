// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, Admin!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AdminStatCard(
                  icon: Icons.people,
                  label: 'Students',
                  value: '350', // Replace with dynamic value
                  color: Colors.blue,
                ),
                AdminStatCard(
                  icon: Icons.school,
                  label: 'Teachers',
                  value: '25', // Replace with dynamic value
                  color: Colors.green,
                ),
                AdminStatCard(
                  icon: Icons.book,
                  label: 'Courses',
                  value: '12', // Replace with dynamic value
                  color: Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                AdminQuickAction(
                  icon: Icons.people,
                  label: 'Student Management',
                  onTap: () {},
                ),
                AdminQuickAction(
                  icon: Icons.school,
                  label: 'Teacher Management',
                  onTap: () {},
                ),
                AdminQuickAction(
                  icon: Icons.book,
                  label: 'Course Management',
                  onTap: () {},
                ),
                AdminQuickAction(
                  icon: Icons.payment,
                  label: 'Payment Management',
                  onTap: () {},
                ),
                AdminQuickAction(
                  icon: Icons.schedule,
                  label: 'Schedule Management',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              'Recent Activity',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: const Icon(Icons.person_add),
                title: const Text('Added new student'),
                subtitle: const Text('Today, 9:00 AM'),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.school),
                title: const Text('Approved teacher registration'),
                subtitle: const Text('Yesterday, 2:00 PM'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Admin Stat Card Widget
class AdminStatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const AdminStatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        width: 100,
        height: 110,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 10),
            Text(value,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

// Admin Quick Action Widget
class AdminQuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const AdminQuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 90,
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Colors.blue),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
