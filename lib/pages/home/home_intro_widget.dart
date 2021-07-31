import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:powa_doc/bloc/bloc_provider.dart';

import 'package:powa_doc/pages/intro/intro.dart';
import 'package:powa_doc/pages/intro/intro_bloc.dart';
import 'package:powa_doc/pages/intro/intro_db.dart';
import 'package:powa_doc/pages/intro/IntroDetailsPage.dart';

class HomeIntroWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    IntroBloc introBloc = BlocProvider.of(context);
    return StreamBuilder<List<Intro>>(
      stream: introBloc.intro,
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
  final List<Intro> _intro;

  LabelExpansionTileWidget(this._intro);

  @override
  Widget build(BuildContext context) {
    buildSide(context);
    return SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: buildSide(context),
    )
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
    final IntroBloc introBloc = BlocProvider.of(context);
    IntroDB introDB;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20),
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          //print('Card tapped66.' + intro.id.toString());
          introBloc.getIntrolId2(intro);
          //print("Id:" + intro.id.toString());
          var blocLabelProvider = BlocProvider(
            bloc: IntroBloc(IntroDB.get()),
            child: IntroDetailsPage(intro: intro),
          );
          Navigator.push(context, MaterialPageRoute<bool>(builder:
              (context) => blocLabelProvider));
        },
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
                  intro.image,
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
                            intro.title,
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
        ),
    )
    );
  }

}

