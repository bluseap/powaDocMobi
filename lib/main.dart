import 'package:flutter/material.dart';
import 'package:powa_doc/bloc/bloc_provider.dart';
import 'package:powa_doc/pages/home/home.dart';
import 'package:powa_doc/pages/home/home_bloc.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Powaco',
      theme: ThemeData(
          primaryColor: const Color(0xFFFF4700),
          accentColor: Colors.orange
      ),
      home: BlocProvider(
          bloc: HomeBloc(),
          child: HomePage()
      ),

      /*home: MyHomePage(
          title: 'Flutter Demo Home Page'
      ),*/
    );
  }



}
