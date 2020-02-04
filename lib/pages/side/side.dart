import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Side {
  static final tblCategorySide = "CategorySide";

  static final dbId = "Id";
  static final dbCorporationId = "CorporationId";
  static final dbParentId = "ParentId";
  static final dbSortOrder = "SortOrder";
  static final dbShowInMenu = "ShowInMenu";
  static final dbShowInHome = "ShowInHome";
  static final dbColorCode = "ColorCode";
  static final dbCorporationName = "CorporationName";
  static final dbName = "Name";
  static final dbDescription = "Description";
  static final dbThumbnail = "Thumbnail";
  static final dbColorName = "ColorName";
  static final dbCreateDate = "CreateDate";
  static final dbUpdateDate = "UpdateDate";

  int id, corporationId, parentId, sortOrder,  colorCode;
  bool showInMenu, showInHome;
  String corporationName, name, description, Thumbnail, colorName;
  String createDate, updateDate;

  Side.create(this.name);
  /*Side.create(this.id, this.corporationId, this.parentId, this.sortOrder, this.showInMenu, this.showInHome , this.colorCode,
      this.corporationName, this.name, this.description, this.Thumbnail, this.colorName,
      this.createDate , this.updateDate);*/

  Side({this.id, this.corporationId, this.parentId, this.sortOrder, this.showInMenu, this.showInHome , this.colorCode,
      this.corporationName, this.name, this.description, this.Thumbnail, this.colorName,
      this.createDate , this.updateDate});

  factory Side.fromJson(Map<String, dynamic> json) {
    return Side(
      id: json['Id'] as int,
      corporationId: json['CorporationId'] as int,
      parentId: json['ParentId'] as int,
      sortOrder: json['SortOrder'] as int,
      showInMenu: json['ShowInMenu'] as bool,
      showInHome: json['ShowInHome'] as bool,
      colorCode: json['ColorCode'] as int,

      corporationName: json['CorporationName'] as String,
      name: json['Name'] as String,
      description: json['Description'] as String,
      Thumbnail: json['Thumbnail'] as String,
      colorName: json['ColorName'] as String,

      createDate: json['CreateDate'] as String,
      updateDate: json['UpdateDate'] as String
    );
  }

  /*Side.update({id = 0, corporationId = null, parentId = null, sortOrder = null,
    showInMenu = null, showInHome = null,
    colorCode = null, corporationName = "", name = "", description = "", Thumbnail = "", colorName = "",
    createDate = "", updateDate = ""}) {

    if (id != 0) {
      this.id = id;
    }
    if (corporationId != null) {
      this.corporationId = corporationId;
    }
    if (parentId != null) {
      this.parentId = parentId;
    }
    if (sortOrder != null) {
      this.sortOrder = sortOrder;
    }
    if (showInMenu != null) {
      this.showInMenu = showInMenu;
    }
    if (showInHome != null) {
      this.showInHome = showInHome;
    }
    if (colorCode != null) {
      this.colorCode = colorCode;
    }

    if (corporationName != "") {
      this.corporationName = corporationName;
    }
    if (name != "") {
      this.name = name;
    }
    if (description != "") {
      this.description = description;
    }
    if (Thumbnail != "") {
      this.Thumbnail = Thumbnail;
    }
    if (colorName != "") {
      this.colorName = colorName;
    }

    if (createDate != "") {
      this.createDate = createDate;
    }
    if (updateDate != "") {
      this.updateDate = updateDate;
    }

  }*/

  /*Side.fromMap(Map<String, dynamic> map)
      : this.update(
        id: map[dbId],
        corporationId: map[dbCorporationId],
        parentId: map[dbParentId],
        sortOrder: map[dbSortOrder],
        showInMenu: map[dbShowInMenu],
        showInHome: map[dbShowInHome],
        colorCode: map[dbColorCode],

        corporationName: map[dbCorporationName],
        name: map[dbName],
        description: map[dbDescription],
        Thumbnail: map[dbThumbnail],
        colorName: map[dbColorName],

        createDate: map[dbCreateDate],
        updateDate: map[dbUpdateDate]
    );*/

  Side.update({name = ""}) {
    if (name != "") {
      this.name = name;
    }
  }
  Side.getInbox()
      : this.update(
      name: "Nguyên thanh bình"
  );
  Side.fromMap(Map<String, dynamic> map)
      : this.update(
      name: map[dbName]
  );



/*
  Side.update({@required this.id, name, colorCode = "", colorName = ""}) {
    if (name != "") {
      this.name = name;
    }
    if (colorCode != "") {
      this.colorValue = colorCode;
    }
    if (colorName != "") {
      this.colorName = colorName;
    }
  }

  Side.getInbox()
      : this.update(
      id: 1,
      name: "Inbox",
      colorName: "Grey",
      colorCode: Colors.grey.value);

  Side.fromMap(Map<String, dynamic> map)
      : this.update(
      Id: map[dbId],
      CorporationId: map[dbCorporationId],
      colorCode: map[dbColorCode],
      colorName: map[dbColorName]);
  */

}
