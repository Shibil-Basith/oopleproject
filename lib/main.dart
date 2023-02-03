import 'package:flutter/material.dart';
import 'package:oopleproject/components/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  //final prefs = await SharedPreferences.getInstance();
  //final skipOnBoarding = prefs.getBool("skipOnBoarding") ?? false;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(home: SplashScreen(), debugShowCheckedModeBanner: false));

}


