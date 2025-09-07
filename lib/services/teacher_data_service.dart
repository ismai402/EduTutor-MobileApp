import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherDataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<int> getStudentCount(String teacherId) async {
    final query = await _firestore
        .collection('students')
        .where('teacherId', isEqualTo: teacherId)
        .get();
    return query.docs.length;
  }

  Future<int> getAssignmentCount(String teacherId) async {
    final query = await _firestore
        .collection('assignments')
        .where('teacherId', isEqualTo: teacherId)
        .get();
    return query.docs.length;
  }

  Future<double> getAttendanceRate(String teacherId) async {
    final query = await _firestore
        .collection('attendance')
        .where('teacherId', isEqualTo: teacherId)
        .get();
    if (query.docs.isEmpty) return 0.0;
    int present = 0;
    int total = 0;
    for (var doc in query.docs) {
      present += (doc['present'] as int? ?? 0);
      total += (doc['total'] as int? ?? 0);
    }
    if (total == 0) return 0.0;
    return (present / total) * 100;
  }
}
