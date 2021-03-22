import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/components/product/buynow.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/constants/urls.dart';
import 'package:http/http.dart' as http;
import 'package:thrift_nep/provider/productToVerify.dart';
import 'package:thrift_nep/widgets/loading_indicator.dart';

class AdminProductDetails extends StatefulWidget {
  final productId;
  final productName;
  final productPrice;
  final negotiable;
  final condition;
  final usedfor;
  final category;
  final productImages;
  final details;
  final seller;

  AdminProductDetails(
      {
        this.productId,
        this.productName,
        this.productPrice,
        this.negotiable,
        this.condition,
        this.usedfor,
        this.category,
        this.productImages,
        this.details,
        this.seller
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
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {}),
          ],
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
                      image: CachedNetworkImageProvider(widget.productImages),
                      fit: BoxFit.fill,),
                  ),
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      leading: Text(
                        widget.productName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),

                      title: Text(
                        "Rs${widget.productPrice}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),

                    ),
                  ),

                  // child: ,
                )),

            Row(
              children: [
                //========== the size button ========
                Expanded(
                    child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  BuyNow(
                                    productId: widget.productId,
                                    productName: widget.productName,
                                    productPrice: widget.productPrice,
                                    productImages: widget.productImages,
                                    seller: widget.seller,
                                  )
                          ));
                        },
                        color: Colors.white,
                        textColor: kAppbar,
                        elevation: 0.2,
                        child: Text('Buy Now'))),


              ],
            ),
            Divider(
              color: kAppbar,
            ),
            ListTile(
              title: Text('Product Details'),
              subtitle: Text(widget.details),
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
                  child: Text(widget.productName),
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
                  child: Text(widget.usedfor),
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
                  child: Text(widget.condition),
                )
              ],
            ),
            Row(

              children: [
                IconButton(
                    icon: Icon(Icons.done),
                    onPressed: (){
                      approveProd();
                      Navigator.pushReplacementNamed(context, 'admin');
                    },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                IconButton(icon: Icon(Icons.cancel_outlined), onPressed: (){
                  declineProd();
                  Navigator.pushReplacementNamed(context, 'admin');
                })
              ],
            )
          ],
        ),
      ),
    );
  }
  void approveProd() async {
    onLoading(context);
    var url = '$APPROVEPRODUCT_URL?productId=${widget.productId}';
    var response = await http.get(url);
    Navigator.pop(context);
    //print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.body.contains("Updated")) {
      Provider.of<VerifyProductProvider>(context, listen: false).fetchProductToVerify();
      //  Navigator.pushReplacementNamed(context, 'home');
    } else {
      print('Failed');
    }
  }

  void declineProd() async {
    onLoading(context);
    var url = '$DECLINEPRODUCT_URL?productId=${widget.productId}';
    var response = await http.get(url);
    Navigator.pop(context);
    //print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.body.contains("Deleted")) {
      Provider.of<VerifyProductProvider>(context, listen: false).fetchProductToVerify();
      //  Navigator.pushReplacementNamed(context, 'home');
    } else {
      print('Failed');
    }
  }
}
