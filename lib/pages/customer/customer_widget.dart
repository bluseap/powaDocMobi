import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:powa_doc/bloc/bloc_provider.dart';
import 'package:powa_doc/pages/home/home_bloc.dart';
import 'package:powa_doc/pages/tasks/bloc/task_bloc.dart';

import 'package:powa_doc/pages/customer/customer_db.dart';
import 'package:powa_doc/pages/customer/customer.dart';
import 'package:powa_doc/pages/customer/customer_bloc.dart';


class CustomerPage extends StatelessWidget {
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
    return ExpansionTile(
      leading: Icon(Icons.dialpad),
      title: Text("Khách hàng",
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
      children: buildSide(context),
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
    HomeBloc homeBloc = BlocProvider.of(context);
    return ListTile(
      onTap: () {
        homeBloc.applyFilter(" ${customer.title}", Filter.byLabel(customer.title));
        Navigator.pop(context);
      },
      leading: Container(
        width: 24.0,
        height: 24.0,
      ),
      title: Text(" ${customer.title}"),
      trailing: Container(
        height: 10.0,
        width: 10.0,
        child: Icon(
          Icons.label,
          size: 16.0,
          // color: Color(side.colorCode),
        ),
      ),
    );
  }

}
