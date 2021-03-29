import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thrift_nep/components/product/product.dart';
import 'package:thrift_nep/constants/urls.dart';

class DisapprovedProductProvider extends ChangeNotifier {
  List<Product> disproductList=[];

  List<Product> get allDisProduct => UnmodifiableListView(disproductList);
  //yo bhaneko chai ProductProvider le matra aba productList lai change garna sakcha


  Future<void> fetchProductDisapproved() async {
    var url = '$DISPRODUCT_URL';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print(result);
      result.forEach((p) {
        var note = Product.fromJson(p);
        print(note);
        disproductList.add(note);
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




