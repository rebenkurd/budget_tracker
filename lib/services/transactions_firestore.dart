import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addTransaction(Map<String, dynamic> transactionData) async {
    await _firestore.collection('expenses').add(transactionData);
  }

  Future<void> updateTransaction(
    String id,
    Map<String, dynamic> transactionData,
  ) async {
    await _firestore.collection('expenses').doc(id).update(transactionData);
  }
}