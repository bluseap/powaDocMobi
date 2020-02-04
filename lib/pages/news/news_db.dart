import 'package:powa_doc/db/app_db.dart';
import 'package:powa_doc/pages/news/news.dart';
import 'package:sqflite/sqflite.dart';

class NewsDB {

  final AppDatabase _appDatabase;

  //private internal constructor to make it singleton
  NewsDB._internal(this._appDatabase);

  static final NewsDB _newsDb = NewsDB._internal(AppDatabase.get());

  static NewsDB get() {
    return _newsDb;
  }

  Future<List<News>> getNews() async {
    var db = await _appDatabase.getDb();
    var result = await db.rawQuery('SELECT * FROM ${News.tblNews}');
    List<News> projects = new List();
    for (Map<String, dynamic> item in result) {
      var myProject = News.fromMap(item);
      projects.add(myProject);
    }
    return projects;
  }

  Future insertNews(String name) async {
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawInsert('INSERT INTO '
          '${News.tblNews}( ${News.dbTitle} )'
          ' VALUES ("${name}")'
      );
    });
  }


}
