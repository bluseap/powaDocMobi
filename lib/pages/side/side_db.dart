import 'package:powa_doc/db/app_db.dart';
import 'package:powa_doc/pages/side/side.dart';
import 'package:sqflite/sqflite.dart';

class SideDB {

  final AppDatabase _appDatabase;

  //private internal constructor to make it singleton
  SideDB._internal(this._appDatabase);

  static final SideDB _sideDb = SideDB._internal(AppDatabase.get());

  static SideDB get() {
    return _sideDb;
  }


  Future<bool> isSideExits(Side side) async {
    var db = await _appDatabase.getDb();
    var result = await db.rawQuery(
      //  "SELECT * FROM ${Side.tblCategorySide} WHERE ${Side.dbName} LIKE '${side.name}'");
        "SELECT * FROM ${Side.tblCategorySide} ");
    //if (result.length == 0) {
    if (0 == 0) {
      return await updateSide(side).then((value) {
        return false;
      });
    } else {
      return true;
    }
  }

  Future updateSide(Side side) async {
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawInsert('INSERT OR REPLACE INTO '
          '${Side.tblCategorySide}( ${Side.dbName} )'
          ' VALUES ("${side.name}")'
      );
    });
  }
  /*Future updateSide(Side side) async {
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawInsert('INSERT OR REPLACE INTO '
          '${Side.tblCategorySide}(${Side.dbId},${Side.dbCorporationId},${Side.dbParentId},${Side.dbSortOrder},'
          '${Side.dbShowInMenu},${Side.dbShowInHome},${Side.dbColorCode},${Side.dbCorporationName},'
          '${Side.dbName},${Side.dbDescription},${Side.dbThumbnail},${Side.dbColorName},'
          '${Side.dbCreateDate},${Side.dbUpdateDate} )'
          ' VALUES(${side.id}, ${side.corporationId}, ${side.parentId}, ${side.sortOrder},'
          '${side.showInMenu}, ${side.showInHome}, ${side.colorCode}, "${side.corporationName}",'
          '"${side.name}", "${side.description}", "${side.Thumbnail}", "${side.colorName}",'
          '"${side.createDate}", "${side.updateDate} )');
    });
  }*/

  Future<List<Side>> getSide() async {
    var db = await _appDatabase.getDb();
    var result = await db.rawQuery('SELECT * FROM ${Side.tblCategorySide}');
    List<Side> projects = new List();

    for (Map<String, dynamic> item in result) {
      var myProject = Side.fromMap(item);
      projects.add(myProject);
    }
    return projects;
  }

  Future insertSide(String name) async {
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawInsert('INSERT INTO '
          '${Side.tblCategorySide}( ${Side.dbName} )'
          ' VALUES ("${name}")'
      );
    });
  }


}
