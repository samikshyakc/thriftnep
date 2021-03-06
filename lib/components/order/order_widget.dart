import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thrift_nep/components/order/orders.dart';
import 'package:thrift_nep/constants/colors.dart';


class OrderWidget extends StatelessWidget {
  final Order orderProduct;


  OrderWidget(this.orderProduct);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        // leading: Image(
        //   image: CachedNetworkImageProvider(orderProduct.productImages),
        //   width: 50.0,
        //   height: 100.0,
        // ),
        title: Text(orderProduct.productName),
        subtitle: Column(
          children: [
            // Row(
            //   children: [
            //     //       ===product size section==
            //     Text("Condition:"),
            //     Text(
            //       orderProduct.productCondition,
            //       style: TextStyle(color: kAppbar),
            //     ),
            //     Padding(padding: const EdgeInsets.only(left: 20),),
            //     //===product color section==
            //     Text("Negotiable:"),
            //     Text(
            //       orderProduct.negotiable,
            //       style: TextStyle(color: kAppbar),
            //     ),
            //
            //   ],
            //
            // ),

            //          ======Section for product price=====
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "Rs ${orderProduct.productPrice}",
                style: TextStyle(
                    fontSize: 17.0,
                    color: kAppbar,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
