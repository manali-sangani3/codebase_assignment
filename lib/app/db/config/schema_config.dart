import 'package:sqflite/sqflite.dart';

import '../db_constants.dart';

mixin SchemaConfig {
  late Database _db;

  void initialiseTables(Database db) {
    _db = db;
    _createCartTable();
  }

  /// Use: When changing database table without deleting data migration is used.
  ///
  /// Here based on old version to new version, we can execute changes
  /// made in new version.
  void onUpgradeDb(Database db, int oldVersion, int newVersion) {
    switch (oldVersion) {
      case 1:
        _migrateVersion1To2();
        break;
    }
  }

  /// Migrate database version 1 to 2
  ///
  /// Here following changes will be added to the table.
  /// 1. Add New Table : Orders
  /// 2. Add new column to cart.
  ///
  ///  1. Add New Table : Orders
  ///  For Adding new table, execute create table query.
  ///
  /// Here all the features will be executed using batch.
  void _migrateVersion1To2() async {
    // Perform migration from version 1 to version 2
    await _db.execute(MigrationSchemas.migrationFrom1to2);
  }

  /// Creates cart table.
  void _createCartTable() async {
    await _db.execute('''
          CREATE TABLE ${DbConstants.tblCart} (
            ${DbConstants.cartID} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${DbConstants.cartProductId} TEXT,
            ${DbConstants.cartProductName} TEXT,
            ${DbConstants.cartProductQuantity} INTEGER,
            ${DbConstants.cartProductImage} TEXT
          )
          ''');
  }

  /// Creates cart table.
  void _createOrderTable() async {
    await _db.execute('''
          CREATE TABLE ${DbConstants.tblPreviousOrder} (
            ${DbConstants.orderId} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${DbConstants.orderProductId} TEXT,
            ${DbConstants.orderProductName} TEXT,
            ${DbConstants.orderProductImage} TEXT,
            ${DbConstants.orderPurchaseDate} TEXT,
            ${DbConstants.orderProductQuantity} INTEGER,
            ${DbConstants.orderStatus} TEXT,
          )
          ''');
  }
}

class MigrationSchemas {
  static const String migrationFrom1to2 = '''
    ALTER TABLE ${DbConstants.tblPreviousOrder}
    ADD COLUMN ${DbConstants.orderSyncStatus} TEXT
  ''';
}
