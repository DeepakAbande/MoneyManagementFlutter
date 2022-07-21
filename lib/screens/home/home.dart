import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneymanager/screens/home/add.dart';
import 'package:moneymanager/services/auth1.dart';
class Homescreen extends StatefulWidget {
  final String uid;
  Homescreen({required this.uid});
  @override
  HomescreenState createState() => HomescreenState(uid: this.uid);
}

class HomescreenState extends State<Homescreen> {
 final authservice _auth = authservice();
 int income=0;
 int expense=0;

 final String uid;
 HomescreenState({required this.uid});

 @override
  Widget build(BuildContext context) {
   int total=income - expense;
   DocumentReference doc_ref=FirebaseFirestore.instance.collection('users').doc(uid).collection('income').doc();
   final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').doc(uid).collection('income').orderBy('date',descending: true,).snapshots();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title:  Icon(Icons.home,color: Colors.white, size: 30,),

        elevation: 0.0,
        actions: [
          FlatButton.icon(
              icon: Icon(Icons.person,color: Colors.white,),
              label: Text('logout', style: TextStyle(color: Colors.white),),
              onPressed: () async {
                await _auth.signout();
              } )
        ],
      ),
      body:Column(
        children:[
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(child: Text('Income',textAlign:TextAlign.center,textScaleFactor: 1.3,),
              ),
              Expanded(child: Text('Expense',textAlign:TextAlign.center,textScaleFactor: 1.3,),
              ),
              Expanded(child: Text('Total',textAlign:TextAlign.center,textScaleFactor: 1.3,),)
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(child: Text('$income',textAlign:TextAlign.center,textScaleFactor: 1.3,),
              ),
              Expanded(child: Text('$expense',textAlign:TextAlign.center,textScaleFactor: 1.3,),
              ),
              Expanded(child: Text('$total',textAlign:TextAlign.center,textScaleFactor: 1.3,),)
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          StreamBuilder(
          stream:_usersStream,

          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return Expanded(
                child: ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  DateTime dt = (data['date'] as Timestamp).toDate();
                  String formatdate =DateFormat('MMMd').format(dt);
                  String year =DateFormat('yyyy').format(dt);
                  if(data['isincome']) {
                    income = income + data['amount'] as int;
                    return Card(
                        borderOnForeground: true,
                        shadowColor: Colors.deepPurpleAccent,
                        elevation: 2.0,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Text(
                                  '$formatdate', textAlign: TextAlign.justify,),
                                subtitle: Text(data['category']),
                                title: Text('Income'),
                                trailing: Text('${data['amount']}',style: TextStyle(color: Colors.deepPurple,fontSize: 18),),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('    '),
                                    Text('$year'),
                                    Text('        '),
                                    Text(data['desc']),
                                    Text('                                   '),
                                    IconButton(onPressed: (){}, icon:Icon(Icons.create,)),
                                    Text('        '),
                                    IconButton(onPressed: () async{
                                      DocumentSnapshot docSnap = await doc_ref.get();
                                      var doc_id2 = docSnap.reference.id;
                                      final collection = FirebaseFirestore.instance.collection('users').doc(uid).collection('income');
                                      collection.doc('$doc_id2').delete();
                                    }, icon:Icon(Icons.delete,color: Colors.red,))
                                  ]
                              )
                            ]
                        )
                    );
                  }
                  else{
                    expense = expense + data['amount'] as int;
                    return Card(
                      borderOnForeground: true,
                        shadowColor: Colors.red,
                        elevation: 2.0,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Text(
                                  '$formatdate', textAlign: TextAlign.justify,),
                                subtitle: Text(data['category']),
                                title: Text('Expense'),
                                trailing: Text('${data['amount']}',style: TextStyle(color: Colors.redAccent,fontSize: 18),),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('     '),
                                    Text('$year'),
                                    Text('        '),
                                    Text(data['desc']+'                                  '),
                                    IconButton(onPressed: (){}, icon:Icon(Icons.create,)),
                                    Text('        '),
                                    IconButton(onPressed: (){}, icon:Icon(Icons.delete,color: Colors.red,))
                                  ]
                              )
                            ]
                        )
                    );
                  }
                }).toList(),
                ),
              );
          },
        ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder:(context) => add(uid: this.uid)));
        },
        backgroundColor: Colors.teal,
        child: Icon(Icons.add,color: Colors.white,size: 30,),
        tooltip: 'Add ',
      ),

    );
  }
}
