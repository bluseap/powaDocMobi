import 'package:flutter/material.dart';
import 'package:powa_doc/bloc/bloc_provider.dart';
import 'package:powa_doc/pages/home/home_bloc.dart';
import 'package:powa_doc/pages/about/about.dart';

import 'package:powa_doc/pages/intro/intro_db.dart';
import 'package:powa_doc/pages/intro/intro_bloc.dart';
import 'package:powa_doc/pages/intro/intro_widget.dart';

import 'package:powa_doc/pages/product/product_db.dart';
import 'package:powa_doc/pages/product/product_bloc.dart';
import 'package:powa_doc/pages/product/product_widget.dart';

import 'package:powa_doc/pages/customer/customer_db.dart';
import 'package:powa_doc/pages/customer/customer_bloc.dart';
import 'package:powa_doc/pages/customer/customer_widget.dart';

import 'package:powa_doc/pages/contact/contact_db.dart';
import 'package:powa_doc/pages/contact/contact_bloc.dart';
import 'package:powa_doc/pages/contact/contact_widget.dart';

import 'package:powa_doc/pages/home/StatefulLogin.dart';

import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SideDrawer extends StatefulWidget {
  @override
  _SideDrawer createState() => _SideDrawer();
}

class _SideDrawer extends State<SideDrawer> {
  String token = "";
  String useremail = "";
  String userid = "";
  String username = "";
  String avatar = "";
  String fullname = "";

  @override
  void initState() {
    super.initState();
    loginUser();
  }

  void loginUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "");
    useremail = (prefs.getString('useremail') ?? "");
    userid = (prefs.getString('userid') ?? "");
    username = (prefs.getString('username') ?? "");
    avatar = (prefs.getString('avatar') ?? "");
    fullname = (prefs.getString('fullname') ?? "");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    /*return StatefulLogin(
        onInit: () {
          _getLoginOnStartup().then((value) {});
          print("ten nguoi dung:" + username);
        },
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.all(0.0),
            children: <Widget>[
              Text("${username}"),
              /*UserAccountsDrawerHeader(
                accountName: Text(this.username),
                accountEmail: Text(useremail),
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
                    //backgroundImage: AssetImage("assets/profile_pic.jpg"),
                    backgroundImage: avatar != ""
                        ? NetworkImage("http://powaco.ddns.net" + avatar)
                        : AssetImage("assets/logoPOWA.png")),
              ),*/
              BlocProvider(bloc: IntroBloc(IntroDB.get()), child: IntroPage()),
              BlocProvider(
                  bloc: ProductBloc(ProductDB.get()), child: ProductPage()),
              BlocProvider(
                  bloc: CustomerBloc(CustomerDB.get()), child: CustomerPage()),
              BlocProvider(
                  bloc: ContactBloc(ContactDB.get()), child: ContactPage())
            ],
          ),
        ));*/
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("${username}"),
            accountEmail: Text(useremail),
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
                //backgroundImage: AssetImage("assets/profile_pic.jpg"),
                backgroundImage: avatar != ""
                    ? NetworkImage("http://powaco.ddns.net" + avatar)
                    : AssetImage("assets/logoPOWA.png")),
          ),
          BlocProvider(bloc: IntroBloc(IntroDB.get()), child: IntroPage()),
          /*BlocProvider(
              bloc: NewsBloc(NewsDB.get()),
              child: NewsPage()
          ),*/
          BlocProvider(
              bloc: ProductBloc(ProductDB.get()), child: ProductPage()),
          BlocProvider(
              bloc: CustomerBloc(CustomerDB.get()), child: CustomerPage()),
          BlocProvider(bloc: ContactBloc(ContactDB.get()), child: ContactPage())
        ],
      ),
    );
  }
}
