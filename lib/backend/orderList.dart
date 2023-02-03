

import 'package:oopleproject/backend/datamodels/ordermodel.dart';

List<orderModel> orderList = [];
List<orderModel> Listorders = [];
List<orderModel> Listhistories = [];


void addOrder(String venueName, String venueLocation, String venueImage, String venuePrice, String venueCategory, bool lockers, bool canteen, bool changingroom, bool washroom, bool wifi, int venueId, String orderDate, String orderTime){
  orderList.add(orderModel(venueName, venueLocation, venueImage,
      venuePrice, venueCategory, lockers, canteen, changingroom, washroom, wifi, venueId, orderDate, orderTime));
      Listorders = orderList;
}