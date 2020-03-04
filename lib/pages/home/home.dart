import 'package:flutter/material.dart';
import 'package:powa_doc/bloc/bloc_provider.dart';
import 'package:powa_doc/pages/home/home_bloc.dart';
import 'package:powa_doc/pages/home/side_drawer.dart';
import 'package:powa_doc/models/category.dart';
import 'package:powa_doc/models/event.dart';
import 'package:powa_doc/models/guest.dart';
import 'package:powa_doc/utils/styleguide.dart';
import 'package:powa_doc/pages/event_details/event_details_page.dart';
import 'package:provider/provider.dart';
import 'package:powa_doc/models/event.dart';

import 'package:powa_doc/app_state.dart';
import 'category_widget.dart';
import 'event_widget.dart';
import 'home_page_background.dart';

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:powa_doc/pages/side/side.dart';
import 'package:powa_doc/pages/side/side_bloc.dart';
import 'package:powa_doc/utils/collapsable_expand_tile.dart';

import 'package:powa_doc/utils/app_util.dart';
import 'package:powa_doc/pages/side/side_db.dart';

import 'package:powa_doc/pages/registerdoc/registerdoc_user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:powa_doc/bloc/bloc_provider.dart';
import 'package:powa_doc/pages/intro/intro_bloc.dart';
import 'package:powa_doc/pages/intro/intro_db.dart';
import 'package:powa_doc/pages/intro/intro.dart';
import 'package:powa_doc/pages/home/home_intro_widget.dart';

import 'package:powa_doc/pages/product/product_bloc.dart';
import 'package:powa_doc/pages/product/product_db.dart';
import 'package:powa_doc/pages/product/product.dart';
import 'package:powa_doc/pages/home/home_product_widget.dart';

import 'package:powa_doc/pages/customer/customer_bloc.dart';
import 'package:powa_doc/pages/customer/customer_db.dart';
import 'package:powa_doc/pages/customer/customer.dart';
import 'package:powa_doc/pages/home/home_customer_widget.dart';

import 'package:powa_doc/pages/contact/contact_bloc.dart';
import 'package:powa_doc/pages/contact/contact_db.dart';
import 'package:powa_doc/pages/contact/contact.dart';
import 'package:powa_doc/pages/home/home_contact_widget.dart';

class HomePage extends StatelessWidget {
  //final TaskBloc _taskBloc = TaskBloc(TaskDB.get());
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final expansionTile = GlobalKey<CollapsibleExpansionTileState>();

  SideDB _sideDB = SideDB.get();

  String _message = '';
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    getMessage();
  }
  void getMessage(){
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('on message $message');
          //setState(() => _message = message["notification"]["title"]);

        },
        onResume: (Map<String, dynamic> message) async {
          print('on resume $message');
          //setState(() => _message = message["notification"]["title"]);

        },
        onLaunch: (Map<String, dynamic> message) async {
          print('on launch $message');
          //setState(() => _message = message["notification"]["title"]);

        }
    );
  }



  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of(context);

    String mess = context.toString();
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

    Intro intro;
    Product product;
    Customer customer;
    Contact contact;

    /*homeBloc.filter.listen((filter) {
      _taskBloc.updateFilters(filter);
    });*/
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<String>(
            initialData: 'Powaco',
            stream: homeBloc.title,
            builder: (context, snapshot) {
              return Text(snapshot.data);
            }),
        //actions: <Widget>[buildPopupMenu(context)],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
        onPressed: () async {

          /*Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RegisterDocUser(),

            ),
          );*/
          var blocLabelProvider = BlocProvider(
            bloc: IntroBloc(IntroDB.get()),
            child: RegisterDocUser(),
          );
          await Navigator.push(context,
              MaterialPageRoute<bool>(builder: (context) => blocLabelProvider));

          //_sideDB.insertSide("Xuân Đào Minh");
          //_showDialog(mess);
          /*final SideBloc sideBloc = BlocProvider.of(context);
          sideBloc.sideExist.listen((isExist) {
            if (isExist) {
              showSnackbar(_scaffoldState, "Side already exists");
            } else {
              Navigator.pop(context);
            }
          });
          */

        },
      ),
      drawer: SideDrawer(),
      body: ChangeNotifierProvider<AppState>(
        create: (_) => AppState(),
        child: Stack(
          children: <Widget>[
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
                              for (final category in categories) CategoryWidget(category: category)
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
                                  child: HomeIntroWidget()
                              ),

                            if (appState.selectedCategoryId.toString() == "3")
                              BlocProvider(
                                  bloc: ProductBloc(ProductDB.get()),
                                  child: HomeProductWidget()
                              ),

                            if (appState.selectedCategoryId.toString() == "4")
                              BlocProvider(
                                  bloc: CustomerBloc(CustomerDB.get()),
                                  child: HomeCustomerWidget()
                              ),

                            if (appState.selectedCategoryId.toString() == "5")
                              BlocProvider(
                                  bloc: ContactBloc(ContactDB.get()),
                                  child: HomeContactWidget()
                              )


                            /*for (final event in events.where((e) => e.categoryIds.contains(appState.selectedCategoryId)))
                              GestureDetector(
                                onTap: () {
                                  //print(appState.selectedCategoryId.toString());
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => EventDetailsPage(event: event),
                                    ),
                                  );
                                },
                                child: EventWidget(
                                  event: event,
                                ),
                              )*/

                          ],
                        ),
                      ),
                    )

                  ]

                )

              )
            ),
            /*FutureBuilder<List<Side>>(
                future: fetchSide(http.Client()),
                builder: (context, snapshot) {

                  //_sideDB.insertSide("Xuân Đào Minh 2");

                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? SideList(side: snapshot.data)
                      : Center(child: CircularProgressIndicator());
                }
            )*/
          ]
        )

      ),
      /*body: BlocProvider(
        bloc: _taskBloc,
        child: TasksPage(),
      )*/

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
                  builder: (context) => const Text('Completed Tasks'))//TaskCompletedPage()),
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
      itemBuilder: (context, index) {
        //_sideDB.insertSide(side[index].name);
        //return Text(side[index].name);
      },
    );
  }
}


