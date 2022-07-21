import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/services/auth1.dart';
import 'package:moneymanager/shared/loading.dart';
class SignIn extends StatefulWidget {
  final Function() toggleview;
  SignIn({required this.toggleview} );
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final authservice _auth = authservice();
  final _formkey = GlobalKey<FormState>();
  String error = '';
  String email='';
  String password = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        backgroundColor: new Color.fromRGBO(50, 20, 100, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        //title: Text('Sign In To Money Manager'),
        actions: [
          FlatButton.icon(
              icon: Icon(Icons.person,color: Colors.white),
              label: Text('Register', style: TextStyle(color: Colors.white),),
              onPressed: () {
                widget.toggleview();
              } )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 20.0),
    child: new GestureDetector(
    onTap: () {
    FocusScope.of(context).requestFocus(new FocusNode());
    },
        child: SingleChildScrollView(
          child: Column(
            children: [
            Image.asset('assets/money_manager1.png',
            height: 200,),
              SizedBox(
                height: 20,
              ),
              Text(
                'Welcome to Money Manager!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
          Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    icon: new Icon(Icons.person,color: Colors.white),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      )
                  ),
                    validator: (val) => val!.isEmpty ? 'enter an email' : null,
                 onChanged: (val){
                  setState(() {
                    email=val;
                  });
               }
              ),
                SizedBox(height: 20),
                TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Password',
                        icon: new Icon(Icons.lock,color: Colors.white),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        )
                    ),
                    obscureText: true,
                    validator: (val) => val!.length<=6 ? 'enter a password 6+ characters long' : null,
                    onChanged: (val){
                      setState(() {
                     password=val;
                   });
             }
              ),
                SizedBox(height: 20.0),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: new Color.fromRGBO(220, 60, 104, 1),shadowColor: new Color.fromRGBO(137, 45, 255, 1) ),
                    child: Text(
                      'Sign in',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          loading= true;
                        });
                        dynamic result = await _auth.signinwithemail(
                            email, password);
                        if (result == null) {
                          setState(() {
                            loading= false;
                            error = 'user not registered';
                          });
                        }
                      }
                    }
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red,fontSize: 12.0),
                )
              ],
            ),
          ),
        ]
          )
      ),
      )
      )
    );
  }
}
