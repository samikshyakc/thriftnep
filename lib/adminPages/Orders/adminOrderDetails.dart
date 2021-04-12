import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/components/order/orders.dart';
import 'package:thrift_nep/components/product/buynow.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/constants/urls.dart';
import 'package:thrift_nep/provider/allOrderProvider.dart';
import 'package:thrift_nep/widgets/loading_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';


class AdminOrderDetails extends StatefulWidget {
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
  final orderId;
  final orderAddress;
  final buyer;
  Order order;

  AdminOrderDetails(
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
        this.buyer,
        this.seller,
        this.orderId,
        this.orderAddress
      });

  @override
  _AdminOrderDetailsState createState() => _AdminOrderDetailsState();
}

class _AdminOrderDetailsState extends State<AdminOrderDetails> {

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
                    "Product Buyer",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(widget.buyer),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: Text(
                    "Delivery Address",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(widget.orderAddress),
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
                  onPressed: () {
                    dispatchOrder();
                    // approveProd();
                    //   Navigator.pushReplacementNamed(context, 'admin');
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                IconButton(icon: Icon(Icons.cancel_outlined), onPressed: () {
                  // declineProd();
                  //Navigator.pushReplacementNamed(context, 'admin');
                })
              ],
            )
          ],
        ),
      ),
    );
  }

  dispatchOrder() async {
    onLoading(context);
    bool isAdded = await Provider.of<AllOrderProvider>(context, listen: false)
        .disptachedOrder(widget.orderId);
    Navigator.pop(context);
    if (isAdded) {
      Toast.show("Order Dispatched", context);
    } else {
      Toast.show("Something is wrong.", context);
    }
  }
}
// void disptachOrder() async {
//   onLoading(context);
//   var url = '$UPDATEORDERSTATUS_URL?order_id=${widget.orderId}&status=2';
//   var response = await http.get(url);
//   Navigator.pop(context);
//   //print('Response status: ${response.statusCode}');
//   print('Response body: ${response.body}');
//   if (response.body.contains("Updated")) {
//     Provider.of<AllOrderProvider>(context, listen: false).fetchAllOrder();
//     Navigator.pushReplacementNamed(context, 'admin');
//   } else {
//     print('Failed');
//   }
// }
//
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

