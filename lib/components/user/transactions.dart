import 'package:flutter/material.dart';
import 'package:oopleproject/backend/datamodels/ordermodel.dart';
import 'package:oopleproject/backend/orderList.dart';
import 'package:oopleproject/components/splashScreen.dart';
import 'package:oopleproject/components/user/orders.dart';
import 'package:oopleproject/components/user/settingsuser.dart';
import 'package:oopleproject/importedTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/notrasactionMessage.dart';


class transactions extends StatefulWidget {
  const transactions({Key? key}) : super(key: key);

  @override
  State<transactions> createState() => _transactionsState();
}

class _transactionsState extends State<transactions> {


  @override




  void initState()  {
    // TODO: implement initState
    super.initState();

    setState(() {
      Listorders = Listorders;
      int i = 0;
    });
  }



  PageController _pageController = PageController();
  int currentIndex = 0;
  bool haveOrders = true;
  bool haveHistory = true;



  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Color(0xffF5F9FF),
          body: Column(
              children:
              [
                SizedBox(height: 10,),
                Text('Transaction', style: titleTextStyle,),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: width/2,
                      height: 50,
                      decoration: BoxDecoration(
                        border: (currentIndex==0)?Border(bottom: BorderSide(color: Colors.blue,width: 2)):Border(bottom: BorderSide.none),
                      ),
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              _pageController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.linear);
                            });
                          }, child: Text('Orders', style: subTitleTextStyle,),),
                    ),
                    Container(
                      height: 50,
                      width: width/2,
                      decoration: BoxDecoration(
                        border: (currentIndex==1)?Border(bottom: BorderSide(color: Colors.blue,width: 2)):Border(bottom: BorderSide.none),
                      ),
                      child: TextButton(onPressed: () {
                        setState(() {
                          _pageController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.linear);
                        });
                      }, child: Text('History', style: subTitleTextStyle),),
                    ),
                  ],
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index){
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    children: [
                      Listorders.isNotEmpty
                          ?
                  ListView.builder(
                  padding: const EdgeInsets.all(8),
                    itemCount: Listorders.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                            Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      print('stadium selected');
                                    });
                                  },
                                  child: Container(
                                    //padding: EdgeInsets.all(10),
                                    child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                            height: 150,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(Listorders[i].venueName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),),
                                                  ],
                                                ),
                                                Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                                                Row(
                                                  children: [
                                                    Icon(Icons.location_on_outlined,color: Colors.redAccent.shade200,size: 15,),
                                                    Text(Listorders[i].venueLocation,style: TextStyle(color: Colors.black26,fontSize: 15),),

                                                  ],
                                                ),
                                                Padding(padding: EdgeInsets.symmetric(vertical: 3,)),
                                                Row(
                                                  children: [
                                                    Icon(Icons.attach_money_rounded, size: 15, color: Colors.lime.shade800),
                                                    Text(Listorders[i].venuePrice, style: TextStyle(fontSize: 15),),
                                                  ],
                                                ),
                                                Padding(padding: EdgeInsets.symmetric(vertical: 3,)),

                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,

                                                  children: [
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(Icons.calendar_month_rounded, size: 15),
                                                            Text(Listorders[i].orderDate, style: TextStyle(fontSize: 15),),
                                                          ],),
                                                        Padding(padding: EdgeInsets.symmetric(vertical: 3,)),
                                                        Row(
                                                          children: [
                                                            Icon(Icons.access_time, size: 15),
                                                            Text(Listorders[i].orderTime, style: TextStyle(fontSize: 15),),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    TextButton(
                                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                                                        ),

                                                        onPressed: () {
                                                          setState(() {

                                                            //if(i==1)
                                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>orders(i))).then((value) => setState((){}));
                                                          });


                                                        }, child: Text('Manage',style: TextStyle(color: Colors.white),)),
                                                  ],
                                                ),



                                              ],
                                            ),
                                          ),
                                        ]),
                                  ),
                                )
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 10)),

                          ],
                        ),
                      );
                    }
                ):Center(
      child: SingleChildScrollView(
      child: NoTranscationMessage(
        messageTitle: "No Transactions, yet.",
        messageDesc:
        "You have never placed an order. Let's explore the sport venue near you.",
      ))),







                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Column(
                            children: [
                              if(haveHistory) Container(
                                child: Column(
                                  children: [
                                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                                    Card(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              print('stadium selected');
                                            });
                                          },
                                          child: Container(
                                            //padding: EdgeInsets.all(10),
                                            child: Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                                                    height: 110,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text('Dubai international cricket stadium',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),),
                                                          ],
                                                        ),
                                                        Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                                                        Row(
                                                          children: [
                                                            Icon(Icons.location_on_outlined,color: Colors.redAccent.shade200,size: 15,),
                                                            Text('Dubai, UAE',style: TextStyle(color: Colors.black26,fontSize: 15),),

                                                          ],
                                                        ),
                                                        Padding(padding: EdgeInsets.symmetric(vertical: 3,)),
                                                        Row(
                                                          children: [
                                                            Icon(Icons.attach_money_rounded, size: 15, color: Colors.lime.shade800),
                                                            Text('1500 Rs', style: TextStyle(fontSize: 15),),
                                                            SizedBox(width: width/2.6,),
                                                            Icon(Icons.calendar_month_rounded, size: 12),
                                                            Text('10-10-22', style: TextStyle(fontSize: 12),)
                                                          ],
                                                        ),
                                                        Padding(padding: EdgeInsets.symmetric(vertical: 1,)),
                                                        Row(
                                                          children: [
                                                            SizedBox(width: width/1.726,),
                                                            Icon(Icons.access_time, size: 12),
                                                            Text('10 pm', style: TextStyle(fontSize: 12),)
                                                          ],
                                                        ),
                                                        Padding(padding: EdgeInsets.symmetric(vertical: 1,)),

                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                        )
                                    ),
                                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                                  ],
                                ),
                              ),
                              if(!haveHistory)Container(
                                height: 676,
                                decoration: BoxDecoration(
                                    image: DecorationImage(image: NetworkImage('https://64.media.tumblr.com/2321767b60776e5cb244906bbe9ce7b2/tumblr_inline_msk4s3EnfY1qz4rgp.gif'), fit: BoxFit.cover)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text('No History', style: TextStyle(
                                          backgroundColor: Colors.white,
                                          fontSize: 20
                                      ),),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ])
      ),
    );
  }
}
