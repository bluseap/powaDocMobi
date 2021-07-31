import 'package:flutter/material.dart';
import 'package:powa_doc/models/category.dart';
import 'package:powa_doc/pages/contact/contact_bloc.dart';
import 'package:powa_doc/pages/contact/contact_db.dart';
import 'package:powa_doc/pages/customer/customer_bloc.dart';
import 'package:powa_doc/pages/customer/customer_db.dart';
import 'package:powa_doc/pages/home/category_widget.dart';
import 'package:powa_doc/pages/home/home_intro_widget.dart';
import 'package:powa_doc/pages/product/product_bloc.dart';
import 'package:powa_doc/pages/product/product_db.dart';

import 'package:provider/provider.dart';

import 'home_contact_widget.dart';
import 'home_customer_widget.dart';
import 'home_page_background.dart';

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

//import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:powa_doc/bloc/bloc_provider.dart';

import 'package:powa_doc/app_state.dart';

import 'package:powa_doc/pages/registerdoc/registerdoc_user.dart';

import 'package:powa_doc/pages/home/home_bloc.dart';
import 'package:powa_doc/pages/home/side_drawer.dart';

import 'package:powa_doc/pages/side/side.dart';
import 'package:powa_doc/pages/side/side_db.dart';

import 'package:powa_doc/pages/intro/intro_bloc.dart';
import 'package:powa_doc/pages/intro/intro_db.dart';

import 'package:powa_doc/utils/collapsable_expand_tile.dart';

//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'home_product_widget.dart';

import 'package:powa_doc/pages/login/login.dart';
import 'package:powa_doc/pages/login/apiresponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  //final TaskBloc _taskBloc = TaskBloc(TaskDB.get());
  final expansionTile = GlobalKey<CollapsibleExpansionTileState>();

  // ignore: unused_field
  SideDB _sideDB = SideDB.get();

  //ApiResponse _apiResponse = new ApiResponse();

  String token;
  String useremail;
  String userid;
  String username;
  String avatar;
  String fullname;

  void loginUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "");
    useremail = (prefs.getString('useremail') ?? "");
    userid = (prefs.getString('userid') ?? "");
    username = (prefs.getString('username') ?? "");
    avatar = (prefs.getString('avatar') ?? "");
    fullname = (prefs.getString('fullname') ?? "");
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of(context);

    /*@protected
    @mustCallSuper
    // ignore: unused_element
    initState() {
      //loginUser();
      print("print call supper");
    }*/

    // ignore: unused_element
    void _showDialog(messnger) {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Alert Dialog title"),
            content: new Text('ff ' + messnger),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              // ignore: deprecated_member_use
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<String>(
            initialData: 'Powaco',
            stream: homeBloc.title,
            builder: (context, snapshot) {
              return Text(snapshot.data);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
        onPressed: () async {
          var blocLabelProvider = BlocProvider(
            bloc: IntroBloc(IntroDB.get()),
            child: RegisterDocUser(),
          );
          await Navigator.push(context,
              MaterialPageRoute<bool>(builder: (context) => blocLabelProvider));
        },
      ),
      drawer: SideDrawer(),
      body: ChangeNotifierProvider<AppState>(
          create: (_) => AppState(),
          child: Stack(children: <Widget>[
            HomePageBackground(
              screenHeight: MediaQuery.of(context).size.height,
            ),
            SafeArea(
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Consumer<AppState>(
                      builder: (context, appState, _) => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            for (final category in categories)
                              CategoryWidget(category: category)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Consumer<AppState>(
                      builder: (context, appState, _) => Column(
                        children: <Widget>[
                          if (appState.selectedCategoryId.toString() == "1")
                            BlocProvider(
                                bloc: IntroBloc(IntroDB.get()),
                                child: HomeIntroWidget()),
                          if (appState.selectedCategoryId.toString() == "3")
                            BlocProvider(
                                bloc: ProductBloc(ProductDB.get()),
                                child: HomeProductWidget()),
                          if (appState.selectedCategoryId.toString() == "4")
                            BlocProvider(
                                bloc: CustomerBloc(CustomerDB.get()),
                                child: HomeCustomerWidget()),
                          if (appState.selectedCategoryId.toString() == "5")
                            BlocProvider(
                                bloc: ContactBloc(ContactDB.get()),
                                child: HomeContactWidget())
                        ],
                      ),
                    ),
                  )
                ]))),
          ])),
    );
  }

// This menu button widget updates a _selection field (of type WhyFarther,
// not shown here).
  Widget buildPopupMenu(BuildContext context) {
    return PopupMenuButton<MenuItem>(
      onSelected: (MenuItem result) async {
        switch (result) {
          case MenuItem.taskCompleted:
            await Navigator.push(
                context,
                MaterialPageRoute<bool>(
                    builder: (context) =>
                        const Text('Completed Tasks')) //TaskCompletedPage()),
                );
            //_taskBloc.refresh();
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItem>>[
        const PopupMenuItem<MenuItem>(
          value: MenuItem.taskCompleted,
          child: const Text('Completed Tasks'),
        )
      ],
    );
  }
}

// This is the type used by the popup menu below.
enum MenuItem { taskCompleted }

Future<List<Side>> fetchSide(http.Client client) async {
  final response =
      await client.get('http://192.168.1.19:88/api/vi-VN/categorynews/1');
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseSide, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Side> parseSide(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Side>((json) => Side.fromJson(json)).toList();
}

class SideList extends StatelessWidget {
  final List<Side> side;
  SideList({Key key, this.side}) : super(key: key);
  SideDB _sideDB = SideDB.get();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: side.length,
      // ignore: missing_return
      itemBuilder: (context, index) {
        //_sideDB.insertSide(side[index].name);
        //return Text(side[index].name);
      },
    );
  }
}
