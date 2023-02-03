import 'package:oopleproject/backend/datamodels/venuedatamodel.dart';


List<venueDatamodel> venueList = [];

void addVenue(String venueName, String venueLocation, String venueImage, String venuePrice, String venueCategory, bool lockers, bool canteen, bool changingroom, bool washroom, bool wifi, int venueId){
  venueList.add(venueDatamodel(venueName, venueLocation, venueImage,
      venuePrice, venueCategory, lockers, canteen, changingroom, washroom, wifi, venueId));
}