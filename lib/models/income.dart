// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';

class transaction {
  transaction();
  transaction.fromMap(Map<String, dynamic> data) {
    int amount = data['amount'];
    String category = data['category'];
    String desc = data['desc'];
    Timestamp date = data['createdAt'];
  }

  /*Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': amount,
      'category': category,
      'subIngredients': desc,
      'createdAt': date,
    };
    }*/

}
