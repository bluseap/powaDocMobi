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
  //newsCategory,
  productCategory,
  customerCategory,
  contactCategory
];

