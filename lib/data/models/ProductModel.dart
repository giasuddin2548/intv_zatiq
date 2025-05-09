class ProductModel {
  ProductModel({
      this.id, 
      this.name, 
      this.buyingPrice, 
      this.sellingPrice, 
      this.stock, 
      this.img, 
      this.brandName, 
      this.categoryName, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  ProductModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    buyingPrice = json['buying_price'];
    sellingPrice = json['selling_price'];
    stock = json['stock'];
    img = json['img'];
    brandName = json['brand_name'];
    categoryName = json['category_name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? name;
  String? buyingPrice;
  String? sellingPrice;
  int? stock;
  String? img;
  String? brandName;
  String? categoryName;
  String? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['buying_price'] = buyingPrice;
    map['selling_price'] = sellingPrice;
    map['stock'] = stock;
    map['img'] = img;
    map['brand_name'] = brandName;
    map['category_name'] = categoryName;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}