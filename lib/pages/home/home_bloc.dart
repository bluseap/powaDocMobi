import 'dart:async';

import 'package:powa_doc/bloc/bloc_provider.dart';

import 'package:powa_doc/pages/tasks/bloc/task_bloc.dart';

import 'package:powa_doc/pages/intro/intro.dart';
import 'package:powa_doc/pages/intro/intro_db.dart';

import 'package:powa_doc/pages/product/product.dart';
import 'package:powa_doc/pages/product/product_db.dart';

class HomeBloc implements BlocBase {
  StreamController<String> _titleController = StreamController<String>.broadcast();

  Stream<String> get title => _titleController.stream;

  StreamController<Filter> _filterController = StreamController<Filter>.broadcast();

  Stream<Filter> get filter => _filterController.stream;

  StreamController<List<Intro>> _introController = StreamController<List<Intro>>.broadcast();
  Stream<List<Intro>> get intro => _introController.stream;

  StreamController<List<Product>> _productController = StreamController<List<Product>>.broadcast();
  Stream<List<Product>> get product => _productController.stream;

  IntroDB _introDB;
  ProductDB _productDB;


  @override
  void dispose() {
    _titleController.close();
    _filterController.close();

    _introController.close();
    _productController.close();
  }

  void updateTitle(String title) {
    _titleController.sink.add(title);
  }

  void applyFilter(String title, Filter filter) {
    _filterController.sink.add(filter);
    updateTitle(title);
  }

  void _loadIntro() {
    _introDB.getIntro().then((intro) {
      _introController.sink.add(List.unmodifiable(intro));
    });
  }
  void refresh() {
    _loadIntro();
  }

  void getIntrolId2(Intro intro)  async {
    _introDB.getIntroId2(intro).then((isExist) {
    });
  }

  void getProductId2(Product product)  async {
    _productDB.getProductId2(product).then((isExist) {
    });
  }

}
