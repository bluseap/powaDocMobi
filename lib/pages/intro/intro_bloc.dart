import 'dart:async';

import 'package:powa_doc/bloc/bloc_provider.dart';
import 'package:powa_doc/pages/intro/intro.dart';
import 'package:powa_doc/pages/intro/intro_db.dart';
import 'package:powa_doc/utils/color_utils.dart';

class IntroBloc implements BlocBase {
  StreamController<List<Intro>> _introController = StreamController<List<Intro>>.broadcast();
  Stream<List<Intro>> get intro => _introController.stream;

  StreamController<bool> _introExistController = StreamController<bool>.broadcast();
  Stream<bool> get introExist => _introExistController.stream;

  StreamController<ColorPalette> _colorController = StreamController<ColorPalette>.broadcast();
  Stream<ColorPalette> get colorSelection => _colorController.stream;

  StreamController<String> _introidController = StreamController<String>.broadcast();
  Stream<String> get introid => _introidController.stream;

  final IntroDB _introDB;


  IntroBloc(this._introDB) {
    _loadIntro();
  }

  @override
  void dispose() {
    _introController.close();
    _introExistController.close();
    _colorController.close();
    _introidController.close();
  }

  void updateTitle(String title) {
    _introidController.sink.add(title);
  }
  void applyFilter(String title) {
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

  void updateColorSelection(ColorPalette colorPalette) {
    _colorController.sink.add(colorPalette);
  }

  void checkIfIntroExist(Intro intro) async {
    _introDB.isIntroExits(intro).then((isExist) {
      _introExistController.sink.add(isExist);
    });
  }

  void listIntrolId(Intro intro)  async {
    _introDB.getIntroId(intro).then((isExist) {

    });
  }

}
