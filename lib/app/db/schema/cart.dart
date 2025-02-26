import '../db_constants.dart';

class Cart {
  int? cartId;
  String? productId;
  String? productName;
  int? productQty;
  String? productImage;

  Cart(
      {this.cartId,
      this.productId,
      this.productName,
      this.productQty,
      this.productImage});

  Cart.fromJson(Map<String, dynamic> json) {
    cartId = json[DbConstants.cartID];
    productId = json[DbConstants.cartProductId];
    productName = json[DbConstants.cartProductName];
    productQty = json[DbConstants.cartProductQuantity];
    productImage = json[DbConstants.cartProductImage];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[DbConstants.cartProductId] = productId;
    data[DbConstants.cartProductName] = productName;
    data[DbConstants.cartProductQuantity] = productQty;
    data[DbConstants.cartProductImage] = productImage;
    return data;
  }
}
