import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/adminPages/AllProducts/allProduct_widget.dart';
import 'package:thrift_nep/components/product/product.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/constants/urls.dart';
import 'package:thrift_nep/provider/product_provider.dart';


class AllProduct extends StatefulWidget {
  @override
  _AllProductState createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  List<Product> productList = [];

  bool isLoading =true;

  Future<void> fetchProduct() async {
    productList = [];
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

      setState(() {
        isLoading=false;
      });
    }
  }

  @override
  void initState(){
    // fetchDispatchedOrder();
    Provider.of<ProductProvider>(context, listen: false).fetchProduct();
    setState(() {
      isLoading=false;
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    productList = Provider.of<ProductProvider>(context, listen: true).allProduct;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppbar,
        title: Text("All Products", style: TextStyle(color: Colors.white),),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back, color: Colors.white,),
        // ),
      ),
      // body: VerifyProdWidget(),
      body: SingleChildScrollView(
        child: (!isLoading)?ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: productList.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return AllProductWidget(product: productList[index]);
            }): Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
