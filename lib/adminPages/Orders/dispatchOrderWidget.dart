import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/components/order/orders.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/constants/urls.dart';
import 'package:thrift_nep/provider/allOrderProvider.dart';
import 'package:thrift_nep/provider/dispatchedOrderProvider.dart';
import 'package:thrift_nep/widgets/loading_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class DispatchOrderWidget extends StatefulWidget {
  final Order orderProduct;

  DispatchOrderWidget(this.orderProduct);

  @override
  _DispatchOrderWidgetState createState() => _DispatchOrderWidgetState();
}

class _DispatchOrderWidgetState extends State<DispatchOrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: ExpansionTile(
          leading: Image(
            image:
                CachedNetworkImageProvider(widget.orderProduct.productImages),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                  ),
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
            children: [
              Divider(
                color: kAppbar,
              ),
              ListTile(
                title: Text('Product Details'),
                subtitle: Text(widget.orderProduct.description),
                // subtitle: Text(
                // 'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.'),
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
                    child: Text(widget.orderProduct.usedFor),
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
                    child: Text(widget.orderProduct.buyer),
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
                    child: Text(widget.orderProduct.address),
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
                    child: Text(widget.orderProduct.productCondition),
                  )
                ],
              ),
              Row(

                children: [
                  IconButton(
                    icon: Icon(Icons.done),
                    onPressed: () {
                      deliveredOrder();
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
            ]
        ),
      ),
    );
  }

  // void deliveredOrder() async {
  //   onLoading(context);
  //   var url = '$UPDATEORDERSTATUS_URL?order_id=${widget.orderProduct.orderId}&status=3';
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

  deliveredOrder() async{

    onLoading(context);
    bool isDelivered = await Provider.of<DisptachOrderProvider>(context, listen: false)
        .deliveredOrder(widget.orderProduct.orderId,widget.orderProduct);
    Navigator.pop(context);
    if (isDelivered) {
      Toast.show("Product Delivered.", context);
    } else {
      Toast.show("Something is wrong.", context);
    }
  }
}
