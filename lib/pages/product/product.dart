
class Product {
  static final tblProduct = "Product";

  static final dbId = "Id";
  static final dbCorporationId = "CorporationId";
  static final dbCorporationName = "CorporationName";
  static final dbThumbnail = "Thumbnail";
  static final dbImage = "Image";
  static final dbCreatedDateIntro = "CreateDateIntro";
  static final dbPublishedDateIntro = "PublishedDateIntro";
  static final dbSource = "Source";

  static final dbTitle = "Title";
  static final dbContents = "Contents";
  static final dbDescription = "Description";

  static final dbCreateDate = "CreateDate";
  static final dbUpdateDate = "UpdateDate";

  int id, corporationId;
  String corporationName, thumbnail, image, createdateIntro, publishedDateIntro, source, title, contents, description,
      createDate, updateDate;


  Product({this.id, this.corporationId, this.corporationName, this.thumbnail, this.image, this.createdateIntro ,
    this.publishedDateIntro, this.source, this.title, this.contents, this.description,
    this.createDate , this.updateDate});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['Id'] as int,
        corporationId: json['CorporationId'] as int,
        corporationName: json['CorporationName'] as String,
        thumbnail: json['Thumbnail'] as String,
        image: json['Image'] as String,
        createdateIntro: json['CreateDateIntro'] as String,
        publishedDateIntro: json['PublishedDateIntro'] as String,
        source: json['Source'] as String,
        title: json['Title'] as String,
        contents: json['Contents'] as String,
        description: json['Description'] as String,
        createDate: json['CreateDate'] as String,
        updateDate: json['UpdateDate'] as String
    );
  }

  Product.update({title = ""}) {
    if (title != "") {
      this.title = title;
    }
  }

  Product.fromMap(Map<String, dynamic> map)
      : this.update(
      title: map[dbTitle]
  );




}
