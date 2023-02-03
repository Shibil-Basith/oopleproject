import 'package:flutter/material.dart';
import 'package:oopleproject/components/user/bottomNavigationbar.dart';
import 'package:oopleproject/components/user/transactions.dart';
import 'package:oopleproject/theme.dart';

import '../../backend/orderList.dart';
import '../../importedTheme.dart';

class cancelConfirm extends StatefulWidget {
  //const cancelConfirm({Key? key}) : super(key: key);

  int val;
  cancelConfirm(this.val);


  @override
  State<cancelConfirm> createState() => _cancelConfirmState();
}

class _cancelConfirmState extends State<cancelConfirm> {
  @override
  Widget build(BuildContext context) {
    var newVal = widget.val;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Are you sure?'),
            Row(
              children: [
                ElevatedButton(onPressed: () {
                    setState(() {
                      print("cancelled: ");
                      print(newVal);
                      Listorders.removeAt(newVal);
                      print(Listorders.length);
                      SetCurrentIndex(1);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>bottomNavigationbar()));
                    });
                }, child: Text('Yes')),
                Spacer(),
                ElevatedButton(onPressed: () {
                  Navigator.pop(context);
                }, child: Text('No')),
              ],
            )
          ],
        ),
      ),
    );
  }
}

