import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:powa_doc/pages/customer/customer.dart';
import 'package:powa_doc/pages/customer/customer_details_content.dart';
import 'package:powa_doc/pages/customer/customer_details_background.dart';

class CustomerDetailsPage extends StatelessWidget {

  final Customer customer;

  const CustomerDetailsPage({Key key, this.customer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider<Customer>.value(
        value: customer,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            CustomerDetailsBackground(),
            CustomerDetailsContent(),

          ],
        ),
      ),
    );
  }
}
