
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/adminPages/AllProducts/allProduct_widget.dart';
import 'package:thrift_nep/components/product/product.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/provider/product_provider.dart';
import 'package:thrift_nep/widgets/product_widget.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product> prodList = [];
  bool typing = false;

  @override
  void initState() {
    prodList =
        Provider.of<ProductProvider>(context, listen: false).filterProduct('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0.1, //automaticallyImplyLeading: false,
            backgroundColor: kAppbar,
         //   iconTheme: IconThemeData(color: Colors.white),

          title: Container(
            alignment: Alignment.centerLeft,
            color: Colors.transparent,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  prodList = [];
                  prodList =
                      Provider.of<ProductProvider>(context, listen: false)
                          .filterProduct(value);
                });
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white)),
            ),
          ),
        ),
       
        body: prodList.isEmpty
            ? Center(child: Text("No results")) :
           // ?
        Container(
          child:GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: prodList.length,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
              itemBuilder: (context, index) {
                return AllProductWidget(product: prodList[index]);
              }),
        )
            // : Container(
            //
            // child: Center(
            //     child: Text(
            //       'No results',
            //       textScaleFactor: 1,
            //       style: GoogleFonts.roboto(
            //         textStyle: TextStyle(
            //             color: Colors.black,
            //             fontSize: 30.0,
            //             fontWeight: FontWeight.normal),
            //       ),
            //       textAlign: TextAlign.center,
            //     ))),
      ),
    );
  }
}