import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thrift_nep/components/product.dart';
import 'package:thrift_nep/constants/urls.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> productList = [];

  List<Product> get allProduct => UnmodifiableListView(productList); //yo bhaneko chai NoteProvider le matra aba noteList lai change garna sakcha

  Future<void> fetchProduct() async {
    var url = '$READPRODUCT_URL';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      result.forEach((p) {
        var note = Product.fromJson(p);
        productList.add(note);
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




