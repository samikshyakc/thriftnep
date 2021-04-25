import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:thrift_nep/components/order/orders.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:http/http.dart' as http;


class DeliveredOrderWidget extends StatefulWidget {
  final Order orderProduct;


  DeliveredOrderWidget(this.orderProduct);

  @override
  _DeliveredOrderWidgetState createState() => _DeliveredOrderWidgetState();
}

class _DeliveredOrderWidgetState extends State<DeliveredOrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: (){},
        // => Navigator.of(context).push(MaterialPageRoute(
        //   //  here we are passing the value of the product to product details page
        //     builder: (context) => AdminOrderDetails(
        //       productId: orderProduct.productId,
        //       productName:orderProduct.productName,
        //       productPrice: orderProduct.productPrice,
        //       // negotiable: product.negotiable,
        //       condition: orderProduct.productCondition,
        //       usedfor: orderProduct.usedFor,
        //       category: orderProduct.category,
        //       productImages: orderProduct.productImages,
        //       details: orderProduct.description,
        //       seller: orderProduct.seller,
        //       orderId: orderProduct.orderId,
        //
        //     ))),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          secondaryActions: <Widget>[
            new IconSlideAction(
              caption: 'More',
              color: Colors.black45,
              icon: Icons.more_horiz,
              onTap: () {},
            ),
            new IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {
               // deliveredOrder();
              },
            ),
          ],
          child: ListTile(
            leading: Image(
              image: CachedNetworkImageProvider(widget.orderProduct.productImages),
              width: 50.0,
              height: 100.0,
            ),
            title: Text(widget.orderProduct.productName),
            subtitle: Column(
              children: [
                Row(
                  children: [
                    //       ===product size section==
                    Text("Ordered Date:"),
                    Text(
                      widget.orderProduct.date,
                      style: TextStyle(color: kAppbar),
                    ),
                    Padding(padding: const EdgeInsets.only(left: 20),),

                  ],

                ),

                //          ======Section for product price=====
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Rs ${widget.orderProduct.productPrice}",
                    style: TextStyle(
                        fontSize: 17.0,
                        color: kAppbar,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void deliveredOrder() async {
  //   onLoading(context);
  //   var url = '$UPDATEORDERSTATUS_URL?order_id=${widget.orderProduct.orderId}&status=Delivered';
  //   var response = await http.get(url);
  //   Navigator.pop(context);
  //   //print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');
  //   if (response.body.contains("Updated")) {
  //     Provider.of<DisptachOrderProvider>(context, listen: false).fetchDispatchedOrder();
  //     Navigator.pushReplacementNamed(context, 'admin');
  //   } else {
  //     print('Failed');
  //   }
  // }
}
