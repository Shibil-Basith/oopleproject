import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oopleproject/components/user/homepageUser.dart';
import 'package:oopleproject/components/user/settingsuser.dart';
import 'package:oopleproject/components/user/transactions.dart';
import 'package:oopleproject/widgets/circularLoader.dart';
import '../../importedTheme.dart';



class bottomNavigationbar extends StatefulWidget {
  const bottomNavigationbar({Key? key}) : super(key: key);

  @override
  State<bottomNavigationbar> createState() => _bottomNavigationbarState();
}

class _bottomNavigationbarState extends State<bottomNavigationbar> {


  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);





  Future<bool> _onBackPressed() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        title: const Text('Exit the App'),
        content: const Text('Do you want to exit the application?'),
        actions: <Widget>[
          // const SizedBox(height: 16),
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {


                showDialog(context: context, builder: (context){
                  return DottedCircularProgressDialog();
                });


              });
              Timer(Duration(seconds: 6), () { SystemChannels.platform.invokeMethod('SystemNavigator.pop');});
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }





  
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _currentIndex = currentIndex;
    });
    setState(() {
      _currentIndex = currentIndex;
    });
  }



  int _currentIndex = 0;

  final _pages = [
    const homepageUser(),
    const transactions(),
    const settingsuser(),
  ];
  final iconList = <IconData>[
    Icons.home_rounded,
    Icons.book_rounded,
    Icons.settings,
  ];

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async => await _onBackPressed(),
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: backgroundColor,
              statusBarIconBrightness: Brightness.dark),
        ),
        backgroundColor: backgroundColor,
        body: _pages[_currentIndex],
    bottomNavigationBar: CurvedNavigationBar(
      index: _currentIndex,
      height: 60,
      items: [
        Row(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home_rounded, color: _currentIndex==0?primaryColor500:primaryColor300, ),
            if(_currentIndex!=0) Text('Home', style: bottomNavTextStyle.copyWith(color: primaryColor300),),

          ],
        ),
        Row(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.book_rounded, color: _currentIndex==1?primaryColor500:primaryColor300, ),
            if(_currentIndex!=1) Text('Transactions', style: bottomNavTextStyle.copyWith(color: primaryColor300),),

          ],
        ),
        Row(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.settings, color: _currentIndex==2?primaryColor500:primaryColor300, ),
            if(_currentIndex!=2) Text('Settings', style: bottomNavTextStyle.copyWith(color: primaryColor300),),

          ],
        ),
        //BottomNavigationBarItem(icon: Icon(Icons.money_rounded,),label: 'Transaction'),
        //BottomNavigationBarItem(icon: Icon(Icons.settings,),label: 'Settings'),
      ],

      color: Colors.white,
      buttonBackgroundColor: Colors.white,
      backgroundColor: const Color(0xffF5F9FF).withOpacity(0),
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 1000),
      letIndexChange: (index) => true,

      //currentIndex: _currentIndex,
      onTap: (newIndex){

        setState(() {

          _currentIndex = newIndex;

        });

      },

    ),
      ));
  }
}
