import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thrift_nep/components/product/product.dart';
import 'package:thrift_nep/components/product/product_details.dart';


class ProductWidget extends StatelessWidget {
  const ProductWidget({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: Text('Hero 1'),
          child: Material(
            child: InkWell(
              onTap: ()
               => Navigator.of(context).push(MaterialPageRoute(
              //  here we are passing the value of the product to product details page
                  builder: (context) => ProductDetails(

                    productName:product.productName,
                    productPrice: product.productPrice,
                    negotiable: product.negotiable,
                    condition: product.productCondition,
                    usedfor: product.usedFor,
                    category: product.category,
                    productImages: product.productImages,
                    details: product.description,
                    seller: product.seller,

                  ))),
              child: GridTile(
                  footer: Container(
                    color: Colors.white24,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            product.productName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                        ),
                        Text(
                          "Rs${product.productPrice}",
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    ),
                  ),

                 child: Image(image: CachedNetworkImageProvider(product.productImages),fit:BoxFit.fill,),
              ),
            ),
          )),
    );
  }
}
