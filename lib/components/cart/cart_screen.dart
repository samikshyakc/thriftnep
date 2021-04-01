import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/components/cart/cart.dart';
import 'package:thrift_nep/components/cart/cart_widget.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/provider/cart_provider.dart';

class CartProducts extends StatefulWidget {
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  List<Cart> cartproductList = [];
  int totalPrice = 0;

  @override
  // void initState() {
  //  // Provider.of<CartProvider>(context, listen: false).fetchCart(email);
  //   cartproductList =
  //       Provider.of<CartProvider>(context, listen: false).allCart;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    cartproductList =
        Provider.of<CartProvider>(context, listen: false).allCart;
    totalPrice = Provider.of<CartProvider>(context, listen: false).totalPrice;
    print(totalPrice);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          //automaticallyImplyLeading: false,
          title: Text(
            'My Cart',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: kAppbar,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [],
        ),
        body: SingleChildScrollView(
          //crossAxisAlignment: CrossAxisAlignment.start,

          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: cartproductList.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return CartWidget(cartproductList[index]);
              }),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Row(
            children: [
              Expanded(child: ListTile(
                title:Text("Total:"),
                subtitle:Text('Rs$totalPrice', style: TextStyle(color: Colors.black, fontSize: 20),),
              )),
              Expanded(child: MaterialButton(
                onPressed: (){
                  Navigator.pushReplacementNamed(context, 'checkout');
                },
                child: Text('Checkout', style: TextStyle(color: Colors.white),),
                color:kAppbar,
              ))

            ],
          ),
        ),
      ),
    );
  }
}
