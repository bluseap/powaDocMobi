import 'dart:async';

import 'package:powa_doc/bloc/bloc_provider.dart';
import 'package:powa_doc/pages/customer/customer.dart';
import 'package:powa_doc/pages/customer/customer_db.dart';
import 'package:powa_doc/utils/color_utils.dart';

class CustomerBloc implements BlocBase {
  StreamController<List<Customer>> _customerController = StreamController<List<Customer>>.broadcast();
  Stream<List<Customer>> get customer => _customerController.stream;

  StreamController<bool> _customerExistController = StreamController<bool>.broadcast();
  Stream<bool> get customerExist => _customerExistController.stream;

  StreamController<ColorPalette> _colorController = StreamController<ColorPalette>.broadcast();
  Stream<ColorPalette> get colorSelection => _colorController.stream;

  StreamController<Customer> _customer2Controller = StreamController<Customer>.broadcast();
  Stream<Customer> get customer2 => _customer2Controller.stream;

  final CustomerDB _customerDB;


  CustomerBloc(this._customerDB) {
    _loadCustomer();
  }

  @override
  void dispose() {
    _customerController.close();
    _customerExistController.close();
    _colorController.close();
    //_customeridController.close();
    _customer2Controller.close();
  }

  void _loadCustomer() {
    _customerDB.getCustomer().then((customer) {
      _customerController.sink.add(List.unmodifiable(customer));
    });
  }

  void refresh() {
    _loadCustomer();
  }

  void getCustomerId2(Customer customer)  async {
    _customerDB.getCustomerId2(customer).then((isExist) {
      _customer2Controller.sink.add(customer);
    });
  }

  void updateColorSelection(ColorPalette colorPalette) {
    _colorController.sink.add(colorPalette);
  }

}
