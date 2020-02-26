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

  StreamController<Product> _product2Controller = StreamController<Product>.broadcast();
  Stream<Product> get product2 => _product2Controller.stream;

  StreamController<String> _productidController = StreamController<String>.broadcast();
  Stream<String> get productid => _productidController.stream;

  final ProductDB _productDB;


  ProductBloc(this._productDB) {
    _loadProduct();
  }

  @override
  void dispose() {
    _productController.close();
    _productExistController.close();
    _colorController.close();
    _productidController.close();
    _product2Controller.close();
  }

  void updateTitle(String title) {
    _productidController.sink.add(title);
  }
  void applyFilter(String title) {
    updateTitle(title);
  }
  void getProductId2(Product product)  async {
    _productDB.getProductId2(product).then((isExist) {
      _product2Controller.sink.add(product);
    });
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
