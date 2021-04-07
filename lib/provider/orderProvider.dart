import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thrift_nep/components/order/orders.dart';
import 'package:thrift_nep/constants/urls.dart';


class OrderProvider extends ChangeNotifier {

  List<Order> orderList = [];

  int totalPrice =0;

  List<Order> get allOrder => UnmodifiableListView(orderList);

  //String email = Provider.of<EmailProvider>(context, listen: false).email();
  Future<void> fetchOrder(String user) async {
    orderList = [];
    var url = '$FETCHORDER_URL?user=$user';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      result.forEach((p) {
        var order = Order.fromJson(p);
      //  print(order.proid);
        totalPrice += int.parse(order.productPrice);
        orderList.add(order);
      });
    }

    notifyListeners();
  }
  //
  // List<Order> filterByDate(String from, String to){
  //   List<Order> filteredList = [];
  //   orderList.forEach((orderss) {
  //     if(orderss.date == from && orderss){
  //       filteredList.add(product);
  //     }
  //   });
  //   return filteredList;
  // }

}




