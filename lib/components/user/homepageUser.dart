import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oopleproject/backend/datamodels/venuedatamodel.dart';
import 'package:oopleproject/backend/userModel/user.dart';
import 'package:oopleproject/components/user/searchScreen.dart';
import 'package:oopleproject/components/user/searchoption.dart';
import 'package:oopleproject/components/user/venueDetails.dart';
import 'package:oopleproject/sharedPreferences.dart';
import 'package:oopleproject/theme.dart';
import 'package:oopleproject/backend/venueList.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../importedTheme.dart';
import 'package:oopleproject/backend/userModel/globals.dart' as globals;


class homepageUser extends StatefulWidget {
  const homepageUser({Key? key}) : super(key: key);

  @override
  State<homepageUser> createState() => _homepageUserState();
}

class _homepageUserState extends State<homepageUser> {




  User _currentUser = globals.currentUserInfo;
  int footballVenuesLength = 0, cricketVenuesLength = 0, basketballVenuesLength = 0, tennisVenuesLength = 0, volleyballVenuesLength = 0, hockeyVenuesLength = 0;





  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      addVenue('Lusail Stadium', 'Doha, Qatar', 'https://images.cnbctv18.com/wp-content/uploads/2022/11/Lusail-Stadium-Qatar-1-1019x573.jpg', '10000', 'football', true, true, true, true, true, 1);
      addVenue('Dubai international cricket Stadium', 'Dubai, UAE', 'https://resources.pulse.icc-cricket.com/ICC/photo/2021/09/06/ef4fba29-e51b-4797-96b7-9f98e628ee34/GettyImages-137061267.jpg', '2500', 'cricket',  true, true, false, true, false, 2);
      addVenue('Football stadium', 'Doha, Qatar', 'https://images.cnbctv18.com/wp-content/uploads/2022/11/Lusail-Stadium-Qatar-1-1019x573.jpg', '10000', 'football', false, true, true, true, true, 3);


      if(globals.currentUserInfo.user_name == '')
        refresh();
      for(var i=0; i<venueList.length; i++){
        var category = venueList[i].venueCategory;
        switch(category){
          case 'football': footballVenuesLength++;
                            break;

          case 'cricket': cricketVenuesLength++;
                            break;

          case 'basketball': basketballVenuesLength++;
                            break;

          case 'tennis': tennisVenuesLength++;
                            break;

          case 'volleyball': volleyballVenuesLength++;
                            break;

          case 'hockey': hockeyVenuesLength++;
                            break;

        }

      }
    });
  }


  //String username = "username not available";





  void refresh() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      //SharedPreferences prefs = await SharedPreferences.getInstance();
      //username = prefs.getString('user_name')??"usernamefailed";
      //print("username is " + username.toString());
      final rawJson = prefs.getString('user_details') ?? '';
      Map<String, dynamic> map = jsonDecode(rawJson);
      //String _user_name = map['user_name'];
      //globals.currentUserDetails.add(User(map['user_name'], map['email'], map['phone'], map['age'] ));
      //final currentUser = User(map['user_name'], map['email'], map['phone'], map['age'] );
      //_currentUser = currentUser.user_name;

      //log(currentUser.user_name);

      globals.currentUserInfo.user_name = map['user_name'];
      globals.currentUserInfo.email = map['email'];
      globals.currentUserInfo.phone = map['phone'];
      globals.currentUserInfo.password = map['password'];
    });


  }



  String sportSelected = 'football';



  @override
  Widget build(BuildContext context) {
    List<Widget> getFootballVenues() {
      List<Widget> FootballCard = [];
      for (int i=0; i<venueList.length; i++) {
        if(venueList[i].venueCategory=='football') {
          FootballCard.add(
            Column(
              key: ValueKey(i),
              children: [
                const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                Material(
                  shadowColor: primaryColor500.withOpacity(0.1),
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: InkWell(
                    highlightColor: primaryColor500.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    splashColor: primaryColor500.withOpacity(0.5),
                    onTap: () {
                      setState(() {
                        //venueList.removeAt(i);
                        //print('footballcard $i deleted');
                        print(venueList[i].venueName+ " is at "+ i.toString());
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>venueDetails(venueList[i].venueId)));
                      });
                    },
                    child: Container(
                      //padding: EdgeInsets.all(10),
                      child: Column(
                          children: [
                            Container(
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                  child: CachedNetworkImage(

                                    imageUrl: venueList[i].venueImage,
                                    height: 200,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      height: 200,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(scale: 2, image: AssetImage('assets/images/imageloading.gif'),fit: BoxFit.fill, opacity: 0.6),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                      ),
                                    ),
                                  ),),
                            ),

                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                              height: 80,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        (venueList.length > 0) ? venueList[i]
                                            .venueName : '',
                                        maxLines: 2,
                                        style: subTitleTextStyle,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  const Padding(padding: EdgeInsets.symmetric(
                                      vertical: 3)),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined,
                                        size: 20,
                                        color: primaryColor500,),
                                      Text(
                                        (venueList.length > 0) ? venueList[i]
                                            .venueLocation : '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: addressTextStyle,
                                        ),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            )
        );
        }
      }
      return FootballCard;
    }

    List<Widget> getCricketVenues() {
      List<Widget> CricketCard = [];
      for (int i=0; i<venueList.length; i++) {
        if(venueList[i].venueCategory=='cricket') {
          CricketCard.add(
              Column(
                key: ValueKey(i),
                children: [
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Material(
                    shadowColor: primaryColor500.withOpacity(0.1),
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: InkWell(
                      highlightColor: primaryColor500.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      splashColor: primaryColor500.withOpacity(0.5),
                      onTap: () {
                        setState(() {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>venueDetails(venueList[i].venueId)));
                        });
                      },
                      child: Container(
                        //padding: EdgeInsets.all(10),
                        child: Column(
                            children: [
                              Container(
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    child: CachedNetworkImage(

                                      imageUrl: venueList[i].venueImage,
                                      height: 200,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        height: 200,
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(scale: 2, image: AssetImage('assets/images/imageloading.gif'),fit: BoxFit.fill, opacity: 0.6),
                                          //color: Colors.black,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20)),
                                        ),
                                      ),
                                    ),),
                              ),

                              Container(
                                padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                                height: 80,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          (venueList.length > 0) ? venueList[i].venueName : '',
                                          maxLines: 2,
                                          style: subTitleTextStyle,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    const Padding(padding: EdgeInsets.symmetric(
                                        vertical: 3)),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on_outlined,
                                          color: primaryColor500,
                                          size: 20,
                                        ),
                                        Text(
                                          (venueList.length > 0) ? venueList[i].venueLocation: '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: addressTextStyle,),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ],
              )
          );
        }
      }
      return CricketCard;
    }


    List<Widget> getBasketballVenues() {
      List<Widget> BasketballCard = [];
      for (int i=0; i<venueList.length; i++) {
        if(venueList[i].venueCategory=='basketball') {
          BasketballCard.add(
              Column(
                key: ValueKey(i),
                children: [
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Material(
                    shadowColor: primaryColor500.withOpacity(0.1),
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: InkWell(
                      highlightColor: primaryColor500.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      splashColor: primaryColor500.withOpacity(0.5),
                      onTap: () {
                        setState(() {
                          //venueList.removeAt(i);
                          //print('footballcard $i deleted');
                          print(venueList[i].venueName+ " is at "+ i.toString());
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>venueDetails(venueList[i].venueId)));
                        });
                      },
                      child: Container(
                        //padding: EdgeInsets.all(10),
                        child: Column(
                            children: [
                              Container(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                  child: CachedNetworkImage(

                                    imageUrl: venueList[i].venueImage,
                                    height: 200,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      height: 200,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(scale: 2, image: AssetImage('assets/images/imageloading.gif'),fit: BoxFit.fill, opacity: 0.6),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                      ),
                                    ),
                                  ),),
                              ),

                              Container(
                                padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                                height: 80,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          (venueList.length > 0) ? venueList[i]
                                              .venueName : '',
                                          maxLines: 2,
                                          style: subTitleTextStyle,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    const Padding(padding: EdgeInsets.symmetric(
                                        vertical: 3)),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on_outlined,
                                          size: 20,
                                          color: primaryColor500,),
                                        Text(
                                          (venueList.length > 0) ? venueList[i]
                                              .venueLocation : '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: addressTextStyle,
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ],
              )
          );
        }
      }
      return BasketballCard;
    }



    return WillPopScope(
      onWillPop: () async=> false,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(3),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: SafeArea(
                        // SEARCH Icon
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 55,
                                  height: 55,
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
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Welcome back,",
                                      style: descTextStyle,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      _currentUser.user_name,
                                      style: subTitleTextStyle,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: primaryColor500,
                                  borderRadius: BorderRadius.circular(borderRadiusSize)),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    addVenue('Lusail Stadium', 'Doha, Qatar', 'https://images.cnbctv18.com/wp-content/uploads/2022/11/Lusail-Stadium-Qatar-1-1019x573.jpg', '10000', 'football', true, true, true, true, true, 1);
                                    addVenue('Dubai international cricket Stadium', 'Dubai, UAE', 'https://resources.pulse.icc-cricket.com/ICC/photo/2021/09/06/ef4fba29-e51b-4797-96b7-9f98e628ee34/GettyImages-137061267.jpg', '2500', 'cricket',  true, true, false, true, false, 2);
                                    addVenue('Football stadium', 'Doha, Qatar', 'https://images.cnbctv18.com/wp-content/uploads/2022/11/Lusail-Stadium-Qatar-1-1019x573.jpg', '10000', 'football', false, true, true, true, true, 3);

                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
                                  });
                                },
                                icon: const Icon(Icons.search, color: colorWhite),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                    Column(
                      children: [
                        Container(
                          padding:
                          const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                          child: Align(
                            alignment: Alignment(-1, 0),
                            child: Text(
                              "Let's Have Fun and \nBe Healty!",
                              style: greetingTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,

                      child: Row(

                        children: [
                          const SizedBox(width: 6,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
                        child: Material(
                          color: sportSelected == 'football'?lightBlue300.withOpacity(0.6):colorWhite,
                          shadowColor: primaryColor500.withOpacity(0.1),
                          elevation: 10,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          child: InkWell(
                            highlightColor: primaryColor500.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            splashColor: primaryColor500.withOpacity(0.5),
                            onTap: () {
                              setState(() {
                                sportSelected = 'football';
                                print("$sportSelected selected");
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: primaryColor100,
                                      child: Icon(Icons.sports_soccer_rounded),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    "Football",
                                    style: descTextStyle,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                          const SizedBox(width: 6,),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
                            child: Material(
                              color: sportSelected == 'cricket'?lightBlue300.withOpacity(0.6):colorWhite,
                              shadowColor: primaryColor500.withOpacity(0.1),
                              elevation: 10,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              child: InkWell(
                                highlightColor: primaryColor500.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                                splashColor: primaryColor500.withOpacity(0.5),
                                onTap: () {
                                  setState(() {
                                    sportSelected = 'cricket';
                                    print("$sportSelected selected");
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundColor: primaryColor100,
                                          child: Icon(Icons.sports_cricket_rounded),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        "Cricket",
                                        style: descTextStyle,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),


                          const SizedBox(width: 6,),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
                            child: Material(
                              color: sportSelected == 'basketball'?lightBlue300.withOpacity(0.6):colorWhite,
                              shadowColor: primaryColor500.withOpacity(0.1),
                              elevation: 10,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              child: InkWell(
                                highlightColor: primaryColor500.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                                splashColor: primaryColor500.withOpacity(0.5),
                                onTap: () {
                                  setState(() {
                                    sportSelected = 'basketball';
                                    print("$sportSelected selected");
                                    print("football list length: $footballVenuesLength" );
                                    print("basketball list length: $basketballVenuesLength" );
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundColor: primaryColor100,
                                          child: Icon(Icons.sports_basketball_rounded),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        "Basketball",
                                        style: descTextStyle,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),


                          const SizedBox(width: 6,),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
                            child: Material(
                              color: sportSelected == 'tennis'?lightBlue300.withOpacity(0.6):colorWhite,
                              shadowColor: primaryColor500.withOpacity(0.1),
                              elevation: 10,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              child: InkWell(
                                highlightColor: primaryColor500.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                                splashColor: primaryColor500.withOpacity(0.5),
                                onTap: () {
                                  setState(() {
                                    sportSelected = 'tennis';
                                    print("$sportSelected selected");
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundColor: primaryColor100,
                                          child: Icon(Icons.sports_tennis_rounded),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        "Tennis",
                                        style: descTextStyle,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),


                          const SizedBox(width: 6,),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
                            child: Material(
                              color: sportSelected == 'volleyball'?lightBlue300.withOpacity(0.6):colorWhite,
                              shadowColor: primaryColor500.withOpacity(0.1),
                              elevation: 10,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              child: InkWell(
                                highlightColor: primaryColor500.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                                splashColor: primaryColor500.withOpacity(0.5),
                                onTap: () {
                                  setState(() {
                                    sportSelected = 'volleyball';
                                    print("$sportSelected selected");
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundColor: primaryColor100,
                                          child: Icon(Icons.sports_volleyball_rounded),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        "Volleyball",
                                        style: descTextStyle,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),


                          const SizedBox(width: 6,),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
                            child: Material(
                              color: sportSelected == 'hockey'?lightBlue300.withOpacity(0.6):colorWhite,
                              shadowColor: primaryColor500.withOpacity(0.1),
                              elevation: 10,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              child: InkWell(
                                highlightColor: primaryColor500.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                                splashColor: primaryColor500.withOpacity(0.5),
                                onTap: () {
                                  setState(() {
                                    sportSelected = 'hockey';
                                    print("$sportSelected selected");
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundColor: primaryColor100,
                                          child: Icon(Icons.sports_hockey_rounded),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        "Hockey",
                                        style: descTextStyle,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6,),
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                  ],

                ),
              ),

              //for(var i=0;i<venueList.length;i++)


              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child:

                    Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment(-0.9, 0),
                            child: Text(sportSelected[0].toUpperCase()+sportSelected.substring(1)+" Venues", style: subTitleTextStyle,)),




                        if(sportSelected =='football')
                          if(footballVenuesLength>0)
                          Column(
                            //key: ValueKey(i),
                            children:
                              getFootballVenues(),
                        )
                        else noMatchDataView(),

                        if(sportSelected =='cricket')
                          if(cricketVenuesLength>0)
                            Column(
                              //key: ValueKey(i),
                              children:
                              getCricketVenues(),
                            )
                            else noMatchDataView(),
                          

                        if(sportSelected =='basketball')
                          if(basketballVenuesLength>0)
                            Column(
                              //key: ValueKey(i),
                              //children:
                              //getBasketballVenues(),
                            )
                        else
                          noMatchDataView(),

                        if(sportSelected =='tennis')
                          if(tennisVenuesLength>0)
                            Column(
                              //key: ValueKey(i),
                              //children:
                              //getBasketballVenues(),
                            )
                          else
                            noMatchDataView(),

                        if(sportSelected =='volleyball')
                          if(volleyballVenuesLength>0)
                            Column(
                              //key: ValueKey(i),
                              //children:
                              //getBasketballVenues(),
                            )
                          else
                            noMatchDataView(),


                        if(sportSelected =='hockey')
                          if(hockeyVenuesLength>0)
                            Column(
                              //key: ValueKey(i),
                              //children:
                              //getBasketballVenues(),
                            )
                          else
                            noMatchDataView(),
                          
                          



                      ],
                    ),
                ),
              ),
              ),
              /*if(sportSelected=='cricket') Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                        children: getCricketVenues(),
                    ),
                  ),
                ),
              ),*/



            ],
          ),),
      ),
    );
  }


  Widget noMatchDataView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 60),
      child: Column(
        children: [
          Image.asset(
            "assets/images/no_match_data_illustration.png",
            width: 200,
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            "No Venue Found.",
            style: titleTextStyle.copyWith(color: darkBlue300),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            "Sorry, No $sportSelected venues registered yet.",
            style: descTextStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
