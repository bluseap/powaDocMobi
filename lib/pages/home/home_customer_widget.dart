import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:powa_doc/bloc/bloc_provider.dart';

import 'package:powa_doc/pages/customer/customer.dart';
import 'package:powa_doc/pages/customer/customer_bloc.dart';
import 'package:powa_doc/pages/customer/customer_db.dart';
import 'package:powa_doc/pages/customer/customer_details_page.dart';

class HomeCustomerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CustomerBloc customerBloc = BlocProvider.of(context);
    return StreamBuilder<List<Customer>>(
      stream: customerBloc.customer,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LabelExpansionTileWidget(snapshot.data);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class LabelExpansionTileWidget extends StatelessWidget {
  final List<Customer> _customer;

  LabelExpansionTileWidget(this._customer);

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
    CustomerBloc _customerBloc = BlocProvider.of(context);
    List<Widget> projectWidgetList = List();
    _customer.forEach((customer) => projectWidgetList.add(CustomerRow(customer)));
    _customerBloc.refresh();
    return projectWidgetList;
  }
}

class CustomerRow extends StatelessWidget {
  final Customer customer;

  CustomerRow(this.customer);

  @override
  Widget build(BuildContext context) {
    final CustomerBloc customerBloc = BlocProvider.of(context);

    return Card(
        margin: const EdgeInsets.symmetric(vertical: 20),
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            //print('Card tapped66.' + intro.id.toString());
            customerBloc.getCustomerId2(customer);
            //print("Id:" + intro.id.toString());
            var blocLabelProvider = BlocProvider(
              bloc: CustomerBloc(CustomerDB.get()),
              child: CustomerDetailsPage(customer: customer),
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
                    customer.image,
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
                              customer.title,
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

