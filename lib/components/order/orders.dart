class Order {
  String orderId;
  String productId;
  String productName;
  String productPrice;
  String productCondition;
  String usedFor;
  String category;
  String productImages;
  String description;
  String seller;
  String paymentMethod;
  String buyer;
  String address;
  String date;

  Order(
      {this.orderId,
        this.productId,
        this.productName,
        this.productPrice,
        this.productCondition,
        this.usedFor,
        this.category,
        this.productImages,
        this.description,
        this.seller,
        this.paymentMethod,
        this.buyer,
        this.address,
        this.date});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    productCondition = json['product_condition'];
    usedFor = json['used_for'];
    category = json['category'];
    productImages= json['product_images'];
    description = json['description'];
    seller = json['seller'];
    paymentMethod = json['payment_method'];
    buyer = json['buyer'];
    address = json['address'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    data['product_condition'] = this.productCondition;
    data['used_for'] = this.usedFor;
    data['category'] = this.category;
    data['product_images'] = this.productImages;
    data['description'] = this.description;
    data['seller'] = this.seller;
    data['payment_method'] = this.paymentMethod;
    data['buyer'] = this.buyer;
    data['address'] = this.address;
    data['date'] = this.date;
    return data;
  }
}