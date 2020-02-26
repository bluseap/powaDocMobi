import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:powa_doc/pages/contact/contact.dart';
import 'package:powa_doc/pages/contact/contact_bloc.dart';

import '../../models/guest.dart';
import 'package:powa_doc/utils/styleguide.dart';

class ContactDetailsContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final contact = Provider.of<Contact>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
            child: Text(
              contact.title,
              style: eventWhiteTitleTextStyle,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.24),
            child: FittedBox(
              child: Row(
                children: <Widget>[
                  Text(
                    "-",
                    style: eventLocationTextStyle.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    contact.title,
                    style: eventLocationTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "",
              style: guestTextStyle,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                for (final guest in guests)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ClipOval(
                      child: Image.asset(
                        guest.imagePath,
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: RichText(
              text: TextSpan(
                  children: [
                    TextSpan(text: contact.title, style: punchLine1TextStyle,),
                    //TextSpan(text: intro.title, style: punchLine2TextStyle,),
                  ]
              ),
            ),
          ),
          if (contact.description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(contact.description, style: eventLocationTextStyle,),
            ),


        ],
      ),
    );
  }
}
