import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/components/product/product.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/constants/urls.dart';
import 'package:http/http.dart' as http;
import 'package:thrift_nep/provider/productToVerify.dart';
import 'package:thrift_nep/widgets/loading_indicator.dart';
import 'package:toast/toast.dart';

class AdminProductDetails extends StatefulWidget {
  // final productId;
  // final productName;
  // final productPrice;
  // final negotiable;
  // final condition;
  // final usedfor;
  // final category;
  // final productImages;
  // final details;
  // final seller;
   Product product;
  AdminProductDetails(
      {
     this.product
        // this.productId,
        // this.productName,
        // this.productPrice,
        // this.negotiable,
        // this.condition,
        // this.usedfor,
        // this.category,
        // this.productImages,
        // this.details,
        // this.seller
      });

  @override
  _AdminProductDetailsState createState() => _AdminProductDetailsState();
}

class _AdminProductDetailsState extends State<AdminProductDetails> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          title: Text(
            'Thrift Nep',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: kAppbar,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: ListView(
          children: [
            Container(
                height: 300.0,
                child: GridTile(
                  child: Container(
                    color: Colors.white,
                    // child: Image.asset(widget.productImages),
                    child: Image(
                      image: CachedNetworkImageProvider(widget.product.productImages),
                      fit: BoxFit.fill,),
                  ),
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      leading: Text(
                        widget.product.productName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),

                      title: Text(
                        "Rs${widget.product.productPrice}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),

                    ),
                  ),

                  // child: ,
                )),

            Divider(
              color: kAppbar,
            ),
            ListTile(
              title: Text('Product Details'),
              subtitle: Text(widget.product.description),
              // subtitle: Text(
              // 'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.'),
            ),
            Divider(),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: Text(
                    "Product Name",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(widget.product.productName),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: Text(
                    "Used For",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(widget.product.usedFor),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: Text(
                    "Product Condition",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(widget.product.productCondition),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: Text(
                    "Product Category",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(widget.product.category),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: Text(
                    "Product Seller",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(widget.product.seller),
                )
              ],
            ),
            Row(

              children: [
                ElevatedButton(
                  child: Text('Approve', style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    primary: kAppbar,
                  ),
                  //icon: Icon(Icons.pic),
                  onPressed: () {
                   approveProd();
                   Navigator.pushReplacementNamed(context, 'verify');
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                ElevatedButton(
                  child: Text('Disapprove', style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    primary: kAppbar,
                  ),
                  //icon: Icon(Icons.pic),
                  onPressed: () {
                    declineProd();
                    Navigator.pushReplacementNamed(context, 'verify');
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  approveProd() async {
    onLoading(context);
    bool isAdded = await Provider.of<VerifyProductProvider>(context, listen: false)
        .approvePRoduct(widget.product.productId, widget.product);
    Navigator.pop(context);
    if (isAdded) {
      Toast.show("Product Approved", context);
    } else {
      Toast.show("Something is wrong.", context);
    }
  }
  // void approveProd() async {
  //   onLoading(context);
  //   var url = '$APPROVEPRODUCT_URL?productId=${widget.productId}';
  //   var response = await http.get(url);
  //   Navigator.pop(context);
  //   //print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');
  //   if (response.body.contains("Updated")) {
  //     Provider.of<VerifyProductProvider>(context, listen: false).fetchProductToVerify();
  //     //  Navigator.pushReplacementNamed(context, 'home');
  //   } else {
  //     print('Failed');
  //   }
  // }
  declineProd() async {
    onLoading(context);
    bool isDeclined = await Provider.of<VerifyProductProvider>(context, listen: false)
        .declineProd(widget.product.productId, widget.product);
    Navigator.pop(context);
    if (isDeclined) {
      Toast.show("Product Declined", context);
    } else {
      Toast.show("Something is wrong.", context);
    }
  }
  // void declineProd() async {
  //   onLoading(context);
  //   var url = '$DECLINEPRODUCT_URL?productId=${widget.productId}';
  //   var response = await http.get(url);
  //   Navigator.pop(context);
  //   //print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');
  //   if (response.body.contains("Deleted")) {
  //     Provider.of<VerifyProductProvider>(context, listen: false).fetchProductToVerify();
  //     //  Navigator.pushReplacementNamed(context, 'home');
  //   } else {
  //     print('Failed');
  //   }
  // }
}
