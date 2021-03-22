import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'file:///C:/Users/Samikshya/AndroidStudioProjects/thriftnep/lib/adminPages/ProductVerification/verifyproductwidget.dart';
import 'package:thrift_nep/components/product/product.dart';
import 'package:thrift_nep/provider/productToVerify.dart';


class Verification extends StatelessWidget {
  List<Product> productList = [];
  @override
  Widget build(BuildContext context) {
    productList = Provider.of<VerifyProductProvider>(context, listen: true).allVerifyProduct;
    return Scaffold(
      appBar: AppBar(),
     // body: VerifyProdWidget(),
      body: SingleChildScrollView(
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: productList.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return VerifyProdWidget(product: productList[index]);
            }),
      ),
    );
  }
}
