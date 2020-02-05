import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:powa_doc/bloc/bloc_provider.dart';
import 'package:powa_doc/pages/home/home_bloc.dart';
import 'package:powa_doc/pages/tasks/bloc/task_bloc.dart';

import 'package:powa_doc/pages/contact/contact_db.dart';
import 'package:powa_doc/pages/contact/contact.dart';
import 'package:powa_doc/pages/contact/contact_bloc.dart';


class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ContactBloc contactBloc = BlocProvider.of(context);
    return StreamBuilder<List<Contact>>(
      stream: contactBloc.contact,
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
  final List<Contact> _contact;

  LabelExpansionTileWidget(this._contact);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(Icons.info_outline),
      title: Text("Liên hệ",
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
      children: buildSide(context),
    );
  }

  List<Widget> buildSide(BuildContext context) {
    ContactBloc _contactBloc = BlocProvider.of(context);
    List<Widget> projectWidgetList = List();
    _contact.forEach((contact) => projectWidgetList.add(ContactRow(contact)));
    _contactBloc.refresh();
    return projectWidgetList;
  }
}

class ContactRow extends StatelessWidget {
  final Contact contact;

  ContactRow(this.contact);

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.of(context);
    return ListTile(
      onTap: () {
        homeBloc.applyFilter(" ${contact.title}", Filter.byLabel(contact.title));
        Navigator.pop(context);
      },
      leading: Container(
        width: 24.0,
        height: 24.0,
      ),
      title: Text(" ${contact.title}"),
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
