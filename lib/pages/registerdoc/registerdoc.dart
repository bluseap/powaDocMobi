
class RegisterDoc {
  static final tblRegisterDoc = "RegisterDoc";

  static final dbId = "Id";
  static final dbCorporationId = "CorporationId";
  static final dbAppUserId = "AppUserId";
  static final dbCode = "Code";
  static final dbTinNhan = "TinNhan";
  static final dbGhiChu = "GhiChu";

  static final dbCreateDate = "CreateDate";
  static final dbUpdateDate = "UpdateDate";

  static final dbTenDangKy = "TenDangKy";

  int id;
  String corporationId, appUserId, code, tinnhan, ghichu, createdate, updatedate, tendangky;

  RegisterDoc({this.id, this.corporationId, this.appUserId, this.code, this.tinnhan, this.ghichu , this.createdate,
    this.updatedate, this.tendangky});

  factory RegisterDoc.fromJson(Map<String, dynamic> json) {
    return RegisterDoc(
        id: json['Id'] as int,
        corporationId: json['CorporationId'] as String,
        appUserId: json['AppUserId'] as String,
        code: json['Code'] as String,
        tinnhan: json['TinNhan'] as String,
        ghichu: json['GhiChu'] as String,
        createdate: json['CreateDate'] as String,
        updatedate: json['UpdateDate'] as String,

        tendangky: json['TenDangKy'] as String
    );
  }


}