
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/components/product/product.dart';
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
        Provider.of<ProductProvider>(context, listen: false).filterProduct("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
        // body: Container(
        //   height: 900,
        //   decoration: GradientWidget(),
        //   child: ListView(
        //     children: [
        //       TextField(
        //         onChanged: (value) {
        //           setState(() {
        //             hallList =
        //                 Provider.of<EventHallProvider>(context, listen: false)
        //                     .filterHall(value);
        //             print(value);
        //           });
        //         },
        //         style: TextStyle(color: Colors.white),
        //         obscureText: false,
        //         decoration: InputDecoration(
        //             // icon: Icon(
        //             //   Icons.arrow_back,
        //             //   color: Colors.white,
        //             //   size: 30,
        //             // ),
        //             hintText: 'Search',
        //             hintStyle: TextStyle(color: Colors.white)),
        //       ),
        //
        //     ],
        //   ),
        // ),
        body: prodList.isNotEmpty
            ?               Container(
          child:GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: prodList.length,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return ProductWidget(product: prodList[index]);
              }),
        )
            : Container(

            child: Center(
                child: Text(
                  'No results',
                  textScaleFactor: 1,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.normal),
                  ),
                  textAlign: TextAlign.center,
                ))),
      ),
    );
  }
}