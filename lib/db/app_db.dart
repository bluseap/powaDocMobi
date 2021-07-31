import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:powa_doc/pages/labels/label.dart';
import 'package:powa_doc/pages/projects/project.dart';
import 'package:powa_doc/pages/tasks/models/task_labels.dart';
import 'package:powa_doc/pages/tasks/models/tasks.dart';
import 'package:powa_doc/pages/side/side.dart';
import 'package:powa_doc/pages/intro/intro.dart';
import 'package:powa_doc/pages/news/news.dart';
import 'package:powa_doc/pages/product/product.dart';
import 'package:powa_doc/pages/customer/customer.dart';
import 'package:powa_doc/pages/contact/contact.dart';

/// This is the singleton database class which handlers all database transactions
/// All the task raw queries is handle here and return a Future<T> with result
class AppDatabase {
  static final AppDatabase _appDatabase = AppDatabase._internal();

  //private internal constructor to make it singleton
  AppDatabase._internal();

  Database _database;

  static AppDatabase get() {
    return _appDatabase;
  }

  bool didInit = false;

  /// Use this method to access the database which will provide you future of [Database],
  /// because initialization of the database (it has to go through the method channel)
  Future<Database> getDb() async {
    if (!didInit) await _init();
    return _database;
  }

  // ignore: missing_return
  Future insertDb(Intro intro) {
    print(intro.title);
    //_initInsertTable(intro);
  }

  // ignore: unused_element
  Future _initInsertTable(Intro intro) async {
    // Get a location using path_provider
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "pomobi.db");
    _database = await openDatabase(path, version: 1,
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
      await db.execute("DROP TABLE ${Intro.tblIntro}");
      await _insertIntro(db, intro);
    });
    didInit = true;
  }

  Future _insertIntro(Database db, Intro intro) {
    return db.transaction((Transaction txn) async {
      txn.rawInsert('INSERT INTO '
          '${Intro.tblIntro} ( ${Intro.dbId}, ${Intro.dbCorporationId}, ${Intro.dbCorporationName}, ${Intro.dbTitle},'
          ' ${Intro.dbDescription}, ${Intro.dbCreateDate}, ${Intro.dbUpdateDate} )'
          ' VALUES ( ${intro.id}, ${intro.corporationId}, "${intro.corporationName}", "${intro.title}",'
          ' "${intro.description}", "${intro.createDate}", "${intro.updateDate}" )');
    });
  }

  Future _init() async {
    // Get a location using path_provider
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "tasks.db");
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await _createProjectTable(db);
      await _createTaskTable(db);
      await _createLabelTable(db);
      await _createCategorySide(db);
      await _createIntro(db);
      await _createNews(db);
      await _createProduct(db);
      await _createCustomer(db);
      await _createContact(db);
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      await db.execute("DROP TABLE ${Tasks.tblTask}");
      await db.execute("DROP TABLE ${Project.tblProject}");
      await db.execute("DROP TABLE ${TaskLabels.tblTaskLabel}");
      await db.execute("DROP TABLE ${Label.tblLabel}");
      await db.execute("DROP TABLE ${Side.tblCategorySide}");
      await db.execute("DROP TABLE ${Intro.tblIntro}");
      await db.execute("DROP TABLE ${News.tblNews}");
      await db.execute("DROP TABLE ${Product.tblProduct}");
      await db.execute("DROP TABLE ${Customer.tblCustomer}");
      await db.execute("DROP TABLE ${Contact.tblContact}");
      await _createProjectTable(db);
      await _createTaskTable(db);
      await _createLabelTable(db);
      await _createCategorySide(db);
      await _createIntro(db);
      await _createNews(db);
      await _createProduct(db);
      await _createCustomer(db);
      await _createContact(db);
    });
    didInit = true;
  }

  Future _createProjectTable(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute("CREATE TABLE ${Project.tblProject} ("
          "${Project.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${Project.dbName} TEXT,"
          "${Project.dbColorName} TEXT,"
          "${Project.dbColorCode} INTEGER);");
      txn.rawInsert('INSERT INTO '
          '${Project.tblProject}(${Project.dbId},${Project.dbName},${Project.dbColorName},${Project.dbColorCode})'
          ' VALUES(1, "Inbox", "Grey", ${Colors.grey.value});');
    });
  }

  Future _createLabelTable(Database db) {
    // ignore: missing_return
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${Label.tblLabel} ("
          "${Label.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${Label.dbName} TEXT,"
          "${Label.dbColorName} TEXT,"
          "${Label.dbColorCode} INTEGER);");
      txn.execute("CREATE TABLE ${TaskLabels.tblTaskLabel} ("
          "${TaskLabels.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${TaskLabels.dbTaskId} INTEGER,"
          "${TaskLabels.dbLabelId} INTEGER,"
          "FOREIGN KEY(${TaskLabels.dbTaskId}) REFERENCES ${Tasks.tblTask}(${Tasks.dbId}) ON DELETE CASCADE,"
          "FOREIGN KEY(${TaskLabels.dbLabelId}) REFERENCES ${Label.tblLabel}(${Label.dbId}) ON DELETE CASCADE);");
    });
  }

  Future _createTaskTable(Database db) {
    return db.execute("CREATE TABLE ${Tasks.tblTask} ("
        "${Tasks.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
        "${Tasks.dbTitle} TEXT,"
        "${Tasks.dbComment} TEXT,"
        "${Tasks.dbDueDate} LONG,"
        "${Tasks.dbPriority} LONG,"
        "${Tasks.dbProjectID} LONG,"
        "${Tasks.dbStatus} LONG,"
        "FOREIGN KEY(${Tasks.dbProjectID}) REFERENCES ${Project.tblProject}(${Project.dbId}) ON DELETE CASCADE);");
  }

  Future _createCategorySide(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute("CREATE TABLE ${Side.tblCategorySide} ("
          "${Side.dbId} INTERGER,"
          "${Side.dbCorporationId} INTERGER,"
          "${Side.dbCorporationName} TEXT,"
          "${Side.dbName} TEXT,"
          "${Side.dbDescription} TEXT,"
          "${Side.dbParentId} INTERGER,"
          "${Side.dbSortOrder} INTERGER,"
          "${Side.dbShowInMenu} NUMERIC,"
          "${Side.dbShowInHome} NUMERIC,"
          "${Side.dbThumbnail} TEXT,"
          "${Side.dbCreateDate} TEXT,"
          "${Side.dbUpdateDate} TEXT,"
          "${Side.dbColorName} TEXT,"
          "${Side.dbColorCode} INTEGER );");

      /*txn.rawInsert('INSERT INTO '
        '${Side.tblCategorySide} (${Side.dbName})'
        ' VALUES ("nguyên binh");');*/
    });
  }

  Future _createIntro(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute("CREATE TABLE ${Intro.tblIntro} ("
          "${Intro.dbId} INTERGER,"
          "${Intro.dbCorporationId} INTERGER,"
          "${Intro.dbCorporationName} TEXT,"
          "${Intro.dbThumbnail} TEXT,"
          "${Intro.dbImage} TEXT,"
          "${Intro.dbCreatedDateIntro} INTERGER,"
          "${Intro.dbPublishedDateIntro} INTERGER,"
          "${Intro.dbSource} NUMERIC,"
          "${Intro.dbTitle} NUMERIC,"
          "${Intro.dbContents} TEXT,"
          "${Intro.dbDescription} TEXT,"
          "${Intro.dbCreateDate} TEXT,"
          "${Intro.dbUpdateDate} TEXT );");

      txn.rawInsert('INSERT INTO '
          '${Intro.tblIntro} ( ${Intro.dbId}, ${Intro.dbCorporationId}, ${Intro.dbCorporationName}, ${Intro.dbTitle},'
          ' ${Intro.dbImage}, ${Intro.dbDescription}, ${Intro.dbCreateDate}, ${Intro.dbUpdateDate} )'
          ' VALUES ( 1, 1, "POWACO", "Giới thiệu chung",'
          ' "assets/powaco/toanct.png", "Công ty cổ phần Điện Nước An Giang là Doanh Nghiệp hoạt động sản xuất kinh doanh với nhiều lĩnh vực. Trong đó sản phẩm chính là cung cấp điện - nước sạch cho người dân các khu vực thành thị lẫn nông thôn trên địa bàn tỉnh An Giang. Đây là doanh nghiệp duy nhất trên cả nước, kinh doanh và phục vụ các nhu cầu cần thiết trong đời sống sinh hoạt của người dân trên lĩnh vực điện sinh hoạt - nước sạch.'
          '\n\nCông ty CP Điện Nước An Giang là đơn vị hạch toán độc lập theo quyết định số 1424/QĐ-UBND ngày 04/08/2010 của UBND Tỉnh An Giang.'
          '\n\nTên tiếng việt: CÔNG TY CỔ PHẨN ĐIỆN NƯỚC AN GIANG.'
          '\n\nTên tiếng Anh: AN GIANG POWER AND WATER SUPPLY JOINT STOCK COMPANY.'
          '\n\nTên viết tắt: POWACO. ", "2019/02/20", "2019/02/20" )');
    });
  }

  Future _createNews(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute("CREATE TABLE ${News.tblNews} ("
          "${Intro.dbId} INTERGER,"
          "${Intro.dbCorporationId} INTERGER,"
          "${Intro.dbCorporationName} TEXT,"
          "${Intro.dbThumbnail} TEXT,"
          "${Intro.dbImage} TEXT,"
          "${Intro.dbCreatedDateIntro} INTERGER,"
          "${Intro.dbPublishedDateIntro} INTERGER,"
          "${Intro.dbSource} NUMERIC,"
          "${Intro.dbTitle} NUMERIC,"
          "${Intro.dbContents} TEXT,"
          "${Intro.dbDescription} TEXT,"
          "${Intro.dbCreateDate} TEXT,"
          "${Intro.dbUpdateDate} TEXT );");
    });
  }

  Future _createProduct(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute("CREATE TABLE ${Product.tblProduct} ("
          "${Product.dbId} INTERGER,"
          "${Product.dbCorporationId} INTERGER,"
          "${Product.dbCorporationName} TEXT,"
          "${Product.dbThumbnail} TEXT,"
          "${Product.dbImage} TEXT,"
          "${Product.dbCreatedDateIntro} INTERGER,"
          "${Product.dbPublishedDateIntro} INTERGER,"
          "${Product.dbSource} NUMERIC,"
          "${Product.dbTitle} NUMERIC,"
          "${Product.dbContents} TEXT,"
          "${Product.dbDescription} TEXT,"
          "${Product.dbCreateDate} TEXT,"
          "${Product.dbUpdateDate} TEXT );");

      txn.rawInsert('INSERT INTO '
          '${Product.tblProduct} ( ${Product.dbId}, ${Product.dbCorporationId}, ${Product.dbCorporationName}, ${Product.dbTitle},'
          ' ${Product.dbImage}, ${Product.dbDescription}, ${Product.dbCreateDate}, ${Product.dbUpdateDate} )'
          ' VALUES ( 4, 1, "POWACO", "Nước sạch",'
          ' "assets/powaco/toanct.png", "Nước sạch của Công ty CP Điện Nước An Giang được sản xuất và quản lý chất lượng theo hệ thống quản lý chất lượng ISO 9001-2008.'
          '\n\nSản phẩm nước sạch của Công ty luôn đảm bảo đầy đủ theo các tiêu chuẩn quy định.'
          '\n\nThường xuyên tự kiểm tra định kỳ, đột xuất chất lượng nước sạch, thường xuyên kết hợp trung tâm y tế dự phòng Tỉnh kiểm tra kiểm nghiệm chất lượng nước sạch.'
          '\n\nCông ty đang thực hiện việc lắp đặt đồng hồ nước không thu tiền (trong phạm vi 05 mét tính từ hệ thống ống cung cấp nước).'
          ' ", "2019/02/20", "2019/02/20" )');
      txn.rawInsert('INSERT INTO '
          '${Product.tblProduct} ( ${Product.dbId}, ${Product.dbCorporationId}, ${Product.dbCorporationName}, ${Product.dbTitle},'
          ' ${Product.dbImage}, ${Product.dbDescription}, ${Product.dbCreateDate}, ${Product.dbUpdateDate} )'
          ' VALUES ( 3, 1, "POWACO", "Điện sinh hoạt",'
          ' "assets/powaco/guest6.jpg", "Chất lượng điện năng: đảm bảo cấp điện ổn định, liên tục, an toàn cho bên mua điện.'
          '\n\nChất lượng dịch vụ sữa chữa: Khôi phục kịp thời việc cấp điện cho bên mua điện theo quy định của pháp luật.'
          '\n\nCông ty lắp đặt điện kế theo phương thức không thu tiền đối với hộ sử dụng điện cho mục đích sinh hoạt có khoảng cách từ trụ điện đến nhà khách hàng từ  30 mét  trở xuống, kể từ ngày 01/07/2016.'
          ' ", "2019/02/20", "2019/02/20" )');
      txn.rawInsert('INSERT INTO '
          '${Product.tblProduct} ( ${Product.dbId}, ${Product.dbCorporationId}, ${Product.dbCorporationName}, ${Product.dbTitle},'
          ' ${Product.dbImage}, ${Product.dbDescription}, ${Product.dbCreateDate}, ${Product.dbUpdateDate} )'
          ' VALUES ( 2, 1, "POWACO", "Điện năng lượng mặt trời",'
          ' "assets/powaco/guest3.jpg", "Từ năm 2017, nhận thấy lĩnh vực điện năng lượng mắt trời đang được ứng dụng rộng rãi với lợi thế có nguồn tài nguyên năng lượng mặt trời dồi dào đặc trưng khu vực Tây Nam bộ, đặc biệt là các diện tích sẵn có tại các nhà máy nước, lượng khách hang tiềm năng đông đảo hiện có, Công ty đã mở rộng sang lĩnh vực mới về Kinh doanh điện NLMT. Được Sở Kế Hoạch Đầu tư tỉnh An Giang cấp giấy xác nhận đăng ký kinh doanh lĩnh vực lắp đặt, sửa chữa, bán buôn thiết bị sử dụng năng lượng mặt trời, pin mặt trời tại giấy xác nhận số 14456/17 ngày 17 tháng 10 năm 2017.'
          '\n\nCuối năm 2017 và đầu năm 2018, Công ty đã đưa vào lắp đặt và đưa vào vận hành hệ thống điện NLMT cho văn phòng Công ty và Nhà máy nước Tri Tôn với công suất 20kWp/ đơn vị.'
          '\n\nBên cạnh đó Công ty đã thực hiện kinh doanh lắp đặt hệ thống điện NLMT cho các khách hàng đầu tiên có công suất từ 3kWp đến 50kWp và tiếp tục mở rộng kinh doanh hệ thống điện NLMT cho các khách hàng có nhu cầu phục vụ ánh sáng sinh hoạt và sản xuất.'
          ' ", "2019/02/20", "2019/02/20" )');
      txn.rawInsert('INSERT INTO '
          '${Product.tblProduct} ( ${Product.dbId}, ${Product.dbCorporationId}, ${Product.dbCorporationName}, ${Product.dbTitle},'
          ' ${Product.dbImage}, ${Product.dbDescription}, ${Product.dbCreateDate}, ${Product.dbUpdateDate} )'
          ' VALUES ( 5, 1, "POWACO", "Kinh doanh bất động sản, đất nền biệt thự",'
          ' "assets/powaco/guest4.jpg", "Bảng giá đất nền khu biệt thự vườn Châu Đốc - Núi Sam.'
          '\nXem chi tiết trên Website Công ty Cổ phần Điện Nước An Giang.'
          ' ", "2019/02/20", "2019/02/20" )');
    });
  }

  Future _createCustomer(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute("CREATE TABLE ${Customer.tblCustomer} ("
          "${Customer.dbId} INTERGER,"
          "${Customer.dbCorporationId} INTERGER,"
          "${Customer.dbCorporationName} TEXT,"
          "${Customer.dbThumbnail} TEXT,"
          "${Customer.dbImage} TEXT,"
          "${Customer.dbCreatedDateIntro} INTERGER,"
          "${Customer.dbPublishedDateIntro} INTERGER,"
          "${Customer.dbSource} NUMERIC,"
          "${Customer.dbTitle} NUMERIC,"
          "${Customer.dbContents} TEXT,"
          "${Customer.dbDescription} TEXT,"
          "${Customer.dbCreateDate} TEXT,"
          "${Customer.dbUpdateDate} TEXT );");
      txn.rawInsert('INSERT INTO '
          '${Customer.tblCustomer} ( ${Customer.dbId}, ${Customer.dbCorporationId}, ${Customer.dbCorporationName}, ${Customer.dbTitle},'
          ' ${Customer.dbImage}, ${Customer.dbDescription}, ${Customer.dbCreateDate}, ${Customer.dbUpdateDate} )'
          ' VALUES ( 6, 1, "POWACO", "Giá nước sạch",'
          ' "assets/powaco/guest5.jpg", "  Căn cứ quyết định số 23/2015/QĐ-UBND ngày 18/08/2015 của UBND Tỉnh An Giang ban hành giá tiêu thụ nước sạch trên địa bàn tỉnh do Công Ty Cổ phần Điện Nước An Giang cung ứng.'
          '\nCăn cứ quyết định số 40/2017/QĐ-UBND ngày 01/08/2017 của UBND Tỉnh An Giang V/v qui định mức thu, mức trích để lại cho tổ chức thu phí và bố trí sử dụng nguồn phí bảo vệ môi trường đối với nước thải sinh hoạt trên địa bàn tỉnh An giang.'
          '\nXem chi tiết trên Website công ty.'
          ' ", "2019/02/20", "2019/02/20" )');
      txn.rawInsert('INSERT INTO '
          '${Customer.tblCustomer} ( ${Customer.dbId}, ${Customer.dbCorporationId}, ${Customer.dbCorporationName}, ${Customer.dbTitle},'
          ' ${Customer.dbImage}, ${Customer.dbDescription}, ${Customer.dbCreateDate}, ${Customer.dbUpdateDate} )'
          ' VALUES ( 7, 1, "POWACO", "Giá điện",'
          ' "assets/powaco/guest4.jpg", "Căn cứ Văn bản số 23/VBHN-BCT ngày 16/10/2018 của Bộ trưởng Bộ Công thương về việc xác thực văn bản hợp nhất Thông tư số 16/2014/TT-BCT và Thông tư số 25/2018/TT-BCT của Bộ Công thương Quy định về thực hiện giá bán điện.'
          '\nCăn cứ Quyết định số 648/QĐ-BCT ngày 20/03/2019 của Bộ Công thương về việc điều chỉnh mức giá bản lẻ điện bình quân và quy định giá bán điện.'
          '\nXem chi tiết trên Website công ty.'
          ' ", "2019/02/20", "2019/02/20" )');
    });
  }

  Future _createContact(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute("CREATE TABLE ${Contact.tblContact} ("
          "${Contact.dbId} INTERGER,"
          "${Contact.dbCorporationId} INTERGER,"
          "${Contact.dbCorporationName} TEXT,"
          "${Contact.dbThumbnail} TEXT,"
          "${Contact.dbImage} TEXT,"
          "${Contact.dbCreatedDateIntro} INTERGER,"
          "${Contact.dbPublishedDateIntro} INTERGER,"
          "${Contact.dbSource} NUMERIC,"
          "${Contact.dbTitle} NUMERIC,"
          "${Contact.dbContents} TEXT,"
          "${Contact.dbDescription} TEXT,"
          "${Contact.dbCreateDate} TEXT,"
          "${Contact.dbUpdateDate} TEXT );");
      txn.rawInsert('INSERT INTO '
          '${Contact.tblContact} ( ${Contact.dbId}, ${Contact.dbCorporationId}, ${Contact.dbCorporationName}, ${Contact.dbTitle},'
          ' ${Contact.dbImage}, ${Contact.dbDescription}, ${Contact.dbCreateDate}, ${Contact.dbUpdateDate} )'
          ' VALUES ( 8, 1, "POWACO", "Liên hệ",'
          ' "assets/powaco/guest1.png", "Công ty Cổ phần Điện nước An Giang'
          '\nEmail: ctydn_ag@gmail.com, ctycpdn.ag@gmail.com'
          '\nSố điện thoại: 0296.3856100.'
          '\nĐường dây nóng: 19009090.'
          ' ", "2019/02/20", "2019/02/20" )');
    });
  }
}
