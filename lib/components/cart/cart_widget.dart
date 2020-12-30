import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/flutter_project/thrift_nep/lib/components/cart/cart.dart';
import 'package:thrift_nep/constants/colors.dart';


class CartWidget extends StatelessWidget {
final Cart cartProduct;


CartWidget(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image(
          image: CachedNetworkImageProvider(cartProduct.productImages),
          width: 50.0,
          height: 100.0,
        ),
        title: Text(cartProduct.productName),
        subtitle: Column(
          children: [
            Row(
              children: [
                //       ===product size section==
                Text("Condition:"),
                Text(
                  cartProduct.productCondition,
                  style: TextStyle(color: kAppbar),
                ),
                Padding(padding: const EdgeInsets.only(left: 20),),
                //===product color section==
                Text("Negotiable:"),
                Text(
                  cartProduct.negotiable,
                  style: TextStyle(color: kAppbar),
                ),

              ],

            ),

            //          ======Section for product price=====
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "\$ ${cartProduct.price}",
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
