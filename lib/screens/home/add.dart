import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneymanager/shared/loading.dart';

import 'home.dart';
class add extends StatefulWidget {
  final String uid;
  add({required this.uid});
  @override
  addState createState() => addState(uid: this.uid);
}

class addState extends State<add> {
  bool isincome= true;
  bool isexpense= false;
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final _formkey = GlobalKey<FormState>();
  String category='';
  int amount=0;
  String date='';
  String desc='';
  bool loading= false;
  final String uid;
  addState({required this.uid});
  @override
  Widget build(BuildContext context) {
    CollectionReference income = FirebaseFirestore.instance.collection('users').doc(uid).collection('income');
    Future addtoincme(int amount,String date,String category,String desc,bool isincome) async{
      await income.add({'amount': amount,
        'category': category,
        'desc': desc,
        'isincome':isincome,
        'date': DateTime.now()
      });
    }
    return loading ? Loading():Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body:ListView(
          children: [
        Row(
          children: [
            Expanded(child:
            FlatButton(
              color: Colors.white,
              onPressed: () {
                setState(() {
                  isincome = true;
                  isexpense = false;
                });
              },
              child: Text('Income',textAlign:TextAlign.center,textScaleFactor: 1.3,),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: isincome ? Colors.blue : Colors.transparent, width: 1),
              ),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            ),


             ),
            Expanded(child:
            FlatButton(
              color: Colors.white,
              onPressed: () {
                setState(() {
                  isexpense = true;
                  isincome = false;
                });
              },
              child: Text('Expense',textAlign:TextAlign.center,textScaleFactor: 1.3,),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: isexpense ? Colors.redAccent : Colors.transparent, width: 1),
              ),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            ),
            ),
        ],
      ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formkey,
                child: Column(
              children: [
                TextFormField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                  icon: Icon(Icons.monetization_on),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                  keyboardType: TextInputType.number,
                    validator: (val) => val!.isEmpty ? 'enter an amount' : null,
                    onChanged: (val) {
                      setState(() {
                       amount = int.parse(val);
                      });
                    }
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Date',
                    icon: Icon(Icons.date_range_rounded),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.datetime,
                  controller: TextEditingController()..text= '$formattedDate',
                    validator: (val) => val!.isEmpty ? 'enter date' : null,
                    onChanged: (val) {
                      setState(() {
                        date = val;
                      });
                    }
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Category',
                    icon: Icon(Icons.category_rounded),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                    validator: (val) => val!.isEmpty ? 'enter category' : null,
                    onChanged: (val) {
                      setState(() {
                        category = val;
                      });
                    }
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                    icon: Icon(Icons.note),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                    validator: (val) => val!.isEmpty ? 'enter description' : null,
                    onChanged: (val) {
                      setState(() {
                        desc = val;
                      });
                    }
                )
              ],
            )),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                child: Text('Save'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 0.0,horizontal: 30.0)),
                ),
                onPressed: () {
                  if(_formkey.currentState!.validate()) {
                    addtoincme(amount,date,category,desc,isincome);
                       Navigator.pop(context);
                     }
                     //Navigator.push(context, MaterialPageRoute(builder: (context)=> home()));
                }
            ),
      ]
    ),
    );
  }
}

