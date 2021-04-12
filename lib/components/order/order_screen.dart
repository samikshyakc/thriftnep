import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/components/order/order_widget.dart';
import 'package:thrift_nep/components/order/orders.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/constants/urls.dart';
import 'package:thrift_nep/provider/emaiProvider.dart';
import 'package:thrift_nep/provider/orderProvider.dart';

class OrderProducts extends StatefulWidget {
  @override
  _OrderProductsState createState() => _OrderProductsState();
}

class _OrderProductsState extends State<OrderProducts> {
  List<Order> orderList = [];
  int totalPrice = 0;
  bool isLoading = true;
  Future<void> fetchOrder(String user) async {
    orderList = [];
    var url = '$FETCHORDER_URL?user=$user';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print('order list: $result');
      result.forEach((p) {
        var order = Order.fromJson(p);
        //  print(order.proid);
        totalPrice += int.parse(order.productPrice);
        orderList.add(order);
      });
      setState(() {
        isLoading =false;
      });
    }
  }
  @override
  void initState(){
    String id = Provider.of<EmailProvider>(context, listen: false).email();
    print("Email email email is $id");
    fetchOrder(id);
    super.initState();
  }

  Widget build(BuildContext context) {
    // orderList =
    //     Provider.of<OrderProvider>(context, listen: false).allOrder;
    // totalPrice = Provider.of<OrderProvider>(context, listen: false).totalPrice;
    // print(totalPrice);

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

          child:(!isLoading) ?ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: orderList.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return OrderWidget(orderList[index]);
              }): Center(child: CircularProgressIndicator(),),
        ),

      ),
    );
  }
}
