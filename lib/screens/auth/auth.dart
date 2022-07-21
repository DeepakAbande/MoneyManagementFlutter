import 'package:flutter/material.dart';
import 'package:moneymanager/screens/auth/sign_in.dart';
import 'package:moneymanager/screens/auth/register.dart';
class authenticate extends StatefulWidget {
  const authenticate({Key? key}) : super(key: key);

  @override
  _authenticateState createState() => _authenticateState();
}

class _authenticateState extends State<authenticate> {
  bool showSignin = true;
  void toggleview(){
    setState(() {
      showSignin= !showSignin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showSignin){
      return SignIn(toggleview: toggleview);
    }else{
      return Register(toggleview: toggleview);
    }
  }
}
