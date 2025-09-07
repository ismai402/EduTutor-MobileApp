import 'package:cloud_firestore/cloud_firestore.dart';

class StudentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getStudentsForTeacher(
      String teacherId) async {
    final query = await _firestore
        .collection('students')
        .where('teacherId', isEqualTo: teacherId)
        .get();
    return query.docs.map((doc) => doc.data()).toList();
  }
}
