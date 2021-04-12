import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/components/cart/cart.dart';
import 'package:thrift_nep/components/cart/cart_screen.dart';
import 'package:thrift_nep/components/product/product_details.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/provider/cart_provider.dart';
import 'package:thrift_nep/widgets/loading_indicator.dart';
import 'package:toast/toast.dart';


class CartWidget extends StatefulWidget {
final Cart cartProduct;



CartWidget(this.cartProduct);

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final _globalKeyScaffold = GlobalKey<ScaffoldState>();

  // void initState() {
  //
  //   super.initState();
  //
  //
  // }
  @override

  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      => Navigator.of(context).push(MaterialPageRoute(
        //  here we are passing the value of the product to product details page
          builder: (context) => ProductDetails(
            productId: widget.cartProduct.productId,
            productName:widget.cartProduct.productName,
            productPrice: widget.cartProduct.productPrice,
            condition: widget.cartProduct.productCondition,
            usedfor: widget.cartProduct.usedFor,
            category: widget.cartProduct.category,
            productImages: widget.cartProduct.productImages,
            details: widget.cartProduct.description,
            seller: widget.cartProduct.seller,

          ))),
      child: Card(
        child: Slidable(
       //   delegate: new SlidableDrawerDelegate(),
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          secondaryActions: <Widget>[
            new IconSlideAction(
              caption: 'More',
              color: Colors.black45,
              icon: Icons.more_horiz,
              onTap: () {},
            ),
            new IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {
                deleteCart();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => CartProducts()));

              },
            ),
          ],
          child: ListTile(
            leading: Image(
              image: CachedNetworkImageProvider(widget.cartProduct.productImages),
              width: 50.0,
              height: 100.0,
            ),
            title: Text(widget.cartProduct.productName),
            subtitle: Column(
              children: [
                Row(
                  children: [
                    //       ===product size section==
                    Text("Condition:"),
                    Text(
                      widget.cartProduct.productCondition,
                      style: TextStyle(color: kAppbar),
                    ),
                    Padding(padding: const EdgeInsets.only(left: 20),),
                    //===product color section==
                    Text("Used for:"),
                    Text(
                      widget.cartProduct.usedFor,
                      style: TextStyle(color: kAppbar),
                    ),

                  ],

                ),

                //          ======Section for product price=====
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Rs ${widget.cartProduct.productPrice}",
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
      ),
    );
  }

  deleteCart() async{
    onLoading(context);
    bool isCanceled = await Provider.of<CartProvider>(context, listen: false)
        .deleteFromCart(widget.cartProduct.cartId,
        widget.cartProduct);
    Navigator.pop(context);
    if (isCanceled) {
      Toast.show("Removed from Cart.", context);
    } else {
      Toast.show("Something is wrong.", context);
    }
    Navigator.pop(context);
  }


// void deleteCart() async {
//   String cartID = widget.cartProduct.cartId;
//   print("cart id = $cartID");
//   onLoading(context);
//   var url = '$DELETECART_URL?cart_id=$cartID';
//   var response = await http.get(url);
//
//   //print('Response status: ${response.statusCode}');
//   print('Response body: ${response.body}');
//   if (response.body.contains("Removed succesfully.")) {
//     Navigator.pop(context);
//  //  Provider.of<CartProvider>(context, listen: false).fetchCart(email);
//   //  Navigator.pushReplacementNamed(context, 'home');
//   } else {
//     Navigator.pop(context);
//     print('Failed');
//   }
// }
  void _showSnackBar(String message) {
    final _snackBar = SnackBar(content: Text(message));
    _globalKeyScaffold.currentState.showSnackBar(_snackBar);
  }

}

