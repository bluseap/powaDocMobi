import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:powa_doc/bloc/bloc_provider.dart';

import 'package:powa_doc/pages/intro/intro.dart';
import 'package:powa_doc/pages/intro/intro_bloc.dart';
import 'package:powa_doc/pages/intro/intro_details_content.dart';
import 'package:powa_doc/pages/intro/intro_details_background.dart';

class IntroDetailsPage extends StatelessWidget {

  final Intro intro;

  const IntroDetailsPage({Key key, this.intro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider<Intro>.value(
        value: intro,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            IntroDetailsBackground(),
            IntroDetailsContent(),

          ],
        ),
      ),
    );
  }
}
