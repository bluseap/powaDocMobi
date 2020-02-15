import 'package:powa_doc/db/app_db.dart';
import 'package:powa_doc/pages/customer/customer.dart';
import 'package:sqflite/sqflite.dart';

class CustomerDB {

  final AppDatabase _appDatabase;

  //private internal constructor to make it singleton
  CustomerDB._internal(this._appDatabase);

  static final CustomerDB _customerDb = CustomerDB._internal(AppDatabase.get());

  static CustomerDB get() {
    return _customerDb;
  }

  Future<List<Customer>> getCustomer() async {
    var db = await _appDatabase.getDb();
    var result = await db.rawQuery('SELECT * FROM ${Customer.tblCustomer}');
    List<Customer> projects = new List();
    for (Map<String, dynamic> item in result) {
      var myProject = Customer.fromMap(item);
      projects.add(myProject);
    }
    return projects;
  }

  Future insertCustomer(String name) async {
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawInsert('INSERT INTO '
          '${Customer.tblCustomer}( ${Customer.dbTitle} )'
          ' VALUES ("${name}")'
      );
    });
  }


}
