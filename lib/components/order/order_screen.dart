import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/components/cart/cart.dart';
import 'package:thrift_nep/components/cart/cart_widget.dart';
import 'package:thrift_nep/components/order/order_widget.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/provider/cart_provider.dart';
import 'package:thrift_nep/provider/orderProvider.dart';

class OrderProducts extends StatefulWidget {
  @override
  _OrderProductsState createState() => _OrderProductsState();
}

class _OrderProductsState extends State<OrderProducts> {
  List<Cart> orderList = [];
  int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    orderList =
        Provider.of<OrderProvider>(context, listen: false).allProduct;
    totalPrice = Provider.of<OrderProvider>(context, listen: false).totalPrice;
    print(totalPrice);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          //automaticallyImplyLeading: false,
          title: Text(
            'My Orders',
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
              itemCount: orderList.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return OrderWidget(orderList[index]);
              }),
        ),
        // bottomNavigationBar: Container(
        //   color: Colors.white,
        //   child: Row(
        //     children: [
        //       Expanded(child: ListTile(
        //         title:Text("Total:"),
        //         subtitle:Text('\$$totalPrice', style: TextStyle(color: Colors.black, fontSize: 20),),
        //       )),
        //       Expanded(child: MaterialButton(
        //         onPressed: (){
        //           Navigator.pushReplacementNamed(context, 'checkout');
        //         },
        //         child: Text('Checkout', style: TextStyle(color: Colors.white),),
        //         color:kAppbar,
        //       ))
        //
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
