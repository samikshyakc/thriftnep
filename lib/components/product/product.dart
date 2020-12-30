
class Product {

  String productId;
  String productName;
  String productPrice;
  String negotiable;
  String productCondition;
  String usedFor;
  String category;
  String productImages;
  String description;
  String seller;

  Product({
    this.productId,
    this.productName,
    this.productPrice,
    this.negotiable,
    this.productCondition,
    this.usedFor,
    this.category,
    this.productImages,
    this.description,
    this.seller,
  });

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    negotiable = json['negotiable'];
    productCondition = json['product_condition'];
    usedFor = json['used_for'];
    category = json['category'];
    productImages= json['product_images'];
    description = json['description'];
    seller = json['seller'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    data['negotiable'] = this.negotiable;
    data['product_condition'] = this.productCondition;
    data['used_for'] = this.usedFor;
    data['category'] = this.category;
    data['product_images'] = this.productImages;
    data['description'] = this.description;
    data['seller'] = this.seller;
    return data;
  }



}


