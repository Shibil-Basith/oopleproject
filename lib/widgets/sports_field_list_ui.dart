import 'package:flutter/material.dart';
import 'package:oopleproject/components/user/venueDetails.dart';

import '../backend/datamodels/venuedatamodel.dart';
import '../importedTheme.dart';


class SportFieldList extends StatelessWidget {
  venueDatamodel field;

  SportFieldList({required this.field});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 10, top: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: (){
         /* Navigator.push(context, MaterialPageRoute(builder: (context){
            return DetailScreen(field: field,);
          })); */
          Navigator.push(context, MaterialPageRoute(builder: (context)=>venueDetails(field.venueId)));
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          width: width/1.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0), color: colorWhite),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius:
                BorderRadius.circular(borderRadiusSize),
                child: Image.network(field.venueImage,
                    height: 65,
                    width: 100,
                    fit: BoxFit.cover),
              ),
              const SizedBox(width: 8,),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      field.venueName,
                      maxLines: 1,
                      style: subTitleTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/icons/pin.png",
                          width: 20,
                          height: 20,
                          color: primaryColor500,
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Flexible(
                          child: Text(
                            field.venueLocation,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: addressTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
