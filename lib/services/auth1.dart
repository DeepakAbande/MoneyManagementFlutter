import 'package:firebase_auth/firebase_auth.dart';
//import 'package:moneymanager/models/db.dart';
import 'package:moneymanager/models/user.dart';
import 'package:moneymanager/screens/home/add.dart';

class authservice{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  user1? _userfromfirebase(User? user)=> user != null ? user1(uid:user.uid) : null;
  Stream<user1?> get user{
    return _auth.authStateChanges().map(_userfromfirebase);
  }
  Future signInAnon() async {
    try{
      UserCredential result=await _auth.signInAnonymously();
      User? user = result.user;
      await add(uid:user!.uid);
      return _userfromfirebase(user);
    }catch(e){
    print(e.toString());
    return null;
    }
  }
  Future registerwithemail(String email ,String password) async{
   try{
     UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
     User? user = result.user;
     return _userfromfirebase(user);
   }catch(e){
     print(e.toString());
     return null;
   }
  }
  Future signinwithemail(String email ,String password) async{
    try{
      UserCredential result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userfromfirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  Future signout() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}
