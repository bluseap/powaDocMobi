import 'dart:async';

import 'package:powa_doc/bloc/bloc_provider.dart';
import 'package:powa_doc/pages/side/side.dart';
import 'package:powa_doc/pages/side/side_db.dart';
import 'package:powa_doc/utils/color_utils.dart';


class SideBloc implements BlocBase {
  StreamController<List<Side>> _sideController = StreamController<List<Side>>.broadcast();
  Stream<List<Side>> get side => _sideController.stream;

  StreamController<bool> _sideExistController = StreamController<bool>.broadcast();
  Stream<bool> get sideExist => _sideExistController.stream;

  StreamController<ColorPalette> _colorController = StreamController<ColorPalette>.broadcast();
  Stream<ColorPalette> get colorSelection => _colorController.stream;

  final SideDB _sideDB;


  SideBloc(this._sideDB) {
    _loadSide();
  }

  @override
  void dispose() {
    _sideController.close();
    _sideExistController.close();
    _colorController.close();
  }

  void _loadSide() {
    _sideDB.getSide().then((side) {
      _sideController.sink.add(List.unmodifiable(side));
    });
  }

  void refresh() {
    _loadSide();
  }

  void checkIfSideExist(Side side) async {
    _sideDB.isSideExits(side).then((isExist) {
      _sideExistController.sink.add(isExist);
    });
  }

  void updateColorSelection(ColorPalette colorPalette) {
    _colorController.sink.add(colorPalette);
  }
}
