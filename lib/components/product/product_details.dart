import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/components/product/buynow.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/constants/urls.dart';
import 'package:http/http.dart' as http;
import 'package:thrift_nep/provider/cart_provider.dart';
import 'package:thrift_nep/provider/emaiProvider.dart';
import 'package:thrift_nep/widgets/loading_indicator.dart';
import 'package:toast/toast.dart';

class ProductDetails extends StatefulWidget {
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

  ProductDetails(
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
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _globalKeyScaffold = GlobalKey<ScaffoldState>();

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
                    child:  Image(image: CachedNetworkImageProvider(widget.productImages),fit:BoxFit.fill,),
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
                      // title: Row(
                      //   children: [
                      //     // Expanded(
                      //     //     child: Text(
                      //     //       widget.seller,
                      //     //   style: TextStyle(
                      //     //     color: Colors.grey,
                      //     //    // decoration: TextDecoration.lineThrough,
                      //     //   ),
                      //     // )),
                      //     Expanded(
                      //         child: Text(
                      //       "Rs${widget.productPrice}",
                      //       style: TextStyle(
                      //           fontWeight: FontWeight.bold, color: Colors.red),
                      //     )),
                      //   ],
                      // ),
                    ),
                  ),

                  // child: ,
                )),
            // ===== the first buttons ==========
            // Row(
            //   children: [
                //========== the size button ========
                // Expanded(
                //     child: MaterialButton(
                //   onPressed: () {
                //     showDialog(
                //         context: context,
                //         builder: (context) {
                //           return AlertDialog(
                //             title: Text("Size"),
                //             content: Text('Choose the size'),
                //             actions: [
                //               MaterialButton(
                //                   onPressed: () {
                //                     Navigator.pop(context);
                //                   },
                //                   child: Text('close'))
                //             ],
                //           );
                //         });
                //   },
                //   color: Colors.white,
                //   textColor: kAppbar,
                //   elevation: 0.2,
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Text("Size"),
                //       ),
                //       Expanded(
                //         child: Icon(Icons.arrow_drop_down),
                //       ),
                //     ],
                //   ),
                // ))
            //   ],
            // ),
            Row(
              children: [
                //========== the size button ========
                Expanded(
                    child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BuyNow(
                                productId: widget.productId,
                                productName:widget.productName,
                                productPrice:widget.productPrice,
                                productImages: widget.productImages,
                                seller: widget.seller,
                              )
                          ));
                        },
                        color: Colors.white,
                        textColor: kAppbar,
                        elevation: 0.2,
                        child: Text('Buy Now'))),
                IconButton(
                    icon: Icon(
                      Icons.add_shopping_cart,
                      color: kAppbar,
                    ),
                    onPressed: () {
                      addToCart();
                    }),

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
            // Divider(),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(
            //     "Similar Products",
            //     style: TextStyle(color: kAppbar),
            //   ),
            // ),
            // SIMILAR PRODUCT SECTION
            // Container(
            //   height: 360.0,
            //   child: Similar_products(),
            // )
          ],
        ),
      ),
    );
  }
  addToCart() async
  {
    onLoading(context);
    var product_id = widget.productId;
    String user_id = Provider.of<EmailProvider>(context, listen: false).id;
    bool isAdded = await Provider.of<CartProvider>(context, listen: false)
        .addInCart(user_id,
        product_id);
    Navigator.pop(context);
    if (isAdded) {
      Toast.show("Added to cart.", context);
    } else {
      Toast.show("Product is already added to cart.", context);
    }
    //Navigator.pop(context);
  }


  // void addToCart() async {
  //   var id = widget.productId;
  //   print(id);
  //   String user_id = Provider.of<EmailProvider>(context, listen: false).id;
  //
  //   onLoading(context);
  // //  var url = '$ADDTOCART_URL?name=${widget.productName}&price=${widget.productPrice}&condition=${widget.condition}&seller=${widget.seller}&negotiable=${widget.negotiable}&image=${widget.productImages}&seller=$email';
  //   var url = '$ADDTOCART_URL?product_id=${widget.productId}&cart_of=$user_id';
  //   var response = await http.get(url);
  //
  //   //print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');
  //   if (response.body.toString().contains('Already')) {
  //     print('Already in cart');
  //     Navigator.pop(context);
  //     _showSnackBar("Already in cart!!");
  //   } else {
  //     print('Added to cart');
  //     Navigator.pop(context);
  //   }
  //
  // }

  void _showSnackBar(String message) {
    final _snackBar = SnackBar(content: Text(message));
    _globalKeyScaffold.currentState.showSnackBar(_snackBar);
  }
}

