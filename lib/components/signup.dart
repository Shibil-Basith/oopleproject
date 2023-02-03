import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:oopleproject/components/login.dart';
import 'package:oopleproject/components/test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';


class signup extends StatefulWidget {

  const signup({Key? key}) : super(key: key);


  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  @override


  void userSignup(){
    //if(userpage) // Create a new user with a first and last name
    final user = <String, dynamic>{
      "user_name": username.text.toString(),
      "email": email.text.toString(),
      "phone": phone.text.toString(),
      "password": password.text.toString(),
    };

// Add a new document with a generated ID
    db
        .collection("users")
        .doc(username.text.toString())
        .set(user).then((value){
      setState(() {
        print("data Successfully added to users collection");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>login()));
      });


    }).catchError((error){
      print("Error in adding data");
    });
    //.onError((e, _) => print("Error writing document: $e"));

  }

  void ownerSignup(){
    //if(userpage) // Create a new user with a first and last name
    final owner = <String, dynamic>{
      "user_name": username.text.toString(),
      "email": email.text.toString(),
      "phone": phone.text.toString(),
      "password": password.text.toString(),
    };

// Add a new document with a generated ID
    db
        .collection("owners")
        .doc(username.text.toString())
        .set(owner).then((value){
          setState(() {
            print("data Successfully added to owners collection");
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>login()));
          });


    }).catchError((error){
      print("Error in adding data");
    });
        //.onError((e, _) => print("Error writing document: $e"));

  }


  final db = FirebaseFirestore.instance;


  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool userpage = true;
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(child: Container(
            margin: EdgeInsets.all(30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(onPressed: () {
                        setState(() {
                          userpage = true;
                        });
                    }, child: Text('User')),
                    TextButton(onPressed: () {
                        setState(() {
                          userpage = false;
                        });
                    }, child: Text('Owner'))
                  ],
                ),
                SizedBox(height: 30,),
                Text(userpage?'Sign up to your account':'Register your business',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                TextField(
                  controller: username,
                  decoration: InputDecoration(
                    hintText: userpage?'Username':'username',
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: userpage?'Your email':'Business email',
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: phone,
                  decoration: InputDecoration(
                    hintText: userpage?'Phone':'Phone',
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: password,
                  decoration: InputDecoration(
                    hintText: userpage?'Password':'Password',
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: confirmPassword,
                  decoration: InputDecoration(
                    hintText: userpage?'Confirm password':'Confirm password',
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 30)),
                ElevatedButton(onPressed: () {
                  if(username.text.isNotEmpty && email.text.isNotEmpty && phone.text.isNotEmpty && password.text.isNotEmpty && confirmPassword.text.isNotEmpty){



                    if(password.text.toString() == confirmPassword.text.toString()){






                      final docRef = db.collection(userpage?"users":"owners").doc(username.text.toString());
                      docRef.get().then(
                              (DocumentSnapshot doc) {
                            final dataFromDB = doc.data() as Map<String, dynamic>;
                            log("user_name not available");
                            Fluttertoast.showToast(
                                msg: "User already exist",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 10.0

                            );


                          })
                          .catchError((error){

                            log("user_name not available");

                            if(userpage){
                              setState(() {
                                userSignup();
                              });
                            }
                            else{
                              setState(() {
                                ownerSignup();
                              });
                            }

                      });












                      /*if(userpage){
                        setState(() {
                          userSignup();
                        });

                      }
                      else{

                        setState(() {
                          ownerSignup();
                        });

                      }*/
                    }
                    else{
                      Fluttertoast.showToast(
                          msg: "password and confirm password must be same",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 10.0
                      );

                    }

                  }else{
                    Fluttertoast.showToast(
                        msg: "Fill all fields",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 10.0
                    );
                  }
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>test()));
                  }, child: Text('Sign up',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),))

                ],
              ),
          ),
          )),

    );
  }
}
