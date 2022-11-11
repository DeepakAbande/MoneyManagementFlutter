import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  User({required this.uid});
  CollectionReference income = FirebaseFirestore.instance.collection('users');
  Future addtoincme(int amount, String date, String category, String desc,
      bool isincome) async {
    await income.add({
      'amount': amount,
      'category': category,
      'desc': desc,
      'isincome': isincome,
      'date': DateTime.now()
    });
  }
}
