import 'dart:async';

import 'package:powa_doc/bloc/bloc_provider.dart';
import 'package:powa_doc/pages/product/product.dart';
import 'package:powa_doc/pages/product/product_db.dart';
import 'package:powa_doc/utils/color_utils.dart';

class ProductBloc implements BlocBase {
  StreamController<List<Product>> _productController = StreamController<List<Product>>.broadcast();
  Stream<List<Product>> get product => _productController.stream;

  StreamController<bool> _productExistController = StreamController<bool>.broadcast();
  Stream<bool> get productExist => _productExistController.stream;

  StreamController<ColorPalette> _colorController = StreamController<ColorPalette>.broadcast();
  Stream<ColorPalette> get colorSelection => _colorController.stream;

  final ProductDB _productDB;


  ProductBloc(this._productDB) {
    _loadProduct();
  }

  @override
  void dispose() {
    _productController.close();
    _productExistController.close();
    _colorController.close();
  }

  void _loadProduct() {
    _productDB.getProduct().then((product) {
      _productController.sink.add(List.unmodifiable(product));
    });
  }

  void refresh() {
    _loadProduct();
  }

  void updateColorSelection(ColorPalette colorPalette) {
    _colorController.sink.add(colorPalette);
  }

}
