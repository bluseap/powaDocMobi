import 'package:powa_doc/db/app_db.dart';
import 'package:powa_doc/pages/contact/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDB {

  final AppDatabase _appDatabase;

  //private internal constructor to make it singleton
  ContactDB._internal(this._appDatabase);

  static final ContactDB _contactDb = ContactDB._internal(AppDatabase.get());

  static ContactDB get() {
    return _contactDb;
  }

  Future<List<Contact>> getContact() async {
    var db = await _appDatabase.getDb();
    var result = await db.rawQuery('SELECT * FROM ${Contact.tblContact}');
    List<Contact> projects = new List();
    for (Map<String, dynamic> item in result) {
      var myProject = Contact.fromMap(item);
      projects.add(myProject);
    }
    return projects;
  }

  Future insertContact(String name) async {
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawInsert('INSERT INTO '
          '${Contact.tblContact}( ${Contact.dbTitle} )'
          ' VALUES ("${name}")'
      );
    });
  }


}
