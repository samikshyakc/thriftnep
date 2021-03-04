import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thrift_nep/components/cart/cart.dart';
import 'package:thrift_nep/constants/colors.dart';


class CheckOutWidget extends StatelessWidget {
  final Cart cartProduct;


  CheckOutWidget(this.cartProduct);

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
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "Rs ${cartProduct.productPrice}",
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
