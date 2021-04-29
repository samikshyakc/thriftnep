import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/components/order/order_widget.dart';
import 'package:thrift_nep/components/order/orders.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/constants/urls.dart';
import 'package:thrift_nep/provider/emaiProvider.dart';

class OrderHistoryScreen extends StatefulWidget {
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {

  List prodList = [];
  bool isLoading = true;
  var now = new DateTime.now();

  var toDate;

  var fromDate;

  var formatter = new DateFormat('yyyy-MM-dd');
  var fromDateController = TextEditingController();
  var toDateController = TextEditingController();
  List<Order> orderList = [];
  int totalPrice = 0;
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


  // void initState() {
  //   super.initState();
  //   fromDateController.text = fromDate;
  //   toDateController.text = toDate;
  //
  //  // fetchProduct(widget.searchText);
  //
  // }
  Widget build(BuildContext context) {
    String checkinDate = formatter.format(now);
    fromDate = now.subtract(Duration(days: 30));

    toDate = DateTime.now();
    //String fromdatee = formatter.format(fromDate);
    String fromdatee = "2021-04-09";
   // String uptoDate = formatter.format(toDate);
    String uptoDate = "2021-04-15";
    fromDateController = TextEditingController(text: "$fromdatee");
    toDateController = TextEditingController(text: "$uptoDate");

    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        //automaticallyImplyLeading: false,
        title: Text(
          'Order history',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kAppbar,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [],
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 8.0, 0.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("From"),
                      Padding(padding: EdgeInsets.all(5.0)),
                      SizedBox(
                          width: 156,
                          child: InkWell(
                            child: TextField(
                              enabled: false,
                              controller: fromDateController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon:
                                    Icon(Icons.calendar_today_outlined, size: 20),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(15.0)),
                              ),
                            ),
                            onTap: () async {
                              var date = await showDatePicker(
                                  context: context,
                                  initialDate: fromDate,
                                  firstDate: DateTime(2015),
                                  lastDate: DateTime(2100));
                                 // fromDate = date;


                                fromDateController.text =
                                    date.toString().substring(0, 10);

                              print("from date = ${fromDateController.text}");

                              // toDateController.text = fromDate
                              //     .add(Duration(days: 1))
                              //     .toString()
                              //     .substring(0, 10);
                            },
                          )),
                    ],
                  ),
                ),
                //  Padding(padding: EdgeInsets.all(2.0)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 2.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(" To"),
                      Padding(padding: EdgeInsets.all(5.0)),
                      SizedBox(
                          width: 158,
                          child: InkWell(
                            child: TextField(
                              enabled: false,
                              controller: toDateController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon: Icon(
                                  Icons.calendar_today_outlined,
                                  size: 20,
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(15.0)),
                              ),
                            ),
                            onTap: () async {
                              var date = await showDatePicker(
                                  context: context,
                                  initialDate:toDate,
                                  firstDate: DateTime(2015),
                                  lastDate: DateTime.now());
                                  print(date);

                                toDateController.text =
                                    date.toString().substring(0, 10);

                              print("from date = ${toDateController.text}");

                            },
                          )),
                    ],
                  ),
                ),

              ],
            ),
            SingleChildScrollView(
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

          ],
        ),
      ),
    );
  }
  Widget SearchedItems(int i, BuildContext context) {
    return
      prodList == null
          ? Text('No Data Available'):
      Card(
        elevation: 19,
        child: ListTile(
          title: Text("ProductName : " +
              prodList[i]['product_name'] +
              " " +
              "\n Price" +
              prodList[i]['product_price']),
        ),
      );
  }
}
