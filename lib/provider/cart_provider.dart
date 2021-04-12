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
    print(response);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print('cart result: $result');
      result.forEach((p) {
        var cart = Cart.fromJson(p);
        print(cart.cartId);
        totalPrice += int.parse(cart.productPrice);
        cartproductList.add(cart);
      });
    }
    notifyListeners();
  }

  Future deleteFromCart(String cartID, Cart cart) async {
   // String cartID = widget.cartProduct.cartId;
    print("cart id = $cartID");
    //onLoading(context);
    var url = '$DELETECART_URL?cart_id=$cartID';
    var response = await http.get(url);

    //print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.body.contains("Removed succesfully.")) {
     // Navigator.pop(context);
      //  Provider.of<CartProvider>(context, listen: false).fetchCart(email);
      //  Navigator.pushReplacementNamed(context, 'home');
      totalPrice=totalPrice- int.parse(cart.productPrice);
      cartproductList.remove(cart);

      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    //  Navigator.pop(context);
     // print('Failed');
    }
  }

  Future addInCart(String user_id, String product_id) async {
   // var id = widget.productId;
  //  print(id);
   // String user_id = Provider.of<EmailProvider>(context, listen: false).id;

   // onLoading(context);
    //  var url = '$ADDTOCART_URL?name=${widget.productName}&price=${widget.productPrice}&condition=${widget.condition}&seller=${widget.seller}&negotiable=${widget.negotiable}&image=${widget.productImages}&seller=$email';
    var url = '$ADDTOCART_URL?product_id=$product_id&cart_of=$user_id';
    var response = await http.get(url);

    //print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.body.toString().contains('product added to cart')) {
      fetchCart(user_id);
      notifyListeners();
      return true;
  //    Navigator.pop(context);
   //   _showSnackBar("Already in cart!!");
    } else {
      print('Already in cart');
      notifyListeners();
      return false;
    //  Navigator.pop(context);
    }

  }



}




