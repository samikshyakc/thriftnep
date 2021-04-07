import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thrift_nep/components/product/product.dart';
import 'package:thrift_nep/constants/urls.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> productList=[];


  List<Product> get allProduct => UnmodifiableListView(productList); //yo bhaneko chai ProductProvider le matra aba productList lai change garna sakcha

  Future<void> fetchProduct() async {
    var url = '$READPRODUCT_URL';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print(result);
      result.forEach((p) {
        var note = Product.fromJson(p);
       print(note);
        productList.add(note);
      });
    }

    notifyListeners();
  }

  List<Product> filterByCat(String category){
    List<Product> filteredList = [];
    productList.forEach((product) {
      if(product.category == category){
        filteredList.add(product);
      }
    });
    return filteredList;
  }


  List<Product> filterProduct(String search){
    List<Product> filteredProd = [];
    productList.forEach((product) {
      if(product.productName.toLowerCase().contains(search.toLowerCase())){
        filteredProd.add(product);
      }
    });
    return filteredProd;
  }

}




