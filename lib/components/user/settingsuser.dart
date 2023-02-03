import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oopleproject/backend/userModel/user.dart';
import 'package:oopleproject/backend/userModel/globals.dart' as globals;
import 'package:oopleproject/components/login.dart';
import 'package:oopleproject/widgets/logoutLoad.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../importedTheme.dart';


class settingsuser extends StatefulWidget {
  const settingsuser({Key? key}) : super(key: key);

  @override
  State<settingsuser> createState() => _settingsuserState();
}

class _settingsuserState extends State<settingsuser> {



  @override


  User _currentUser = globals.currentUserInfo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  /*void refresh() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      //SharedPreferences prefs = await SharedPreferences.getInstance();
      //username = prefs.getString('user_name')??"usernamefailed";
      //print("username is " + username.toString());
      final rawJson = prefs.getString('user_details') ?? '';
      Map<String, dynamic> map = jsonDecode(rawJson);
      //String _user_name = map['user_name'];

      //final currentUser = User(map['user_name'], map['email'], map['phone'], map['age'] );
      //_currentUser = currentUser.user_name;

      //log(currentUser.user_name);

      _currentUser.user_name = map['user_name'];
      _currentUser.email = map['email'];
      _currentUser.phone = map['phone'];
      _currentUser.password = map['password'];
    });


  }*/


  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async=> false,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: Tab(
          height: 40,
          child: Container(
            //padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: Text('Settings', style:  titleTextStyle,),
            ),
          ),
        ),
        body: SingleChildScrollView(
      child: Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Text(
            "Account",
            style: subTitleTextStyle.copyWith(color: primaryColor500),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 75,
                  height: 75,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/user_profile_example.png"),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _currentUser.user_name,
                      style: subTitleTextStyle,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      onTap: () {
                        _showSnackBar(context, "You are using the beta verion of the app");
                      },
                      child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: primaryColor100.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: primaryColor500)),
                          child: Text(
                            'Edit profile',
                            style: descTextStyle.copyWith(
                                color: primaryColor500),
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),

          InkWell(
            onTap: () {},//launch("https://github.com/mikirinkode"),
            splashColor: primaryColor100,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.all(12.0),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: colorWhite),
                    child: Icon(Icons.mail, color: darkBlue300, size: 30, ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: normalTextStyle,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          _currentUser.email,
                          style: descTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          InkWell(
            onTap: () {},//launch("https://github.com/mikirinkode"),
            splashColor: primaryColor100,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.all(12.0),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: colorWhite),
                    child: Icon(Icons.phone, color: darkBlue300, size: 30, ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Phone",
                          style: normalTextStyle,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          _currentUser.phone,
                          style: descTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          InkWell(
            onTap: () {


              _onLogoutPressed();
            },
            splashColor: primaryColor100,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.all(12.0),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: colorWhite),
                    child: Icon(Icons.logout_rounded, color: darkBlue300, size: 30, ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Log out",
                          style: normalTextStyle,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Tap to log out from your account",
                          style: descTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 32,
          ),
          Text(
            "Payment",
            style: subTitleTextStyle.copyWith(color: primaryColor500),
          ),
          InkWell(
            onTap: () {},
            splashColor: primaryColor100,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: colorWhite),
                    child: const Icon(
                      CupertinoIcons.creditcard_fill,
                      size: 24,
                      color: darkBlue300,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Payment method",
                          overflow: TextOverflow.visible,
                          style: normalTextStyle,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Not Set",
                          style: descTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Credits",
            style: subTitleTextStyle.copyWith(color: primaryColor500),
          ),
          InkWell(
            onTap: () {},//launch("https://github.com/mikirinkode"),
            splashColor: primaryColor100,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.all(12.0),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: colorWhite),
                    child: Image.asset(
                      "assets/icons/github.png",
                      color: darkBlue300,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Github",
                          style: normalTextStyle,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "github.com/oopleapp",
                          style: descTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          InkWell(
            onTap: () {},//launch("https://github.com/mikirinkode"),
            splashColor: primaryColor100,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.all(12.0),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: colorWhite),
                    child: FaIcon(FontAwesomeIcons.instagram, color: darkBlue300, size: 30, ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Instagram",
                          style: normalTextStyle,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "instagram.com/oopleapp",
                          style: descTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {},//launch("https://github.com/mikirinkode"),
            splashColor: primaryColor100,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.all(12.0),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: colorWhite),
                    child: Icon(CupertinoIcons.paperplane_fill, color: darkBlue300,),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Twitter",
                          style: normalTextStyle,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "twitter.com/oopleapp",
                          style: descTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            "About App",
            style: subTitleTextStyle.copyWith(color: primaryColor500),
          ),
          InkWell(
            onTap: () {
              _showSnackBar(context, "Newest Version");
            },
            splashColor: primaryColor100,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: colorWhite),
                    child: const Icon(
                      CupertinoIcons.info_circle_fill,
                      size: 24,
                      color: darkBlue300,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Oople - Sports Venue Booking App",
                          style: normalTextStyle,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Version 1.0.0",
                          style: descTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),


          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Created with ",
                style: normalTextStyle,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                "{code}",
                style: subTitleTextStyle.copyWith(color: primaryColor500),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                "and",
                style: normalTextStyle,
              ),
              const SizedBox(
                width: 4,
              ),
              const Icon(
                Icons.favorite_rounded,
                color: Colors.red,
              )
            ],
          ),
        ],
      ),
    ),
    ),
      ),
    );
  }


  void _showSnackBar(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(message),
      margin: const EdgeInsets.all(16),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      // margin: EdgeInsets.all(16),
    ));
  }


  Future<bool> _onLogoutPressed() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        title: const Text('Log our'),
        content: const Text('Do you want to log out?'),
        actions: <Widget>[
          // const SizedBox(height: 16),
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {

                //logout();

                showDialog(context: context, builder: (context){
                  return logoutLoader();
                });
                logout();




              });

            },
            child: const Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }


  void logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('login', false);
      Future.delayed(Duration(seconds: 5), () {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            login()), (Route<dynamic> route) => false);
      });
    });
  }






}
