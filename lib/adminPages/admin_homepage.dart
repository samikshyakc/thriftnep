import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/provider/DeliveredOrderProvider.dart';
import 'package:thrift_nep/provider/allOrderProvider.dart';
import 'package:thrift_nep/provider/dispatchedOrderProvider.dart';
import 'package:thrift_nep/provider/productToVerify.dart';
import 'package:thrift_nep/provider/product_provider.dart';

class AdminHomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Provider.of<AllOrderProvider>(context, listen: false).fetchAllOrder();
    Provider.of<VerifyProductProvider>(context, listen: false)
        .fetchProductToVerify();
    Provider.of<DeliveredOrderProvider>(context, listen: false)
        .fetchDeliveredOrder();
    Provider.of<DisptachOrderProvider>(context, listen: false)
        .fetchDispatchedOrder();

    Provider.of<ProductProvider>(context, listen: false).fetchProduct();
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            elevation: 0.1, //automaticallyImplyLeading: false,
            title: Text(
              'Dashboard',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: kAppbar,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          // drawer: FitnessChoiceDrawer(),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(height: 30.0),
                Container(
                  height: MediaQuery.of(context).size.height - 185.0,
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(75.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: .82,
                            crossAxisSpacing: 17,
                            mainAxisSpacing: 17,
                            children: <Widget>[
                              Items(
                                  "New Products",
                                  "assets/images/dietlogo.png",
                                  context,
                                  "verify"),
                              Items("All Products", "assets/images/bmi.png",
                                  context, "adminAllProduct"),
                              Items("Orders", "assets/orders.png",
                                  context, "adminOrders"),
                              Items("Users", "assets/images/water.jpg",
                                  context, "admin"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  Items(String title, String imgPath, BuildContext context, String pageName) {
    return Card(
      elevation: 12.0,
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, pageName);
        },
        child: Container(
          height: 200,
          width: 100,
          decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFF21BFBD),
                width: 2.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              SizedBox(
                height: 40.0,
              ),
              Center(
                child: Container(
                  height: 120,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imgPath),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(1.0), BlendMode.softLight),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
