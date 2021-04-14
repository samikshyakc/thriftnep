import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/adminPages/AllProducts/disapprovedWidget.dart';
import 'package:thrift_nep/components/product/product.dart';
import 'package:thrift_nep/constants/urls.dart';
import 'package:thrift_nep/provider/disapprovedProduct_provider.dart';

class DisapprovedProducts extends StatefulWidget {
  @override
  _DisapprovedProductsState createState() => _DisapprovedProductsState();
}

class _DisapprovedProductsState extends State<DisapprovedProducts> {
  List<Product> productList = [];

  bool isLoading= true;

  Future<void> fetchProductDisapproved() async {
    productList = [];
    var url = '$DISPRODUCT_URL';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print(result);
      result.forEach((p) {
        var note = Product.fromJson(p);
     //   print(note);
        productList.add(note);
      });
      setState(() {
        isLoading  = false;
      });
    }


  }

  @override
  void initState(){
    // fetchDispatchedOrder();
    Provider.of<DisapprovedProductProvider>(context, listen: false).fetchProductDisapproved();
    setState(() {
      isLoading=false;
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    productList = Provider.of<DisapprovedProductProvider>(context, listen: true).allDisProduct;
    return Scaffold(
      appBar: AppBar(),
      body: productList.length == 0? Center(child: Text("No new products", style:TextStyle(color: Colors.black),)): SingleChildScrollView(
        child: (!isLoading)?ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: productList.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return DisapprovedWidget(product: productList[index]);
            }): Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
