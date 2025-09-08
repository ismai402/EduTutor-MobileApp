import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDataService {
  Future<List<Map<String, dynamic>>> getAllStudents() async {
    final query = await _firestore.collection('Students').get();
    return query.docs.map((doc) {
      final data = doc.data();
      return {
        'name': data['name'] ?? '',
        'email': data['email'] ?? '',
        'status': data['status'] ?? 'Active',
        'avatar': data['avatar'] ?? 'https://i.pravatar.cc/150?u=${doc.id}',
      };
    }).toList();
  }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<int> getStudentCount() async {
    final query = await _firestore.collection('Students').get();
    return query.docs.length;
  }

  Future<int> getTeacherCount() async {
    final query = await _firestore
        .collection('Teachers')
        .where('role', isEqualTo: 'teacher')
        .get();
    return query.docs.length;
  }

  Future<int> getCourseCount() async {
    final query = await _firestore.collection('courses').get();
    return query.docs.length;
  }
}
