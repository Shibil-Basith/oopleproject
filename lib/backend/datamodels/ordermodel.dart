
import 'package:oopleproject/backend/datamodels/venuedatamodel.dart';

class orderModel extends venueDatamodel{
  String orderDate = '';
  String orderTime = '';


  orderModel(String venueName, String venueLocation, String venueImage,
      String venuePrice, String venueCategory, bool lockers, bool canteen, bool changingroom, bool washroom, bool wifi, int venueId, String orderDate, String orderTime) : super('', '', '', '', '', false, false, false, false, false, 0){
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
    this.orderDate = orderDate;
    this.orderTime = orderTime;
    confirmOrder();
  }
  void confirmOrder(){
    print('Order submitted');
  }
}




