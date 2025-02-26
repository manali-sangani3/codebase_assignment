import 'package:flutter/foundation.dart';
import 'package:flutter_base_project/app/db/schema/cart.dart';

import 'config/db_config.dart';
import 'config/schema_config.dart';
import 'db_constants.dart';

class DatabaseHelper with DbConfig, SchemaConfig {
  static const kDatabaseName = "base_project.db";
  static const kDatabaseVersion = 3;

  /// Initialise db
  void initialiseDb() {
    init(
      databaseName: kDatabaseName,
      databaseVersion: kDatabaseVersion,
      onCreateDb: initialiseTables,
      onUpgrade: onUpgradeDb,
    );
  }

  /// Add data to the cart.
  Future<int> addToCart(Cart cart) async {
    return await insert(cart.toJson(), DbConstants.tblCart);
  }

  /// Add data to the cart.
  Future<int> updateToCart(Cart cart) async {
    try {
      return await update(cart.toJson(), cart.productId ?? "",
          DbConstants.cartProductId, DbConstants.tblCart);
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
      return 0;
    }
  }

  /// Return all products as List<Cart>.
  Future<List<Cart>> getAllCartProductsProducts() async {
    List<dynamic> result = await queryAllRows(DbConstants.tblCart);

    List<Cart> enquiries = [];
    for (var element in result) {
      enquiries.add(Cart.fromJson(element));
    }
    return enquiries;
  }

  /// Fetch product quantity from cart.
  Future<Cart?> getProductQuantityFromCart(String productId) async {
    List<dynamic> result = await filterDataById(
        table: DbConstants.tblCart,
        columnName: DbConstants.cartProductId,
        id: productId);

    List<Cart> enquiries = [];
    for (var element in result) {
      enquiries.add(Cart.fromJson(element));
    }
    return enquiries.isNotEmpty ? enquiries.first : null;
  }

  /// Fetch total rows count from cart.
  Future<int> getTotalRows() async {
    return await queryRowCount(
      DbConstants.tblCart,
    );
  }
}
