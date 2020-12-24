// import 'dart:ui';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:thrift_nep/components/product_details.dart';
//
//
// class Products extends StatefulWidget {
//   @override
//   _ProductsState createState() => _ProductsState();
// }
//
// class _ProductsState extends State<Products> {
//   var product_list = [
//     {
//       "name": "Blazer",
//       "picture": "images/products/blazer1.jpeg",
//       "old_price": 120,
//       "price": 85,
//     },
//     // {
//     //   "name": "Blazer",
//     //   "picture": "images/products/blazer2.jpeg",
//     //   "old_price": 120,
//     //   "price": 85,
//     // },
//     {
//       "name": "Dress",
//       "picture": "images/products/dress1.jpeg",
//       "old_price": 120,
//       "price": 85,
//     },
//     {
//       "name": "Black Dress",
//       "picture": "images/products/dress2.jpeg",
//       "old_price": 120,
//       "price": 85,
//     },
//     {
//       "name": "Heels",
//       "picture": "images/products/hills1.jpeg",
//       "old_price": 120,
//       "price": 85,
//     },
//     // {
//     //   "name": "Blazer",
//     //   "picture": "images/products/hills2.jpeg",
//     //   "old_price": 120,
//     //   "price": 85,
//     // },
//     {
//       "name": "Pants",
//       "picture": "images/products/pants1.jpg",
//       "old_price": 120,
//       "price": 85,
//     },
//     // {
//     //   "name": "Pants",
//     //   "picture": "images/products/pants2.jpeg",
//     //   "old_price": 120,
//     //   "price": 85,
//     // },
//     {
//       "name": "Shoes",
//       "picture": "images/products/shoe1.jpg",
//       "old_price": 120,
//       "price": 85,
//     },
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//         itemCount: product_list.length,
//         gridDelegate:
//         SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//         itemBuilder: (BuildContext context, int index) {
//           return Single_product(
//             prod_name: product_list[index]['name'],
//             prod_picture: product_list[index]['picture'],
//             prod_old_price: product_list[index]['old_price'],
//             prod_price: product_list[index]['price'],
//           );
//         });
//   }
// }
//
// class Single_product extends StatelessWidget {
//   final prod_name;
//   final prod_picture;
//   final prod_old_price;
//   final prod_price;
//
//   Single_product({
//     this.prod_name,
//     this.prod_picture,
//     this.prod_old_price,
//     this.prod_price,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Hero(
//           tag: Text('Hero 1'),
//           child: Material(
//             child: InkWell(
//               onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                 //here we are passing the value of the product to product details page
//                   builder: (context) => ProductDetails(
//                     product_detail_name: prod_name,
//                     product_detail_picture: prod_picture,
//                     product_detail_new_price: prod_price,
//                     product_detail_old_price: prod_old_price,
//                   ))),
//               child: GridTile(
//                   footer: Container(
//                     color: Colors.white70,
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             prod_name,
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 16.0),
//                           ),
//                         ),
//                         Text(
//                           '\$$prod_price',
//                           style: TextStyle(color: Colors.red),
//                         )
//                       ],
//                     ),
//
//                     // child: ListTile(
//                     //   leading: Text(
//                     //     prod_name,
//                     //     style: TextStyle(
//                     //       fontWeight: FontWeight.bold,
//                     //     ),
//                     //   ),
//                     //   title: Text(
//                     //     "\$$prod_price",
//                     //     style: TextStyle(
//                     //         color: Colors.red, fontWeight: FontWeight.w800),
//                     //   ),
//                     //   subtitle: Text(
//                     //     "\$$prod_old_price",
//                     //     style: TextStyle(
//                     //         color: Colors.black,
//                     //         fontWeight: FontWeight.w800,
//                     //         decoration: TextDecoration.lineThrough),
//                     //   ),
//                     // ),
//                   ),
//                   child: Image.asset(
//                     prod_picture,
//                     fit: BoxFit.cover,
//                   )),
//             ),
//           )),
//     );
//   }
// }