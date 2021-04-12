import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thrift_nep/components/order/orders.dart';
import 'package:thrift_nep/constants/urls.dart';



class DisptachOrderProvider extends ChangeNotifier {

  List<Order> orderList = [];

  List<Order> get dispatchOrder => UnmodifiableListView(orderList);

  //String email = Provider.of<EmailProvider>(context, listen: false).email();
  Future<void> fetchDispatchedOrder() async {
    orderList = [];
    var url = '$FETCHDISPATCEDORDER_URL';
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
  Future deliveredOrder(String order_id) async {
    //onLoading(context);
    var url = '$UPDATEORDERSTATUS_URL?order_id=$order_id&status=3';
    var response = await http.get(url);
    // Navigator.pop(context);
    //print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.body.contains("Updated")) {
      //   Provider.of<DisptachOrderProvider>(context, listen: false).fetchDispatchedOrder();
      //   Navigator.pushReplacementNamed(context, 'admin');
      fetchDispatchedOrder();
      notifyListeners();
      return true;
    } else {
      print('Failed');
      notifyListeners();
      return false;
    }
  }

}




