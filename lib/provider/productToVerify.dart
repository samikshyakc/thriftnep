import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thrift_nep/components/product/product.dart';
import 'package:thrift_nep/constants/urls.dart';

class VerifyProductProvider extends ChangeNotifier {
  List<Product> verifyproductList=[];

  List<Product> get allVerifyProduct => UnmodifiableListView(verifyproductList);
   //yo bhaneko chai ProductProvider le matra aba productList lai change garna sakcha


Future<void> fetchProductToVerify() async {
  var url = '$VERIFIYPRODUCT_URL';
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    print(result);
    result.forEach((p) {
      var note = Product.fromJson(p);
      print(note);
      verifyproductList.add(note);
    });
  }

  notifyListeners();
}

  Future approvePRoduct(String product_id, Product product) async {
    //onLoading(context);
    var url = '$APPROVEPRODUCT_URL?product_id=$product_id';
    var response = await http.get(url);
  //  Navigator.pop(context);
    //print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.body.contains("Updated")) {
     // fetchProductToVerify();
      verifyproductList.remove(product);

      notifyListeners();
      return true;
    //  Provider.of<VerifyProductProvider>(context, listen: false).fetchProductToVerify();
      //  Navigator.pushReplacementNamed(context, 'home');
    } else {
      print('Failed');
      notifyListeners();
      return false;
    }
  }

  Future declineProd(String product_id, Product product) async {
   // onLoading(context);
    var url = '$DECLINEPRODUCT_URL?product_id=$product_id';
    var response = await http.get(url);
  //  Navigator.pop(context);
    //print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.body.contains("Updated")) {
      fetchProductToVerify();
      verifyproductList.remove(product);
      notifyListeners();
      return true;
  //    Provider.of<VerifyProductProvider>(context, listen: false).fetchProductToVerify();
      //  Navigator.pushReplacementNamed(context, 'home');
    } else {
      print('Failed');
      notifyListeners();
      return false;
    }
  }

}




