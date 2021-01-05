import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/provider/cart_provider.dart';
import 'package:flutter_khalti/flutter_khalti.dart';

class Pay extends StatefulWidget {

  final productPrice;

  Pay(
  { this.productPrice}
      );
  @override
  _PayState createState() => _PayState();
}

class _PayState extends State<Pay> {
  //List<Cart> cartproductList = [];
  int totalPrice = 0;


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

            RaisedButton(
                child: Text("Khalti Digital Wallet"),
                color: kAppbar,
                textColor: Colors.white24,
                onPressed: (){
                  openKhalti();
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
                subtitle:Text('\$$totalPrice', style: TextStyle(color: Colors.black, fontSize: 20),),
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
      },
      onFaliure: (error) {
        print("Error message here");
      },
    );
  }
}
