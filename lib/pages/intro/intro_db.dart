import 'package:powa_doc/db/app_db.dart';
import 'package:powa_doc/pages/intro/intro.dart';
import 'package:sqflite/sqflite.dart';

class IntroDB {

  final AppDatabase _appDatabase;

  //private internal constructor to make it singleton
  IntroDB._internal(this._appDatabase);

  static final IntroDB _introDb = IntroDB._internal(AppDatabase.get());

  static IntroDB get() {
    return _introDb;
  }

  Future<List<Intro>> getIntro() async {
    var db = await _appDatabase.getDb();
    var result = await db.rawQuery('SELECT * FROM ${Intro.tblIntro}');
    List<Intro> projects = new List();
    for (Map<String, dynamic> item in result) {
      var myProject = Intro.fromMap(item);
      projects.add(myProject);
    }
    return projects;
  }

  Future insertIntro(String name) async {
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawInsert('INSERT INTO '
          '${Intro.tblIntro}( ${Intro.dbTitle} )'
          ' VALUES ("${name}")'
      );
    });
  }


}
