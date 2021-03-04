import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:thrift_nep/components/cart/cart.dart';
import 'package:thrift_nep/components/product/product.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/constants/urls.dart';
import 'package:thrift_nep/provider/cart_provider.dart';
import 'package:flutter_khalti/flutter_khalti.dart';
import 'package:thrift_nep/widgets/customTextField.dart';
import 'package:thrift_nep/widgets/loading_indicator.dart';


class Payment extends StatefulWidget {

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final _globalKeyScaffold = GlobalKey<ScaffoldState>();

  Product product;
  int totalPrice = 0;

  final addressController = TextEditingController();

  List<Cart> cartproductList = [];


  @override
  Widget build(BuildContext context) {
    cartproductList = Provider.of<CartProvider>(context, listen: false).allProduct;
    totalPrice = Provider.of<CartProvider>(context, listen: false).totalPrice;
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
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            RaisedButton(
                child: Text("Khalti Digital Wallet"),
                color: kAppbar,
                textColor: Colors.white24,
                onPressed: (){
                  openKhalti();
                },
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
            ),
            RaisedButton(
                child: Text("Cash On Delivery"),
                color: kAppbar,
                textColor: Colors.white24,
                // onPressed: (){
                //  // openKhalti();
                //   sendOrder("COD");
                // },
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          // title: Text("Are you sure?"),
                          //content: Text('Logout?'),
                          title: Text('Total: $totalPrice \n Enter your delivery address'),

                          content:  CustomTextField(
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
                                sendOrder('COD');
                                Navigator.pop(context);
                                Navigator.pushNamedAndRemoveUntil(
                                    context, 'confirmOrder', (route) => false);
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
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
            )

            //  Text('Total Price $totalPrice', style: TextStyle(color: Colors.black, fontSize: 20),),

          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Row(
            children: [
              Expanded(child: ListTile(
                title:Text("Order Summary"),
              )),
              Expanded(child: ListTile(
                title:Text("Total:"),
                subtitle:Text('Rs $totalPrice', style: TextStyle(color: Colors.black, fontSize: 20),),
              )),
              Expanded(child: MaterialButton(
                onPressed: (){
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
        print("Success message here");
       // sendBookingData();
        sendOrder("Khalti");
      },
      onFaliure: (error) {
        print("Error message here");
      },
    );
  }

  void sendOrder(String paymentMethod) async {

    var address = addressController.text;
    cartproductList.forEach((cart) async {
      onLoading(context);
      var url = '$ORDER_URL?name=${cart.productName}&price=${cart.productPrice}&seller=${cart.seller}&payment_method=$paymentMethod&buyer=${cart.cartOf}&address=$address';
      var response = await http.get(url);
      Navigator.pop(context);
      //print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.body.contains("order added")) {
        // Navigator.pushReplacementNamed(context, 'home');
        print('success');
        print("");
      } else {
        // _showSnackBar('failed!');
        print('failed');
        print("");
      }
    });




  }

  void _showSnackBar(String message) {
    final _snackBar = SnackBar(content: Text(message));
    _globalKeyScaffold.currentState.showSnackBar(_snackBar);
  }
}
