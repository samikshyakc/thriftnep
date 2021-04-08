import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
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
        title: Text("ProductName : " +
            prodList[i]['product_name'] +
            " " +
            "\n Price" +
            prodList[i]['product_price']),
      ),
    );
  }
}
