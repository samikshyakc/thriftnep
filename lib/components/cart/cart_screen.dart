import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/components/cart/cart_widget.dart';
import 'file:///C:/flutter_project/thrift_nep/lib/components/cart/cart.dart';
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
  Widget build(BuildContext context) {
    cartproductList =
        Provider.of<CartProvider>(context, listen: false).allProduct;
    totalPrice = Provider.of<CartProvider>(context, listen: false).totalPrice;
    print(totalPrice);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          //automaticallyImplyLeading: false,
          title: Text(
            'Thrift Nep',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: kAppbar,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView.builder(
                  itemCount: cartproductList.length,
                  shrinkWrap: true,
                  // scrollDirection: Axis.vertical,
                  //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return CartWidget(cartproductList[index]);
                  }),
            ),
          //  Text('Total Price $totalPrice', style: TextStyle(color: Colors.black, fontSize: 20),),

          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Row(
            children: [
              Expanded(child: ListTile(
                title:Text("Total:"),
                subtitle:Text('\$$totalPrice', style: TextStyle(color: Colors.black, fontSize: 20),),
              )),
              Expanded(child: MaterialButton(
                onPressed: (){},
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
