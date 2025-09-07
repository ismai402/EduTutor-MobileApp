import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDataService {
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
