import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thrift_nep/components/order/orders.dart';
import 'package:thrift_nep/constants/urls.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/provider/dispatchedOrderProvider.dart';


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
  Future disptachedOrder(String orderID, Order order) async {
   // onLoading(context);
    var url = '$UPDATEORDERSTATUS_URL?order_id=$orderID&status=2';
    var response = await http.get(url);
  //  Navigator.pop(context);
    //print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.body.contains("Updated")) {
      fetchAllOrder();
      orderList.remove(order);
      notifyListeners();
      return true;
      // Provider.of<AllOrderProvider>(context, listen: false).fetchAllOrder();
      // Navigator.pushReplacementNamed(context, 'admin');
    } else {
      print('Failed');
      notifyListeners();
      return false;
    }
  }


}




