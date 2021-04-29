import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/components/product/product.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/provider/productToVerify.dart';
import 'package:thrift_nep/widgets/loading_indicator.dart';
import 'package:toast/toast.dart';

class VerifyProdWidget extends StatefulWidget {

  const VerifyProdWidget({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _VerifyProdWidgetState createState() => _VerifyProdWidgetState();
}

class _VerifyProdWidgetState extends State<VerifyProdWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(

        leading: Image(
          image: CachedNetworkImageProvider(widget.product.productImages),
          width: 50.0,
          height: 100.0,
        ),
        title: Text(widget.product.productName),
        subtitle: Column(
            children: [
              Row(
                children: [
                  //       ===product size section==
                  Text("Product Condition:"),
                  Text(
                    widget.product.productCondition,
                    style: TextStyle(color: kAppbar),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 20),),

                ],

              ),

              //          ======Section for product price=====
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Rs ${widget.product.productPrice}",
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
            subtitle: Text(widget.product.description, textAlign: TextAlign.justify,),
            // subtitle: Text(
            // 'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.'),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  "Product Name",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(widget.product.productName),
              )
            ],
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
                child: Text(widget.product.usedFor),
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
                child: Text(widget.product.productCondition),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  "Product Category",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(widget.product.category),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  "Product Seller",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(widget.product.seller),
              )
            ],
          ),
          Row(

            children: [
              ElevatedButton(
                child: Text('Approve', style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  primary: kAppbar,
                ),
                //icon: Icon(Icons.pic),
                onPressed: () {
                  approveProd();
                  //  Navigator.pushReplacementNamed(context, 'verify');
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              ElevatedButton(
                child: Text('Disapprove', style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  primary: kAppbar,
                ),
                //icon: Icon(Icons.pic),
                onPressed: () {
                  declineProd();
                  //   Navigator.pushReplacementNamed(context, 'verify');
                },
              ),
            ],
          )
        ]

    );

  }
  approveProd() async {
    onLoading(context);
    bool isAdded = await Provider.of<VerifyProductProvider>(context, listen: false)
        .approvePRoduct(widget.product.productId, widget.product);
    Navigator.pop(context);
    if (isAdded) {
      Toast.show("Product Approved", context);
    } else {
      Toast.show("Something is wrong.", context);
    }
  }
  declineProd() async {
    onLoading(context);
    bool isDeclined = await Provider.of<VerifyProductProvider>(context, listen: false)
        .declineProd(widget.product.productId, widget.product);
    Navigator.pop(context);
    if (isDeclined) {
      Toast.show("Product Declined", context);
    } else {
      Toast.show("Something is wrong.", context);
    }
  }
}