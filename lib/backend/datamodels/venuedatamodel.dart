import 'package:oopleproject/backend/venueList.dart';

class venueDatamodel {
  String venueName = '';
  String venueLocation = '';
  String venueImage = '';
  String venuePrice = '';
  String venueCategory = '';
  bool lockers = false;
  bool canteen = false;
  bool changingroom = false;
  bool washroom = false;
  bool wifi = false;
  int venueId = 0;

  venueDatamodel(String venueName, String venueLocation, String venueImage,
      String venuePrice, String venueCategory, bool lockers, bool canteen, bool changingroom, bool washroom, bool wifi, int venueId) {
    this.venueName = venueName;
    this.venueLocation = venueLocation;
    this.venueImage = venueImage;
    this.venuePrice = venuePrice;
    this.venueCategory = venueCategory;
    this.lockers = lockers;
    this.canteen = canteen;
    this.changingroom = changingroom;
    this.washroom = washroom;
    this.wifi = wifi;
    this.venueId = venueId;
    confirmvenueAdd();
  }
  void confirmvenueAdd(){
    print('venue added');
  }
}




