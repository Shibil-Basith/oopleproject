import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oopleproject/components/user/bottomNavigationbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../onboarding_screen.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 6));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //Navigator.of(context).pushReplacementNamed('/home');
        _checkLoginStatus();

      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/oople.png', height: 250, width: 250,),
              Image.asset('assets/images/loading.gif', height: 30, width: 30,),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('login');
    bool? onBoardSkip = prefs.getBool('onBoardSkip')??false;
    if (isLoggedIn!=null && isLoggedIn) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>bottomNavigationbar()));
    }
    else if(onBoardSkip!=null && onBoardSkip){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>login()));
    }

    else if(!onBoardSkip){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnboardingScreen()));
    }
  }
}
