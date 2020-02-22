import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:powa_doc/bloc/bloc_provider.dart';
import 'package:powa_doc/pages/home/home_bloc.dart';
import 'package:powa_doc/pages/tasks/bloc/task_bloc.dart';

import 'package:powa_doc/pages/intro/intro_db.dart';
import 'package:powa_doc/pages/intro/intro.dart';
import 'package:powa_doc/pages/intro/intro_bloc.dart';
import 'package:powa_doc/pages/intro/IntroDetailsPage.dart';


class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    IntroBloc introBloc = BlocProvider.of(context);
    return StreamBuilder<List<Intro>>(
      stream: introBloc.intro,
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
  final List<Intro> _intro;

  LabelExpansionTileWidget(this._intro);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(Icons.turned_in_not),
      title: Text("Giới thiệu",
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
      children: buildSide(context),
    );
  }

  List<Widget> buildSide(BuildContext context) {
    IntroBloc _introBloc = BlocProvider.of(context);
    List<Widget> projectWidgetList = List();
    _intro.forEach((intro) => projectWidgetList.add(IntroRow(intro)));
    _introBloc.refresh();
    return projectWidgetList;
  }
}

class IntroRow extends StatelessWidget {
  final Intro intro;

  IntroRow(this.intro);

  @override
  Widget build(BuildContext context) {
    IntroBloc introBloc = BlocProvider.of(context);
    return ListTile(
      onTap: () {
        introBloc.applyFilter("${intro.id}");
        print("id:" + "${intro.id}");
        var blocLabelProvider = BlocProvider(
          bloc: IntroBloc(IntroDB.get()),
          child: IntroDetailsPage(intro: intro),
        );
        Navigator.push(context, MaterialPageRoute<bool>(builder: (context) => blocLabelProvider));
        /*var blocLabelProvider = BlocProvider(
          bloc: IntroBloc(IntroDB.get()),
          child: RegisterDocUser(),
        );
        await Navigator.push(context,
            MaterialPageRoute<bool>(builder: (context) => blocLabelProvider));*/
      },
      leading: Container(
        width: 24.0,
        height: 24.0,
      ),
      title: Text(" ${intro.title}"),
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
