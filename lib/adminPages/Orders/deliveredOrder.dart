import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/adminPages/Orders/adminOrder_widget.dart';
import 'package:thrift_nep/components/order/orders.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/constants/urls.dart';
import 'package:thrift_nep/provider/DeliveredOrderProvider.dart';
import 'package:http/http.dart' as http;

class DeliveredOrder extends StatefulWidget {
  @override
  _DeliveredOrderState createState() => _DeliveredOrderState();
}

class _DeliveredOrderState extends State<DeliveredOrder> {
  List<Order> orderList = [];
  bool isLoading = true;

  Future<void> fetchDeliveredOrder() async {
    orderList = [];
    var url = '$FETCHDELIVEREDORDER_URL';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      result.forEach((p) {
        var order = Order.fromJson(p);
        //  print(order.proid);
        // totalPrice += int.parse(order.productPrice);
        orderList.add(order);
      });
    }
    setState(() {
      isLoading = false;
    });
  }
 // int totalPrice = 0;

  @override
  void initState(){
    fetchDeliveredOrder();
    super.initState();
  }
  Widget build(BuildContext context) {
    // orderList =
    //     Provider.of<DeliveredOrderProvider>(context, listen: false).deliveredOrder;
    //
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

          child:(!isLoading) ? ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: orderList.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return AdminOrderWidget(orderList[index]);
              }): Center(child: CircularProgressIndicator()) ,
        ),

      ),
    );
  }
}
