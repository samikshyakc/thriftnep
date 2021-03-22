import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:thrift_nep/adminPages/ProductVerification/verifyproddetails.dart';
import 'package:thrift_nep/components/product/product.dart';

class VerifyProdWidget extends StatelessWidget {

  const VerifyProdWidget({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;
  @override
  Widget build(BuildContext context) {
    return Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: ()
            => Navigator.of(context).push(MaterialPageRoute(
              //  here we are passing the value of the product to product details page
                builder: (context) => AdminProductDetails(
                  productId: product.productId,
                  productName:product.productName,
                  productPrice: product.productPrice,
                  condition: product.productCondition,
                  usedfor: product.usedFor,
                  category: product.category,
                  productImages: product.productImages,
                  details: product.description,
                  seller: product.seller,

                ))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Ink.image(image: CachedNetworkImageProvider(product.productImages),
                      height: 200,
                       fit: BoxFit.fitWidth ,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(product.productName),
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('TShirt', style: TextStyle(color: Colors.black54),),
                      Text(product.productCondition),
                      Text(product.description),
                    ],
                  ),
                ),
                ButtonBar()
              ],
            ),
          ),
        );

  }
}
