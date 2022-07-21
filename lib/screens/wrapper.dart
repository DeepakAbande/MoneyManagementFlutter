import 'package:flutter/material.dart';
import 'package:moneymanager/models/user.dart';
import 'package:moneymanager/screens/auth/auth.dart';
import 'package:moneymanager/screens/home/home.dart';
import 'package:provider/provider.dart';
class wrapper extends StatelessWidget {
  const wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<user1?>(context);
    if (user == null) {
      return authenticate();
    } else {
      String uid = user.uid;
      return Homescreen(uid: uid,);
    }
  }
}
