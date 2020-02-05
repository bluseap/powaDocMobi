import 'package:powa_doc/db/app_db.dart';
import 'package:powa_doc/pages/product/product.dart';
import 'package:sqflite/sqflite.dart';

class ProductDB {

  final AppDatabase _appDatabase;

  //private internal constructor to make it singleton
  ProductDB._internal(this._appDatabase);

  static final ProductDB _productDb = ProductDB._internal(AppDatabase.get());

  static ProductDB get() {
    return _productDb;
  }

  Future<List<Product>> getProduct() async {
    var db = await _appDatabase.getDb();
    var result = await db.rawQuery('SELECT * FROM ${Product.tblProduct}');
    List<Product> projects = new List();
    for (Map<String, dynamic> item in result) {
      var myProject = Product.fromMap(item);
      projects.add(myProject);
    }
    return projects;
  }

  Future insertNews(String name) async {
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawInsert('INSERT INTO '
          '${Product.tblProduct}( ${Product.dbTitle} )'
          ' VALUES ("${name}")'
      );
    });
  }


}
