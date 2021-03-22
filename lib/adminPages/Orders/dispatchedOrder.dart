import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/adminPages/Orders/adminOrder_widget.dart';
import 'package:thrift_nep/adminPages/Orders/dispatchOrderWidget.dart';
import 'package:thrift_nep/components/order/orders.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/provider/allOrderProvider.dart';
import 'package:thrift_nep/provider/dispatchedOrderProvider.dart';
import 'package:thrift_nep/provider/orderProvider.dart';

class DispatchedOrder extends StatefulWidget {
  @override
  _DispatchedOrderState createState() => _DispatchedOrderState();
}

class _DispatchedOrderState extends State<DispatchedOrder> {
  List<Order> orderList = [];
  int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    orderList =
        Provider.of<DisptachOrderProvider>(context, listen: false).dispatchOrder;
    //  totalPrice = Provider.of<AllOrderProvider>(context, listen: false).totalPrice;
    //  print(totalPrice);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          //automaticallyImplyLeading: false,
          title: Text(
            'Dispatched Orders',
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
                return DispatchOrderWidget(orderList[index]);
              }),
        ),

      ),
    );
  }
}
