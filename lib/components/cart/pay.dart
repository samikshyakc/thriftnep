import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/components/product/product.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/constants/urls.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_khalti/flutter_khalti.dart';
import 'package:thrift_nep/provider/emaiProvider.dart';
import 'package:thrift_nep/widgets/customTextField.dart';
import 'package:thrift_nep/widgets/loading_indicator.dart';

class Pay extends StatefulWidget {
  final productPrice;
  final productName;
  final seller;
  final productId;

  Pay({this.productPrice, this.productName, this.seller, this.productId});

  @override
  _PayState createState() => _PayState();
}

class _PayState extends State<Pay> {
  //List<Cart> cartproductList = [];
  final _globalKeyScaffold = GlobalKey<ScaffoldState>();
  int totalPrice = 0;
  Product product;
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var price = widget.productPrice;

    totalPrice = int.parse(price);

    print(totalPrice);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          //automaticallyImplyLeading: false,
          title: Text(
            'Select Payment Method',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: kAppbar,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: ListTile(
                  tileColor: kAppbar,
                  title: Text('Khalti Digital Wallet',style: TextStyle(color: Colors.white),),
                 onTap: (){
                   showDialog(
                       context: context,
                       builder: (context) {
                         return AlertDialog(
                           // title: Text("Are you sure?"),
                           //content: Text('Logout?'),
                           title: Text(
                               'Total: $totalPrice \n Enter your delivery address'),

                           content: TextField(
                             // hint: 'Delivery Address',
                             // validator: validateEmail,
                             controller: addressController,
                             textInputAction: TextInputAction.done,
                             keyboardType: TextInputType.text,
                             // issecured: false,
                           ),
                           actions: [
                             FlatButton(
                               onPressed: () async {
                                 onLoading(context);
                                 openKhalti();
                                 Navigator.pop(context);
                                 // Navigator.pushNamedAndRemoveUntil(
                                 //     context, 'confirmOrder', (route) => false);
                               },
                               child: Text('Confirm'),
                             ),
                             FlatButton(
                                 onPressed: () {
                                   Navigator.pop(context);
                                 },
                                 child: Text('NO')),
                           ],
                         );
                       });
                 } ,
                 // subtitle: Text(widget.product.description),
                  // subtitle: Text(
                  // 'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: ListTile(
                  tileColor: kAppbar,
                  title: Text('Cash On Delivery',style: TextStyle(color: Colors.white),),
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            // title: Text("Are you sure?"),
                            //content: Text('Logout?'),
                            title: Text(
                                'Total: $totalPrice \n Enter your delivery address'),

                            content: CustomTextField(
                              hint: 'Delivery Address',
                              // validator: validateEmail,
                              controller: addressController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              issecured: false,
                            ),
                            actions: [
                              FlatButton(
                                onPressed: () async {
                                  onLoading(context);
                                  cashOnDelivery('COD');
                                  Navigator.pop(context);
                                  // Navigator.pushNamedAndRemoveUntil(
                                  //     context, 'confirmOrder', (route) => false);
                                },
                                child: Text('Confirm'),
                              ),
                              FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('NO')),
                            ],
                          );
                        });
                  },
                  // subtitle: Text(widget.product.description),
                  // subtitle: Text(
                  // 'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.'),
                ),
              ),
            ),
            // RaisedButton(
            //     child: Text("Khalti Digital Wallet"),
            //     color: kAppbar,
            //     textColor: Colors.white,
            //     onPressed: () {
            //       showDialog(
            //           context: context,
            //           builder: (context) {
            //             return AlertDialog(
            //               // title: Text("Are you sure?"),
            //               //content: Text('Logout?'),
            //               title: Text(
            //                   'Total: $totalPrice \n Enter your delivery address'),
            //
            //               content: TextField(
            //                 // hint: 'Delivery Address',
            //                 // validator: validateEmail,
            //                 controller: addressController,
            //                 textInputAction: TextInputAction.done,
            //                 keyboardType: TextInputType.text,
            //                 // issecured: false,
            //               ),
            //               actions: [
            //                 FlatButton(
            //                   onPressed: () async {
            //                     onLoading(context);
            //                     openKhalti();
            //                     Navigator.pop(context);
            //                     // Navigator.pushNamedAndRemoveUntil(
            //                     //     context, 'confirmOrder', (route) => false);
            //                   },
            //                   child: Text('Confirm'),
            //                 ),
            //                 FlatButton(
            //                     onPressed: () {
            //                       Navigator.pop(context);
            //                     },
            //                     child: Text('NO')),
            //               ],
            //             );
            //           });
            //     },
            //     shape: RoundedRectangleBorder(
            //         borderRadius: new BorderRadius.circular(30.0))),
            // RaisedButton(
            //     child: Text("Cash On Delivery"),
            //     color: kAppbar,
            //     textColor: Colors.white24,
            //     // onPressed: (){
            //     // //  cashOnDelivery('COD');
            //     //  // openKhalti();
            //     // },
            //     onPressed: () {
            //       showDialog(
            //           context: context,
            //           builder: (context) {
            //             return AlertDialog(
            //               // title: Text("Are you sure?"),
            //               //content: Text('Logout?'),
            //               title: Text(
            //                   'Total: $totalPrice \n Enter your delivery address'),
            //
            //               content: CustomTextField(
            //                 hint: 'Delivery Address',
            //                 // validator: validateEmail,
            //                 controller: addressController,
            //                 textInputAction: TextInputAction.done,
            //                 keyboardType: TextInputType.text,
            //                 issecured: false,
            //               ),
            //               actions: [
            //                 FlatButton(
            //                   onPressed: () async {
            //                     onLoading(context);
            //                     cashOnDelivery('COD');
            //                     Navigator.pop(context);
            //                     // Navigator.pushNamedAndRemoveUntil(
            //                     //     context, 'confirmOrder', (route) => false);
            //                   },
            //                   child: Text('Confirm'),
            //                 ),
            //                 FlatButton(
            //                     onPressed: () {
            //                       Navigator.pop(context);
            //                     },
            //                     child: Text('NO')),
            //               ],
            //             );
            //           });
            //     },
            //     shape: RoundedRectangleBorder(
            //         borderRadius: new BorderRadius.circular(30.0)))

            //  Text('Total Price $totalPrice', style: TextStyle(color: Colors.black, fontSize: 20),),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                  child: ListTile(
                title: Text("Order Summary"),
              )),
              Expanded(
                  child: ListTile(
                title: Text("Total:"),
                subtitle: Text(
                  'Rs$totalPrice',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              )),
              Expanded(child: MaterialButton(
                onPressed: () {
                  //   Navigator.pushReplacementNamed(context, 'home');
                },
                // child: Text('Proceed to Payment', style: TextStyle(color: Colors.white),),
                // color:kAppbar,
              ))
            ],
          ),
        ),
      ),
    );
  }

  void openKhalti() {
    print(totalPrice);
    double amount = totalPrice * 100.0;
    print(amount);

    FlutterKhalti _flutterKhalti = FlutterKhalti.configure(
      publicKey: "test_public_key_74632bdc86404be18c060752730cfede",
      urlSchemeIOS: "KhaltiPayFlutterExampleScheme",
    );

    KhaltiProduct product = KhaltiProduct(
      id: "test",
      amount: amount,
      name: "Hello Product",
    );

    _flutterKhalti.startPayment(
      product: product,
      onSuccess: (data) {
        print(data);
        print("Success message here");
        cashOnDelivery('Khalti');
        // sendBookingData();
      },
      onFaliure: (error) {
        print("Error message here");
      },
    );
  }

  void cashOnDelivery(String paymentMethod) async {
    var address = addressController.text;
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    String buyer = Provider.of<EmailProvider>(context, listen: false).email();
    // print("address: $address");
    // print("address: $paymentMethod");
    // print("address: $buyer");
    // print("address: $formattedDate");
    // print("address: ${widget.productId}");

    onLoading(context);
    var url =
        '$ORDER_URL?product_id=${widget.productId}&payment_method=$paymentMethod&buyer=$buyer&address=$address&date=$formattedDate';
    var response = await http.get(url);
    //  var url = '$ORDER_URL?productId=${cart.productId}&payment_method=$paymentMethod&buyer=$buyer&address=$address&date=$formattedDate';
    Navigator.pop(context);
    //print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.body.contains("order added")) {
      var url = '$DELETE_URL?product_id=${widget.productId}';
      var response = await http.get(url);
      Navigator.pop(context);
      print('Response body: ${response.body}');
      if (response.body.contains("deleted")) {
        Navigator.pushReplacementNamed(context, 'home');
      } else {
        _showSnackBar('Failed');
      }
    } else {
      print('failed!');
    }
  }

  void _showSnackBar(String message) {
    final _snackBar = SnackBar(content: Text(message));
    _globalKeyScaffold.currentState.showSnackBar(_snackBar);
  }
}
