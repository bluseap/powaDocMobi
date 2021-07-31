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


}
