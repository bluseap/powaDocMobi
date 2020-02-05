import 'dart:async';

import 'package:powa_doc/bloc/bloc_provider.dart';
import 'package:powa_doc/pages/contact/contact.dart';
import 'package:powa_doc/pages/contact/contact_db.dart';
import 'package:powa_doc/utils/color_utils.dart';

class ContactBloc implements BlocBase {
  StreamController<List<Contact>> _contactController = StreamController<List<Contact>>.broadcast();
  Stream<List<Contact>> get contact => _contactController.stream;

  StreamController<bool> _contactExistController = StreamController<bool>.broadcast();
  Stream<bool> get contactExist => _contactExistController.stream;

  StreamController<ColorPalette> _colorController = StreamController<ColorPalette>.broadcast();
  Stream<ColorPalette> get colorSelection => _colorController.stream;

  final ContactDB _contactDB;


  ContactBloc(this._contactDB) {
    _loadContact();
  }

  @override
  void dispose() {
    _contactController.close();
    _contactExistController.close();
    _colorController.close();
  }

  void _loadContact() {
    _contactDB.getContact().then((contact) {
      _contactController.sink.add(List.unmodifiable(contact));
    });
  }

  void refresh() {
    _loadContact();
  }

  void updateColorSelection(ColorPalette colorPalette) {
    _colorController.sink.add(colorPalette);
  }

}
