import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thrift_nep/components/cart/cart.dart';
import 'package:thrift_nep/components/product/product.dart';
import 'package:thrift_nep/components/product/product_details.dart';
import 'package:thrift_nep/constants/colors.dart';


class CartWidget extends StatelessWidget {
final Cart cartProduct;



CartWidget(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      => Navigator.of(context).push(MaterialPageRoute(
        //  here we are passing the value of the product to product details page
          builder: (context) => ProductDetails(
            productId: cartProduct.productId,
            productName:cartProduct.productName,
            productPrice: cartProduct.productPrice,
            // negotiable: product.negotiable,
            condition: cartProduct.productCondition,
            usedfor: cartProduct.usedFor,
            category: cartProduct.category,
            productImages: cartProduct.productImages,
            details: cartProduct.description,
            seller: cartProduct.seller,

          ))),
      child: Card(
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
                  Text("Used for:"),
                  Text(
                    cartProduct.usedFor,
                    style: TextStyle(color: kAppbar),
                  ),

                ],

              ),

              //          ======Section for product price=====
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
      ),
    );
  }
}
