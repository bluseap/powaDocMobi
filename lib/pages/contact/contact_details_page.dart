import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:powa_doc/pages/contact/contact.dart';
import 'package:powa_doc/pages/contact/contact_details_content.dart';
import 'package:powa_doc/pages/contact/contact_details_background.dart';

class ContactDetailsPage extends StatelessWidget {

  final Contact contact;

  const ContactDetailsPage({Key key, this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider<Contact>.value(
        value: contact,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ContactDetailsBackground(),
            ContactDetailsContent(),

          ],
        ),
      ),
    );
  }
}
