import 'package:cloud_firestore/cloud_firestore.dart';

class GoalRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  fetchData(String email) async {

    firestore.collection('Users').doc(email).collection('goal').doc(email).get();
  }
}