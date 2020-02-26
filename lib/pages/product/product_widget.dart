import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:powa_doc/bloc/bloc_provider.dart';
import 'package:powa_doc/pages/home/home_bloc.dart';
import 'package:powa_doc/pages/tasks/bloc/task_bloc.dart';

import 'package:powa_doc/pages/product/product_db.dart';
import 'package:powa_doc/pages/product/product.dart';
import 'package:powa_doc/pages/product/product_bloc.dart';
import 'package:powa_doc/pages/product/product_details_page.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductBloc productBloc = BlocProvider.of(context);
    return StreamBuilder<List<Product>>(
      stream: productBloc.product,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LabelExpansionTileWidget(snapshot.data);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class LabelExpansionTileWidget extends StatelessWidget {
  final List<Product> _product;

  LabelExpansionTileWidget(this._product);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(Icons.flash_auto),
      title: Text("Sản phẩm - Dịch vụ",
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
      children: buildSide(context),
    );
  }

  List<Widget> buildSide(BuildContext context) {
    ProductBloc _productBloc = BlocProvider.of(context);
    List<Widget> projectWidgetList = List();
    _product.forEach((product) => projectWidgetList.add(ProductRow(product)));
    _productBloc.refresh();
    return projectWidgetList;
  }
}

class ProductRow extends StatelessWidget {
  final Product product;

  ProductRow(this.product);

  @override
  Widget build(BuildContext context) {
    ProductBloc productBloc = BlocProvider.of(context);

    return ListTile(
      onTap: () {
        productBloc.getProductId2(product);
        var blocLabelProvider = BlocProvider(
          bloc: ProductBloc(ProductDB.get()),
          child: ProductDetailsPage(product: product),
        );
        Navigator.push(context, MaterialPageRoute<bool>(builder: (context) => blocLabelProvider));
      },
      leading: Container(
        width: 24.0,
        height: 24.0,
      ),
      title: Text(" ${product.title}"),
      trailing: Container(
        height: 10.0,
        width: 10.0,
        child: Icon(
          Icons.label,
          size: 16.0,
          // color: Color(side.colorCode),
        ),
      ),
    );
  }

}
