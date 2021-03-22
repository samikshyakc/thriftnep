import 'package:flutter/material.dart';
import 'package:thrift_nep/screens/cat.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            image_location: 'images/cats/accessories.PNG',
            image_caption: 'Accessories',
          ),
          Category(
            image_location: 'images/cats/pc.PNG',
            image_caption: 'PCs',
          ),
          Category(
            image_location: 'images/cats/furnitures.PNG',
            image_caption: 'Furnitures',
          ),
          Category(
            image_location: 'images/cats/tshirt.PNG',
            image_caption: 'Mens Clothing',
          ),
          Category(
            image_location: 'images/cats/dress.PNG',
            image_caption: 'Womens Clothing',
          ),
          Category(
            image_location: 'images/cats/books.PNG',
            image_caption: 'Books',
          ),
          Category(
            image_location: 'images/cats/shoes.PNG',
            image_caption: 'Footwears',
          ),
          Category(
            image_location: 'images/cats/mobiles.PNG',
            image_caption: 'Mobile',
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  //final Icon icon;
  Category({
    this.image_location,
    this.image_caption,
    // this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              //  here we are passing the value of the product to product details page
              builder: (context) => Cat(image_caption)));
        },
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage(image_location),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [BoxShadow(blurRadius: 5, color: Colors.blueGrey)],
          ),
          child: Container(
            width: 50,
            alignment: Alignment.bottomCenter,
            child: Text(
              image_caption,
              style: TextStyle(fontSize: 12.0, color: Colors.black),
            ),
          ),

        ),
      ),
    );
  }
}
