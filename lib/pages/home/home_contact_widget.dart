import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:powa_doc/bloc/bloc_provider.dart';
import 'package:powa_doc/pages/home/home_bloc.dart';
import 'package:powa_doc/pages/tasks/bloc/task_bloc.dart';

import 'package:powa_doc/pages/contact/contact_db.dart';
import 'package:powa_doc/pages/contact/contact.dart';
import 'package:powa_doc/pages/contact/contact_bloc.dart';
import 'package:powa_doc/pages/contact/contact_details_content.dart';

class HomeContactWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ContactBloc contactBloc = BlocProvider.of(context);

    return StreamBuilder<List<Contact>>(
      stream: contactBloc.contact,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
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
    buildSide(context);
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buildSide(context),
        )
    );

    /*return ExpansionTile(
      leading: Icon(Icons.turned_in_not),
      title: Text("Giới thiệu",
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
      children: buildSide(context),
    );*/
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

    return Card(
        margin: const EdgeInsets.symmetric(vertical: 20),
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
                child: Image.asset(
                  contact.image,
                  height: 150,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            contact.title,
                            //style: eventTitleTextStyle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FittedBox(
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.location_on),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Long Xuyên",
                                  //style: eventLocationTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "An Giang",
                        textAlign: TextAlign.right,
                        //style: eventLocationTextStyle.copyWith(                  fontWeight: FontWeight.w900,
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        )
    );
  }

}
