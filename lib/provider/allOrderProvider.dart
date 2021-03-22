import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thrift_nep/components/order/orders.dart';
import 'package:thrift_nep/constants/urls.dart';


class AllOrderProvider extends ChangeNotifier {

  List<Order> orderList = [];

  List<Order> get allOrder => UnmodifiableListView(orderList);

  //String email = Provider.of<EmailProvider>(context, listen: false).email();
  Future<void> fetchAllOrder() async {
    orderList = [];
    var url = '$FETCHALLORDER_URL';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      result.forEach((p) {
        var order = Order.fromJson(p);
        //  print(order.proid);
       // totalPrice += int.parse(order.productPrice);
        orderList.add(order);
      });
    }

    notifyListeners();
  }

}




