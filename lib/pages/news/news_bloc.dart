import 'dart:async';

import 'package:powa_doc/bloc/bloc_provider.dart';
import 'package:powa_doc/pages/news/news.dart';
import 'package:powa_doc/pages/news/news_db.dart';
import 'package:powa_doc/utils/color_utils.dart';

class NewsBloc implements BlocBase {
  StreamController<List<News>> _newsController = StreamController<List<News>>.broadcast();
  Stream<List<News>> get news => _newsController.stream;

  StreamController<bool> _newsExistController = StreamController<bool>.broadcast();
  Stream<bool> get newsExist => _newsExistController.stream;

  StreamController<ColorPalette> _colorController = StreamController<ColorPalette>.broadcast();
  Stream<ColorPalette> get colorSelection => _colorController.stream;

  final NewsDB _newsDB;


  NewsBloc(this._newsDB) {
    _loadNews();
  }

  @override
  void dispose() {
    _newsController.close();
    _newsExistController.close();
    _colorController.close();
  }

  void _loadNews() {
    _newsDB.getNews().then((news) {
      _newsController.sink.add(List.unmodifiable(news));
    });
  }

  void refresh() {
    _loadNews();
  }

  void updateColorSelection(ColorPalette colorPalette) {
    _colorController.sink.add(colorPalette);
  }

}
