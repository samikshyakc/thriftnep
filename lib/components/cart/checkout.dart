import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/components/cart/cart_widget.dart';
import 'file:///C:/flutter_project/thrift_nep/lib/components/cart/cart.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/provider/cart_provider.dart';
import 'package:thrift_nep/widgets/checkout_widget.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
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
            'CheckOut',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: kAppbar,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [],
        ),
        body:SingleChildScrollView(
          //crossAxisAlignment: CrossAxisAlignment.start,

          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: cartproductList.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return CheckOutWidget(cartproductList[index]);
              }),
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
                onPressed: (){
                  Navigator.pushReplacementNamed(context, 'payment');
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
