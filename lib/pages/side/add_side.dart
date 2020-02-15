import 'package:flutter/material.dart';
import 'package:powa_doc/bloc/bloc_provider.dart';
import 'package:powa_doc/pages/side/side.dart';
import 'package:powa_doc/pages/side/side_bloc.dart';
import 'package:powa_doc/utils/app_util.dart';
import 'package:powa_doc/utils/collapsable_expand_tile.dart';
import 'package:powa_doc/utils/color_utils.dart';

class AddSide extends StatelessWidget {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final expansionTile = GlobalKey<CollapsibleExpansionTileState>();

  @override
  Widget build(BuildContext context) {
    ColorPalette currentSelectedPalette;

    final SideBloc sideBloc = BlocProvider.of(context);
    sideBloc.sideExist.listen((isExist) {
      if (isExist) {
        showSnackbar(_scaffoldState, "Side already exists");
      } else {
        Navigator.pop(context);
      }
    });

    String labelName = "";

    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text("Add side"),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.send,
            color: Colors.white,
          ),
          onPressed: () async {
            if (_formState.currentState.validate()) {
              _formState.currentState.save();

              var sideCategory = Side.create(labelName);
              sideBloc.checkIfSideExist(sideCategory);

            }
          }),
      body: ListView(
        children: <Widget>[
          Form(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(hintText: "Side Name"),
                maxLength: 20,
                validator: (value) {
                  return value.isEmpty ? "Label Cannot be empty" : null;
                },
                onSaved: (value) {
                  labelName = value;
                },
              ),
            ),
            key: _formState,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: StreamBuilder<ColorPalette>(
              stream: sideBloc.colorSelection,
              initialData: ColorPalette("Grey", Colors.grey.value),
              builder: (context, snapshot) {
                currentSelectedPalette = snapshot.data;
                return CollapsibleExpansionTile(
                  key: expansionTile,
                  leading: Icon(
                    Icons.label,
                    size: 16.0,
                    color: Color(currentSelectedPalette.colorValue),
                  ),
                  title: Text(currentSelectedPalette.colorName),
                  children: buildMaterialColors(sideBloc),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  List<Widget> buildMaterialColors(SideBloc sideBloc) {
    List<Widget> projectWidgetList = List();
    colorsPalettes.forEach((colors) {
      projectWidgetList.add(ListTile(
        leading: Icon(
          Icons.label,
          size: 16.0,
          color: Color(colors.colorValue),
        ),
        title: Text(colors.colorName),
        onTap: () {
          expansionTile.currentState.collapse();
          sideBloc.updateColorSelection(
            ColorPalette(colors.colorName, colors.colorValue),
          );
        },
      ));
    });
    return projectWidgetList;
  }
}
