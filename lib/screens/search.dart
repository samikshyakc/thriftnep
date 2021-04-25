import 'dart:convert';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:thrift_nep/components/product/searchedProductDetail.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/constants/urls.dart';


class SearchScreen extends StatefulWidget {
  final String searchText;
  SearchScreen(this.searchText);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List prodList = [];
  bool isLoading = true;

  Future<void> fetchProduct(String searchText) async {

    var url = '$SEARCH_URL?search=$searchText';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      prodList = result;
      setState(() {
        isLoading = false;
      });

      print('I am being printed : \n $result');

      // result.forEach((p) {
      //   var note = Product.fromJson(p);
      // //  print(note);
      //   prodList.add(note);
      // }
     // );
    }
  }

  @override
  void initState() {
    super.initState();
    searchText.text = widget.searchText;
    fetchProduct(widget.searchText);

  }
  var searchText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0.1, //automaticallyImplyLeading: false,
            backgroundColor: kAppbar,
         //   iconTheme: IconThemeData(color: Colors.white),

          title: Container(
            alignment: Alignment.centerLeft,
            color: Colors.transparent,
            child: TextField(
              controller: searchText,
              onChanged: (value) {
                value == "" ?
                fetchProduct(null): fetchProduct(value);
                // setState(() {
                //   prodList = [];
                //   prodList =
                //       Provider.of<ProductProvider>(context, listen: false)
                //           .filterProduct(value);
                // }
                //);
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white)),
            ),
          ),
        ),
       body:(isLoading)
           ? Center(
         child: CircularProgressIndicator(),
       ):
       //Text("heyy")
       prodList != null?  ListView.builder(
           itemCount: prodList == null ? 0 : prodList.length,
           itemBuilder: (context, i) {
             return SearchedItems(i, context);
           }): Center(child: Text("No result found", style: TextStyle(color: Colors.green),)) ,

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
        onTap: ()
        => Navigator.of(context).push(MaterialPageRoute(
          //  here we are passing the value of the product to product details page
            builder: (context) => SearchProductDetails(
              productId: prodList[i]['product_id'],
              productName:prodList[i]['product_name'],
              productPrice: prodList[i]['product_price'],
              // negotiable: product.negotiable,
              condition: prodList[i]['product_condition'],
              usedfor: prodList[i]['used_for'],
              category: prodList[i]['category'],
              productImages: prodList[i]['product_images'],
              details:  prodList[i]['description'],
              seller:  prodList[i]['seller'],

            ))),
        // title: Text("ProductName : " +
        //     prodList[i]['product_name'] +
        //     " " +
        //     "\n Price" +
        //     prodList[i]['product_price']),

          leading: Image(
            image: CachedNetworkImageProvider(prodList[i]['product_images']),
            width: 50.0,
            height: 100.0,
          ),
          title: Text(prodList[i]['product_name']),
          subtitle: Column(
            children: [
              Row(
                children: [
                  //       ===product size section==
                  Text("Condition:"),
                  Text(
                    prodList[i]['product_condition'],
                    style: TextStyle(color: kAppbar),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 20),),
                  //===product color section==
                  Text("Used for:"),
                  Text(
                    prodList[i]['used_for'],
                    style: TextStyle(color: kAppbar),
                  ),

                ],

              ),

              //          ======Section for product price=====
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Rs ${prodList[i]['product_price']}",
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
