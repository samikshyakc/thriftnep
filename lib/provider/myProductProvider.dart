import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thrift_nep/components/product/product.dart';
import 'package:thrift_nep/constants/urls.dart';

class MyProductProvider extends ChangeNotifier {

  List<Product> myproductList=[];

  List<Product> get myProduct => UnmodifiableListView(myproductList); //yo bhaneko chai ProductProvider le matra aba productList lai change garna sakcha

  Future<void> fetchmyProduct(String email) async {
    var url = '$MYPRODUCT_URL?email=$email';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print(result);
      result.forEach((p) {
        var note = Product.fromJson(p);
        print(note);
        myproductList.add(note);
      });
    }

    notifyListeners();
  }


}




