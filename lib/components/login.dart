import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oopleproject/backend/ownerModel/owner.dart';
import 'package:oopleproject/backend/userModel/user.dart';
import 'package:oopleproject/components/user/bottomNavigationbar.dart';
import 'package:oopleproject/components/user/homepageUser.dart';
import 'package:oopleproject/theme.dart';
import 'dart:developer';
import 'package:oopleproject/backend/userModel/globals.dart' as globals;

import 'package:shared_preferences/shared_preferences.dart';

import '../sharedPreferences.dart';

 class login extends StatefulWidget {
   const login({Key? key}) : super(key: key);

   @override
   State<login> createState() => _loginState();
 }

 class _loginState extends State<login> {

   @override


   final db = FirebaseFirestore.instance;

   TextEditingController username = TextEditingController();
   TextEditingController password = TextEditingController();


   bool userpage = true;

   @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: SafeArea(child: Container(
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
             Text(
               userpage ? 'Log in to your account' : 'Log in to your business',
               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
             SizedBox(height: 20,),
             TextField(
               controller: username,
               decoration: InputDecoration(
                 hintText: userpage ? 'username' : 'Username',
               ),
             ),
             SizedBox(height: 10,),
             TextField(
               controller: password,
               decoration: InputDecoration(
                 hintText: userpage ? 'Password' : 'Password',
               ),
             ),
             Padding(padding: EdgeInsets.symmetric(vertical: 30)),
             ElevatedButton(onPressed: () {

               if(username.text.isNotEmpty && password.text.isNotEmpty){
                 if (userpage) {
                   userLogin();
                 }
                 else {
                   ownerLogin();
                 }

               }
               else{
                 Fluttertoast.showToast(
                     msg: "Fields must be filled",
                     toastLength: Toast.LENGTH_SHORT,
                     gravity: ToastGravity.BOTTOM,
                     timeInSecForIosWeb: 1,
                     backgroundColor: Colors.red,
                     textColor: Colors.white,
                     fontSize: 10.0

                 );
               }

               //SetCurrentIndex(0);
               //Navigator.push(context, MaterialPageRoute(builder: (context)=>bottomNavigationbar()));

             },
                 child: Text('Log in', style: TextStyle(
                     fontSize: 20, fontWeight: FontWeight.w300),))

           ],
         ),
       )),
     );
   }

   void userLogin() async {

     final prefs = await SharedPreferences.getInstance();

     final docRef = db.collection("users").doc(username.text.toString());
     docRef.get().then(
           (DocumentSnapshot doc) {
         final userfromDB = doc.data() as Map<String, dynamic>;

         User user = new User(userfromDB['user_name'], userfromDB['email'], userfromDB['phone'], userfromDB['password']);
         globals.currentUserInfo = user;
         //globals.currentUserDetails.add(user);
         log(userfromDB['email']);
         //user.user_name = userfromDB['user_name'];
         log(user.user_name);
         if(user.password == password.text.toString()){


           Map<String, dynamic> map = {
             'user_name': user.user_name,
             'email': user.email,
             'phone': user.phone,
             'password': user.password,
           };


           String rawJson = jsonEncode(map);



           prefs.setBool('login', true);
           prefs.setString('user_name', user.user_name);



           prefs.setString('user_details', rawJson);



           currentIndex = 0;
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>bottomNavigationbar()));
         }
         else{
           log("Incorrect Password");
           log(user.password.toString()+ " should be equal to " + password.text.toString());
           Fluttertoast.showToast(
               msg: "Incorrect password",
               toastLength: Toast.LENGTH_SHORT,
               gravity: ToastGravity.BOTTOM,
               timeInSecForIosWeb: 1,
               backgroundColor: Colors.red,
               textColor: Colors.white,
               fontSize: 10.0

           );
         }
       })
             .catchError((error){
       log("Error in getting data");
       Fluttertoast.showToast(
           msg: "User not registered",
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.BOTTOM,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 10.0

       );
     });

   }





   void ownerLogin() async{

     final prefs = await SharedPreferences.getInstance();

     final docRef = db.collection("owners").doc(username.text.toString());
     docRef.get().then(
             (DocumentSnapshot doc) {
           final ownerFromDB = doc.data() as Map<String, dynamic>;

           Owner owner = new Owner(ownerFromDB['user_name'], ownerFromDB['email'], ownerFromDB['phone'], ownerFromDB['password']);
           log(ownerFromDB['email']);
           //user.user_name = userfromDB['user_name'];
           log(owner.user_name);
           if(owner.password == password.text.toString()){


             prefs.setBool('login', true);



             currentIndex = 0;
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>bottomNavigationbar()));
           }
           else{
             log("Incorrect Password");
             log(owner.password.toString()+ " should be equal to " + password.text.toString());
           }
         })
         .catchError((error){
       log("Error in getting data");
       Fluttertoast.showToast(
           msg: "User not registered",
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.BOTTOM,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 10.0

       );
     });
   }



 }
