import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/adminPages/Orders/adminOrderDetails.dart';
import 'package:thrift_nep/components/order/orders.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/provider/allOrderProvider.dart';
import 'package:thrift_nep/widgets/loading_indicator.dart';
import 'package:toast/toast.dart';


class AdminOrderWidget extends StatefulWidget {
  final Order orderProduct;


  AdminOrderWidget(this.orderProduct);

  @override
  _AdminOrderWidgetState createState() => _AdminOrderWidgetState();
}

class _AdminOrderWidgetState extends State<AdminOrderWidget> {
  @override
  Widget build(BuildContext context) {
    bool visibility = false;
    return Card(
      child: InkWell(
        onTap: ()
        {
          print("samikshya");
          setState(() {
            visibility = !visibility;
          });
        }
        ,
        // => Navigator.of(context).push(MaterialPageRoute(
        //   //  here we are passing the value of the product to product details page
        //     builder: (context) => AdminOrderDetails(
        //       productId: widget.orderProduct.productId,
        //       productName:widget.orderProduct.productName,
        //       productPrice: widget.orderProduct.productPrice,
        //       orderAddress: widget.orderProduct.address,
        //       buyer: widget.orderProduct.buyer,
        //       condition: widget.orderProduct.productCondition,
        //       usedfor: widget.orderProduct.usedFor,
        //       category: widget.orderProduct.category,
        //       productImages: widget.orderProduct.productImages,
        //       details: widget.orderProduct.description,
        //       seller: widget.orderProduct.seller,
        //       orderId: widget.orderProduct.orderId,
        //
        //     ))),
        child: ExpansionTile(

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
               ),
        ]
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
          ]

          ),
        ),

    );
  }

  dispatchOrder() async {
    onLoading(context);
    bool isAdded = await Provider.of<AllOrderProvider>(context, listen: false)
        .disptachedOrder(widget.orderProduct.orderId);
    Navigator.pop(context);
    if (isAdded) {
      Toast.show("Order Dispatched", context);
    } else {
      Toast.show("Something is wrong.", context);
    }
  }
}
