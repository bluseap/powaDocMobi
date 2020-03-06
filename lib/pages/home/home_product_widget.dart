import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:powa_doc/bloc/bloc_provider.dart';
import 'package:powa_doc/pages/home/home_bloc.dart';
import 'package:powa_doc/pages/tasks/bloc/task_bloc.dart';

import 'package:powa_doc/pages/product/product_db.dart';
import 'package:powa_doc/pages/product/product.dart';
import 'package:powa_doc/pages/product/product_bloc.dart';
import 'package:powa_doc/pages/product/product_details_page.dart';



class HomeProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductBloc productBloc = BlocProvider.of(context);

    return StreamBuilder<List<Product>>(
      stream: productBloc.product,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
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
    buildSide(context);
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buildSide(context),
        )
    );

    /*return ExpansionTile(
      leading: Icon(Icons.turned_in_not),
      title: Text("Giới thiệu",
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
      children: buildSide(context),
    );*/
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
    final ProductBloc productBloc = BlocProvider.of(context);
    ProductDB productDB;

    return Card(
        margin: const EdgeInsets.symmetric(vertical: 20),
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            productBloc.getProductId2(product);
            //print("Id:" + intro.id.toString());
            var blocLabelProvider = BlocProvider(
              bloc: ProductBloc(ProductDB.get()),
              child: ProductDetailsPage(product: product),
            );
            Navigator.push(context, MaterialPageRoute<bool>(builder:
              (context) => blocLabelProvider));
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  child: Image.asset(
                    product.image,
                    height: 150,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              product.title,
                              //style: eventTitleTextStyle,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            FittedBox(
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.location_on),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Long Xuyên",
                                    //style: eventLocationTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "An Giang",
                          textAlign: TextAlign.right,
                          //style: eventLocationTextStyle.copyWith(                  fontWeight: FontWeight.w900,
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

}

