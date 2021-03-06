import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_khalti/flutter_khalti.dart';
import 'package:thrift_nep/components/cart/pay.dart';
import 'package:thrift_nep/components/product/product.dart';
import 'package:thrift_nep/constants/colors.dart';


class BuyNow extends StatefulWidget {
  final productId;
  final productName;
  final productPrice;
  final productImages;
  final seller;

  BuyNow(
  {
    this.productId,
    this.productName,
    this.productPrice,
    this.productImages,
    this.seller
}
      );
  @override
  _BuyNowState createState() => _BuyNowState();
}

class _BuyNowState extends State<BuyNow> {
  //List<Cart> cartproductList = [];
  //int totalPrice = 0;
  @override
  Widget build(BuildContext context) {
    // cartproductList =
    //     Provider.of<CartProvider>(context, listen: false).allProduct;
//    totalPrice = int.parse(prod;
  //  print(totalPrice);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          //automaticallyImplyLeading: false,
          title: Text(
            'CheckOut',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: kAppbar,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [],
        ),
        body: Card(
          child: ListTile(
            leading: Image(
              image: CachedNetworkImageProvider(widget.productImages),
              width: 50.0,
              height: 100.0,
            ),
            title: Text(widget.productName),
            subtitle: Column(
              children: [
      //   ======Section for product price=====
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Rs ${widget.productPrice}",
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


        bottomNavigationBar: Container(
          color: Colors.white,
          child: Row(
            children: [
              Expanded(child: ListTile(
                title:Text("Total:"),
                subtitle:Text("Rs${widget.productPrice}", style: TextStyle(color: Colors.black, fontSize: 20),),
              )),
              Expanded(child: MaterialButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Pay(
                        productId: widget.productId,
                        productPrice:widget.productPrice,
                        productName: widget.productName,
                       seller: widget.seller,
                       // seller: widget.,

                      )
                  ));
                },
                child: Text('Proceed to Payment', style: TextStyle(color: Colors.white),),
                color:kAppbar,
              ))
            ],
          ),
        ),
      ),
    );
  }


}
