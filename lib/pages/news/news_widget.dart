import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:powa_doc/bloc/bloc_provider.dart';
import 'package:powa_doc/pages/home/home_bloc.dart';
import 'package:powa_doc/pages/tasks/bloc/task_bloc.dart';

import 'package:powa_doc/pages/news/news_db.dart';
import 'package:powa_doc/pages/news/news.dart';
import 'package:powa_doc/pages/news/news_bloc.dart';


class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NewsBloc newsBloc = BlocProvider.of(context);
    return StreamBuilder<List<News>>(
      stream: newsBloc.news,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LabelExpansionTileWidget(snapshot.data);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class LabelExpansionTileWidget extends StatelessWidget {
  final List<News> _news;

  LabelExpansionTileWidget(this._news);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(Icons.image_aspect_ratio),
      title: Text("Tin tức - Sự kiện",
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
      children: buildSide(context),
    );
  }

  List<Widget> buildSide(BuildContext context) {
    NewsBloc _newsBloc = BlocProvider.of(context);
    List<Widget> projectWidgetList = List();
    _news.forEach((news) => projectWidgetList.add(NewsRow(news)));
    _newsBloc.refresh();
    return projectWidgetList;
  }
}

class NewsRow extends StatelessWidget {
  final News news;

  NewsRow(this.news);

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.of(context);
    return ListTile(
      onTap: () {
        homeBloc.applyFilter(" ${news.title}", Filter.byLabel(news.title));
        Navigator.pop(context);
      },
      leading: Container(
        width: 24.0,
        height: 24.0,
      ),
      title: Text(" ${news.title}"),
      trailing: Container(
        height: 10.0,
        width: 10.0,
        child: Icon(
          Icons.label,
          size: 16.0,
          // color: Color(side.colorCode),
        ),
      ),
    );
  }

}
