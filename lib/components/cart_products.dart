import 'package:flutter/material.dart';
import 'package:thrift_nep/constants/colors.dart';

class CartProducts extends StatefulWidget {
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  var Products_on_the_cart = [
    {
      "name": "Blazer",
      "picture": "images/products/blazer1.jpeg",
      "price": 85,
      "size": "M",
      "color": "Black",
      "quantity": 1,
    },
    {
      "name": "Red Dress",
      "picture": "images/products/skt1.jpeg",
      "price": 85,
      "size": "M",
      "color": "Red",
      "quantity": 1,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Products_on_the_cart.length,
      itemBuilder: (context, index) {
        return Single_cart_product(
          cart_prod_name: Products_on_the_cart[index]['name'],
          cart_prod_picture: Products_on_the_cart[index]['picture'],
          cart_prod_price: Products_on_the_cart[index]['price'],
          cart_prod_size: Products_on_the_cart[index]['size'],
          cart_prod_color: Products_on_the_cart[index]['color'],
          cart_prod_quantity: Products_on_the_cart[index]['quantity'],
        );
      },
    );
  }
}

class Single_cart_product extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;
  final cart_prod_size;
  final cart_prod_color;
  final cart_prod_quantity;

  Single_cart_product(
      {this.cart_prod_name,
      this.cart_prod_picture,
      this.cart_prod_price,
      this.cart_prod_size,
      this.cart_prod_color,
      this.cart_prod_quantity});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(
          cart_prod_picture,
          width: 80.0,
          height: 100.0,
        ),
        title: Text(cart_prod_name),
        subtitle: Column(
          children: [
            Row(
              children: [
                //       ===product size section==
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Size:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    cart_prod_size,
                    style: TextStyle(color: kAppbar),
                  ),
                ),
                //===product color section==
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                  child: Text("Color:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    cart_prod_color,
                    style: TextStyle(color: kAppbar),
                  ),
                ),
              ],
            ),
            //          ======Section for product price=====
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "\$ ${cart_prod_price}",
                style: TextStyle(
                    fontSize: 17.0,
                    color: kAppbar,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
