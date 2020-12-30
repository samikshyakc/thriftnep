import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'file:///C:/flutter_project/thrift_nep/lib/components/cart/cart.dart';
import 'package:thrift_nep/constants/urls.dart';


class CartProvider extends ChangeNotifier {

  List<Cart> cartproductList = [];

  int totalPrice =0;

  List<Cart> get allProduct => UnmodifiableListView(cartproductList);

  //String email = Provider.of<EmailProvider>(context, listen: false).email();
  Future<void> fetchCart(String user) async {
    cartproductList = [];
    var url = '$FETCHCART_URL?user=$user';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      result.forEach((p) {
        var cart = Cart.fromJson(p);
        totalPrice += int.parse(cart.price);
        cartproductList.add(cart);
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




