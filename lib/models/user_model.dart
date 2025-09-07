import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { admin, teacher, student }

class UserModel {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String? department;
  final String? className;
  final String? gender;
  final UserRole role;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.department,
    this.className,
    this.gender,
    required this.role,
    required this.createdAt,
  });

  String get fullName => '$firstName $lastName';

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'department': department,
      'className': className,
      'gender': gender,
      'role': role.name,
      'createdAt': createdAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      department: map['department'],
      className: map['className'],
      gender: map['gender'],
      role: _roleFromString(map['role']),
      createdAt: map['createdAt'] is DateTime
          ? map['createdAt']
          : map['createdAt'] is Timestamp
              ? (map['createdAt'] as Timestamp).toDate()
              : DateTime.tryParse(map['createdAt']?.toString() ?? '') ??
                  DateTime.now(),
    );
  }

  static UserRole _roleFromString(dynamic role) {
    if (role is UserRole) return role;
    if (role is String) {
      switch (role.toLowerCase()) {
        case 'admin':
          return UserRole.admin;
        case 'teacher':
          return UserRole.teacher;
        case 'student':
          return UserRole.student;
      }
    }
    return UserRole.student;
  }
}
