import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:thrift_nep/components/order/orders.dart';
import 'package:thrift_nep/constants/colors.dart';


class OrderWidget extends StatelessWidget {
  final Order orderProduct;


  OrderWidget(this.orderProduct);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: (){

        },
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          secondaryActions: <Widget>[
            new IconSlideAction(
              caption: 'More',
              color: Colors.black45,
              icon: Icons.more_horiz,
              onTap: () {},
            ),
            new IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {

              },
            ),
          ],
          child: ListTile(
            leading: Image(
              image: CachedNetworkImageProvider(orderProduct.productImages),
              width: 50.0,
              height: 100.0,
            ),
            title: Text(orderProduct.productName),
            subtitle: Column(
              children: [
                Row(
                  children: [
                    //       ===product size section==
                    Text("Ordered Date:"),
                    Text(
                      orderProduct.date,
                      style: TextStyle(color: kAppbar),
                    ),
                    Padding(padding: const EdgeInsets.only(left: 20),),

                  ],

                ),

                //          ======Section for product price=====
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Rs ${orderProduct.productPrice}",
                    style: TextStyle(
                        fontSize: 17.0,
                        color: kAppbar,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    //       ===product size section==
                    Text("Ordered Status:"),
                    orderProduct.status == "1"?Text(
                      "Order Placed",
                      style: TextStyle(color: kAppbar),
                    ):Text(
                      "Order Delivered",
                      style: TextStyle(color: kAppbar),
                    ) ,
                    Padding(padding: const EdgeInsets.only(left: 20),),

                  ],

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
