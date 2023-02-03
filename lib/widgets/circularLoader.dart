import 'package:flutter/material.dart';
import 'package:oopleproject/importedTheme.dart';

class DottedCircularProgressDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: colorWhite,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        height: 200,
        //width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40,),
            Image(image: AssetImage('assets/images/loading.gif'), fit: BoxFit.fill, height: 30,),
            SizedBox(height: 15,),
            Text('Thank you for using the app', style: addressTextStyle,)
          ],
        ),
      ),
    );
  }
}
