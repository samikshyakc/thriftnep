import 'package:flutter/material.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/components/cart_products.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
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
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {}),
          ],
        ),
        body: CartProducts(),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                  child: ListTile(
                title: Text('Total:'),
                subtitle: Text("\$240"),
              )),
              Expanded(
                child: MaterialButton(
                  onPressed: () {},
                  child: Text(
                    "Check Out",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
