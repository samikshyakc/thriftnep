class Cart {
  String cartId ="";
  String productId="";
  String productName="";
  String productPrice="";
  String productCondition="";
  String usedFor="";
  String category="";
  String productImages="";
  String description="";
  String seller="";
  String cartOf="";

  Cart(
      {this.cartId,
        this.productId,
        this.productName,
        this.productPrice,
        this.productCondition,
        this.usedFor,
        this.category,
        this.productImages,
        this.description,
        this.seller,
        this.cartOf});

  Cart.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    productCondition = json['product_condition'];
    usedFor = json['used_for'];
    category = json['category'];
    productImages = json['product_images'];
    description = json['description'];
    seller = json['seller'];
    cartOf = json['cart_of'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    data['product_condition'] = this.productCondition;
    data['used_for'] = this.usedFor;
    data['category'] = this.category;
    data['product_images'] = this.productImages;
    data['description'] = this.description;
    data['seller'] = this.seller;
    data['cart_of'] = this.cartOf;
    return data;
  }
}


// class Cart {
//   String id;
//   String productName;
//   String price;
//   String productCondition;
//   String negotiable;
//   String cartOf;
//   String seller;
//   String paymentMethod;
//   String address;
//   String productImages;
//   Cart({
//     this.id,
//     this.productName,
//     this.price,
//     this.productCondition,
//     this.negotiable,
//     this.cartOf,
//     this.productImages,
//     this.seller,
//     this.address,
//     this.paymentMethod
//   });
//
//   Cart.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     productName = json['product_name'];
//     price = json['price'];
//     productCondition = json['product_condition'];
//     negotiable = json['negotiable'];
//     cartOf = json['cartOf'];
//     productImages= json['product_images'];
//     paymentMethod = json['payment_method'];
//     seller = json['seller'];
//     address = json['address'];
//
//
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.productName;
//     data['price'] = this.price;
//     data['negotiable'] = this.negotiable;
//     data['condition'] = this.productCondition;
//     data['seller'] = this.cartOf;
//     data['images'] = this.productImages;
//     data['payment_method'] = this.paymentMethod;
//     data['seller'] = this.seller;
//     data['address'] = this.address;
//
//
//     return data;
//   }
//
// }
