class Cart {
  String id;
  String productName;
  String price;
  String productCondition;
  String negotiable;
  String cartOf;
  String seller;
  String paymentMethod;
  String address;
  String productImages;
  Cart({
    this.id,
    this.productName,
    this.price,
    this.productCondition,
    this.negotiable,
    this.cartOf,
    this.productImages,
    this.seller,
    this.address,
    this.paymentMethod
  });

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    price = json['price'];
    productCondition = json['product_condition'];
    negotiable = json['negotiable'];
    cartOf = json['cartOf'];
    productImages= json['product_images'];
    paymentMethod = json['payment_method'];
    seller = json['seller'];
    address = json['address'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.productName;
    data['price'] = this.price;
    data['negotiable'] = this.negotiable;
    data['condition'] = this.productCondition;
    data['seller'] = this.cartOf;
    data['images'] = this.productImages;

    data['payment_method'] = this.paymentMethod;
    data['seller'] = this.seller;
    data['address'] = this.address;


    return data;
  }

}
