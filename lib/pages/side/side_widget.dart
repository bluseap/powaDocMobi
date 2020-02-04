import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:powa_doc/bloc/bloc_provider.dart';
import 'package:powa_doc/pages/tasks/bloc/task_bloc.dart';
import 'package:powa_doc/pages/side/side_db.dart';
import 'package:powa_doc/pages/side/side.dart';
import 'package:powa_doc/pages/home/home_bloc.dart';
import 'package:powa_doc/pages/side/add_side.dart';
import 'package:powa_doc/pages/side/side_bloc.dart';


class SidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SideBloc sideBloc = BlocProvider.of(context);
    return StreamBuilder<List<Side>>(
      stream: sideBloc.side,
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
  final List<Side> _side;

  LabelExpansionTileWidget(this._side);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(Icons.label),
      title: Text("Side Bar",
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
      children: buildSide(context),
    );
  }

  List<Widget> buildSide(BuildContext context) {
    SideBloc _sideBloc = BlocProvider.of(context);
    List<Widget> projectWidgetList = List();
    _side.forEach((side) => projectWidgetList.add(SideRow(side)));
    projectWidgetList.add(ListTile(
        leading: Icon(Icons.add),
        title: Text("Add Side Bar"),
        onTap: () async {
          Navigator.pop(context);
          var blocSideProvider = BlocProvider(
            bloc: SideBloc(SideDB.get()),//,
            child: AddSide()
          );
          await Navigator.push(context,
              MaterialPageRoute<bool>(builder: (context) => blocSideProvider));
          _sideBloc.refresh();
        }));
    return projectWidgetList;
  }
}

class SideRow extends StatelessWidget {
  final Side side;

  SideRow(this.side);

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.of(context);
    return ListTile(
      onTap: () {
        homeBloc.applyFilter("@ ${side.name}", Filter.byLabel(side.name));
        Navigator.pop(context);
      },
      leading: Container(
        width: 24.0,
        height: 24.0,
      ),
      title: Text("@@ ${side.name}"),
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
