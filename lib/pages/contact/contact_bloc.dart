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

  StreamController<Contact> _contact2Controller = StreamController<Contact>.broadcast();
  Stream<Contact> get contact2 => _contact2Controller.stream;

  StreamController<String> _contactidController = StreamController<String>.broadcast();
  Stream<String> get contactid => _contactidController.stream;

  final ContactDB _contactDB;


  ContactBloc(this._contactDB) {
    _loadContact();
  }

  @override
  void dispose() {
    _contactController.close();
    _contactExistController.close();
    _colorController.close();
    _contactidController.close();
    _contact2Controller.close();
  }

  void updateTitle(String title) {
    _contactidController.sink.add(title);
  }
  void applyFilter(String title) {
    updateTitle(title);
  }
  void getContactId2(Contact contact)  async {
    _contactDB.getContactId2(contact).then((isExist) {
      _contact2Controller.sink.add(contact);
    });
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
