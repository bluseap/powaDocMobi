import 'package:flutter/material.dart';
import 'package:powa_doc/bloc/bloc_provider.dart';
import 'package:powa_doc/pages/home/home_bloc.dart';
import 'package:powa_doc/pages/about/about.dart';

import 'package:powa_doc/pages/labels/label_db.dart';
import 'package:powa_doc/pages/labels/label_bloc.dart';
import 'package:powa_doc/pages/labels/label_widget.dart';

import 'package:powa_doc/pages/side/side_db.dart';
import 'package:powa_doc/pages/side/side_bloc.dart';
import 'package:powa_doc/pages/side/side_widget.dart';

import 'package:powa_doc/pages/intro/intro_db.dart';
import 'package:powa_doc/pages/intro/intro_bloc.dart';
import 'package:powa_doc/pages/intro/intro_widget.dart';

import 'package:powa_doc/pages/news/news_db.dart';
import 'package:powa_doc/pages/news/news_bloc.dart';
import 'package:powa_doc/pages/news/news_widget.dart';

import 'package:powa_doc/pages/product/product_db.dart';
import 'package:powa_doc/pages/product/product_bloc.dart';
import 'package:powa_doc/pages/product/product_widget.dart';

import 'package:powa_doc/pages/customer/customer_db.dart';
import 'package:powa_doc/pages/customer/customer_bloc.dart';
import 'package:powa_doc/pages/customer/customer_widget.dart';

import 'package:powa_doc/pages/contact/contact_db.dart';
import 'package:powa_doc/pages/contact/contact_bloc.dart';
import 'package:powa_doc/pages/contact/contact_widget.dart';


class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    HomeBloc homeBloc = BlocProvider.of(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Burhanuddin Rashid"),
            accountEmail: Text("burhanrashid5253@gmail.com"),
            otherAccountsPictures: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.info,
                    color: Colors.white,
                    size: 36.0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<bool>(
                          builder: (context) => AboutUsScreen()),
                    );
                  })
            ],
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              backgroundImage: AssetImage("assets/profile_pic.jpg"),
            ),
          ),
          BlocProvider(
              bloc: IntroBloc(IntroDB.get()),
              child: IntroPage()
          ),
          /*BlocProvider(
              bloc: NewsBloc(NewsDB.get()),
              child: NewsPage()
          ),*/
          BlocProvider(
              bloc: ProductBloc(ProductDB.get()),
              child: ProductPage()
          ),
          BlocProvider(
              bloc: CustomerBloc(CustomerDB.get()),
              child: CustomerPage()
          ),
          BlocProvider(
              bloc: ContactBloc(ContactDB.get()),
              child: ContactPage()
          )
          /*ListTile(
              leading: Icon(Icons.inbox),
              title: Text("Inbox"),
              onTap: () {
                var project = Project.getInbox();
                homeBloc.applyFilter(
                    project.name, Filter.byProject(project.id));
                Navigator.pop(context);
              }),
          ListTile(
              onTap: () {
                homeBloc.applyFilter("Today", Filter.byToday());
                Navigator.pop(context);
              },
              leading: Icon(Icons.calendar_today),
              title: Text("Today")),
          ListTile(
            onTap: () {
              homeBloc.applyFilter("Next 7 Days", Filter.byNextWeek());
              Navigator.pop(context);
            },
            leading: Icon(Icons.calendar_today),
            title: Text("Next 7 Days"),
          ),
          BlocProvider(
            bloc: ProjectBloc(ProjectDB.get()),
            child: ProjectPage(),
          ),*/
          /*BlocProvider(
            bloc: LabelBloc(LabelDB.get()),
            child: LabelPage(),
          ),
          BlocProvider(
            bloc: SideBloc(SideDB.get()),
            child: SidePage(),
          )*/
        ],
      ),
    );
  }
}
