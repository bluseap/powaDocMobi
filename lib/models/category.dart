import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Category {
  final int categoryId;
  final String name;
  final IconData icon;

  Category({this.categoryId, this.name, this.icon});
}

final allCategory = Category(
  categoryId: 0,
  name: "All",
  icon: Icons.search,
);

final introCategory = Category(
  categoryId: 1,
  name: "Giới thiệu",
  icon: Icons.turned_in_not,
);
final newsCategory = Category(
  categoryId: 2,
  name: "Tin tức",
  icon: Icons.image_aspect_ratio,
);
final productCategory = Category(
  categoryId: 3,
  name: "Sản phẩm",
  icon: Icons.flash_auto,
);
final customerCategory = Category(
  categoryId: 4,
  name: "Khách hàng",
  icon: Icons.dialpad,
);
final contactCategory = Category(
  categoryId: 5,
  name: "Liên hệ",
  icon: Icons.info_outline,
);

final categories = [
  //allCategory,
  introCategory,
  newsCategory,
  productCategory,
  customerCategory,
  contactCategory
];

/*final musicCategory = Category(
  categoryId: 1,
  name: "Music",
  icon: Icons.music_note,
);

final meetUpCategory = Category(
  categoryId: 2,
  name: "Meetup",
  icon: Icons.location_on,
);

final golfCategory = Category(
  categoryId: 3,
  name: "Golf",
  icon: Icons.golf_course,
);

final birthdayCategory = Category(
  categoryId: 4,
  name: "Birthday",
  icon: Icons.cake,
);

final categories = [
  allCategory,
  musicCategory,
  meetUpCategory,
  golfCategory,
  birthdayCategory,
];*/
