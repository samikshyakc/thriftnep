import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thrift_nep/adminPages/Orders/adminOrderDetails.dart';
import 'package:thrift_nep/components/order/orders.dart';
import 'package:thrift_nep/constants/colors.dart';


class AdminOrderWidget extends StatelessWidget {
  final Order orderProduct;


  AdminOrderWidget(this.orderProduct);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: ()
        => Navigator.of(context).push(MaterialPageRoute(
          //  here we are passing the value of the product to product details page
            builder: (context) => AdminOrderDetails(
              productId: orderProduct.productId,
              productName:orderProduct.productName,
              productPrice: orderProduct.productPrice,
              orderAddress: orderProduct.address,
              buyer: orderProduct.buyer,
              condition: orderProduct.productCondition,
              usedfor: orderProduct.usedFor,
              category: orderProduct.category,
              productImages: orderProduct.productImages,
              details: orderProduct.description,
              seller: orderProduct.seller,
              orderId: orderProduct.orderId,

            ))),
        child: ListTile(
          leading: Image(
            image: CachedNetworkImageProvider(orderProduct.productImages),
            width: 50.0,
            height: 100.0,
          ),
          title: Text(orderProduct.productName),
          subtitle: Column(
            children: [
              Row(
                children: [
                  //       ===product size section==
                  Text("Ordered Date:"),
                  Text(
                    orderProduct.date,
                    style: TextStyle(color: kAppbar),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 20),),

                ],

              ),

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
      ),
    );
  }
}
