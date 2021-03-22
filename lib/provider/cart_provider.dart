import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thrift_nep/components/cart/cart.dart';
import 'package:thrift_nep/constants/urls.dart';


class CartProvider extends ChangeNotifier {

  List<Cart> cartproductList = [];

  int totalPrice =0;

  List<Cart> get allCart=> UnmodifiableListView(cartproductList);

  //String email = Provider.of<EmailProvider>(context, listen: false).email();
  Future<void> fetchCart(String user) async {
    cartproductList = [];
    var url = '$FETCHCART_URL?user=$user';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print(result);
      result.forEach((p) {
        var cart = Cart.fromJson(p);
        print(cart.cartId);
        totalPrice += int.parse(cart.productPrice);
        cartproductList.add(cart);
      });
    }

    notifyListeners();
  }



}




