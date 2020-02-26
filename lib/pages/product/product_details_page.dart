import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:powa_doc/bloc/bloc_provider.dart';

import 'package:powa_doc/pages/product/product.dart';
import 'package:powa_doc/pages/product/product_bloc.dart';
import 'package:powa_doc/pages/product/product_details_content.dart';
import 'package:powa_doc/pages/product/product_details_background.dart';

class ProductDetailsPage extends StatelessWidget {

  final Product product;

  const ProductDetailsPage({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider<Product>.value(
        value: product,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ProductDetailsBackground(),
            ProductDetailsContent(),

          ],
        ),
      ),
    );
  }
}
