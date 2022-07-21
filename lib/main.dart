import 'package:flutter/material.dart';
import 'package:moneymanager/models/user.dart';
import 'package:moneymanager/screens/auth/sign_in.dart';
import 'package:moneymanager/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:moneymanager/services/auth1.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<user1?>.value(
      value: authservice().user,
      initialData: null,
      child: MaterialApp(
        home: wrapper(),
      ),
    );
  }
}