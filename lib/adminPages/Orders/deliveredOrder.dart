import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/adminPages/Orders/adminOrder_widget.dart';
import 'package:thrift_nep/components/order/orders.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/provider/DeliveredOrderProvider.dart';


class DeliveredOrder extends StatefulWidget {
  @override
  _DeliveredOrderState createState() => _DeliveredOrderState();
}

class _DeliveredOrderState extends State<DeliveredOrder> {
  List<Order> orderList = [];
 // int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    orderList =
        Provider.of<DeliveredOrderProvider>(context, listen: false).deliveredOrder;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          //automaticallyImplyLeading: false,
          title: Text(
            'Delivered Orders',
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
                return AdminOrderWidget(orderList[index]);
              }),
        ),

      ),
    );
  }
}
