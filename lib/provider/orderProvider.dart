import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thrift_nep/components/cart/cart.dart';
import 'package:thrift_nep/constants/urls.dart';


class OrderProvider extends ChangeNotifier {

  List<Cart> orderList = [];

  int totalPrice =0;

  List<Cart> get allProduct => UnmodifiableListView(orderList);

  //String email = Provider.of<EmailProvider>(context, listen: false).email();
  Future<void> fetchCart(String user) async {
    orderList = [];
    var url = '$FETCHORDER_URL?user=$user';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      result.forEach((p) {
        var order = Cart.fromJson(p);
        print(order.id);
        totalPrice += int.parse(order.price);
        orderList.add(order);
      });
    }

    notifyListeners();
  }

// Future<String> save(String title, String details) async {
//   var url = '$ADDNOTE_URL?title=$title&details=$details';
//   var response = await http.get(url);
//   if (response.body.contains("Created")) {
//     productList = [];
//     fetchNote();
//   }
//   return response.body;
// }
}



