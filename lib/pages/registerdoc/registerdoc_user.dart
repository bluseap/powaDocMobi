import 'package:flutter/material.dart';

import 'package:powa_doc/pages/registerdoc/registerdoc.dart';
//import 'package:powa_doc/pages/registerdoc/registerdoc_bloc.dart';
import 'package:powa_doc/utils/app_util.dart';
import 'package:powa_doc/utils/collapsable_expand_tile.dart';
import 'package:powa_doc/utils/color_utils.dart';

import 'package:powa_doc/pages/intro/intro.dart';
import 'package:powa_doc/pages/intro/intro_bloc.dart';
import 'package:powa_doc/pages/intro/intro_db.dart';
import 'package:sqflite/sqflite.dart';

import 'package:powa_doc/db/app_db.dart';

import 'package:giffy_dialog/giffy_dialog.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/services.dart';
import 'package:imei_plugin/imei_plugin.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'dart:io';
import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;

import 'package:powa_doc/bloc/bloc_provider.dart';

class RegisterDocUser extends StatefulWidget {
  RegisterDocUser() : super();

  @override
  DropDownState createState() => DropDownState();
}
class DropDownState extends State<RegisterDocUser> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final expansionTile = GlobalKey<CollapsibleExpansionTileState>();

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final txtUserName = TextEditingController();
  final txtPass = TextEditingController();

  static var uri = "http://192.168.1.19:88";
  static BaseOptions options = BaseOptions(
      baseUrl: uri,
      responseType: ResponseType.plain,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      validateStatus: (code) {
        if (code >= 200) {
          return true;
        }
      });
  static Dio dio = Dio(options);
  bool _isLoading = false;
  String firebasenotifiId = "";

  String _platformImei = 'Unknown';

  List<RegisterName> _registerName = RegisterName.getRegisterName();
  List<DropdownMenuItem<RegisterName>> _dropdownMenuItems;
  RegisterName _selectedRegisterName;
  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_registerName);
    _selectedRegisterName = _dropdownMenuItems[0].value;
    super.initState();
    initPlatformState();
    getMessage();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformImei;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformImei = await ImeiPlugin.getImei( shouldShowRequestPermissionRationale: false );
    } on PlatformException {
      platformImei = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _platformImei = platformImei;
    });
  }

  List<DropdownMenuItem<RegisterName>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<RegisterName>> items = List();
    for (RegisterName company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  int selectId = 1;
  String selectName = "Văn bản";
  onChangeDropdownItem(RegisterName selectedCompany) {
    setState(() {
      _selectedRegisterName = selectedCompany;
      selectId = selectedCompany.id;
      selectName = selectedCompany.name;
    });
  }

  String _message = '';
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _register() {
    _firebaseMessaging.getToken().then(
            (token) => print(token)
    );
  }

  void getMessage(){
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('1 on message $message');
          setState(() => _message = message["notification"]["title"]);

        },
        onResume: (Map<String, dynamic> message) async {
          print('2 on resume $message');
          setState(() => _message = message["notification"]["title"]);
        },
        onLaunch: (Map<String, dynamic> message) async {
          print('3 on launch $message');
          setState(() => _message = message["notification"]["title"]);
        }
    );
  }

    @override
    Widget build(BuildContext context) {

      IntroBloc introBloc = BlocProvider.of(context);

      final FieldUserName = TextField(
        controller: txtUserName,
        obscureText: false,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Người dùng",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),

        ),
      );
      final FieldPass = TextField(
        controller: txtPass,
        obscureText: true,
        style: style,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Mật mã",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
        ),
      );
      final registerNameCode = DropdownButton(
        value: _selectedRegisterName,
        items: _dropdownMenuItems,
        onChanged: onChangeDropdownItem,
      );
      final loginButon = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: const Color(0xFFFF4700),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            signIn(txtUserName.text, txtPass.text, _platformImei);

            /*showDialog(
            context: context,
            builder: (_) => NetworkGiffyDialog (
              image: Image.network("https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif", fit: BoxFit.cover),
              title: Text('Granny Eating Chocolate', textAlign: TextAlign.center, style: TextStyle(
                    fontSize: 22.0, fontWeight: FontWeight.w600 )
              ),
              description:Text('This is a granny eating chocolate dialog box.' + txtUserName.text + '-' +txtPass.text + '-' +
                  selectId.toString() + '-' + selectName + "- Imei: " + _platformImei,
                textAlign: TextAlign.center
              ),
              onOkButtonPressed: () {
                Navigator.of(context).pop();

              }
            )
          );*/

          },
          child: Text("Đăng ký nhận tin",
              textAlign: TextAlign.center,
              style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)
          ),
        ),
      );

      return Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          title: Text("Đăng ký nhận tin"),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.near_me,
              color: Colors.white,
            ),
            onPressed: () async {
              //if (_formState.currentState.validate()) {
               // _formState.currentState.save();

                var intro = Intro.create(
                    1,1,"PO", "Tiêu đề giới hiệu", "Mô tả công ty", "2019/1/1", "2019/2/2"        );
                print(intro.description);

                //introBloc.checkIfIntroExist(intro);

                showDialog(
                    context: context,
                    builder: (_) => NetworkGiffyDialog (
                        image: Image.asset("assets/logoPOWA.png"),
                        title: Text('Thêm mới Giới thiệu', textAlign: TextAlign.center, style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.w600,
                            color: Colors.lightBlue )
                        ),
                        description:Text('Thêm mới Giới thiệu thành công.',
                            textAlign: TextAlign.center
                        ),
                        onOkButtonPressed: () {
                          Navigator.of(context).pop();
                        }
                    )
                );

              //}

            }),
        body: Container(
          alignment: Alignment.bottomCenter,
          child: Stack(
              children: <Widget>[
                SafeArea(
                  //color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 90.0,
                          child: Image.asset(
                            "assets/logoPOWA.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        FieldUserName,
                        SizedBox(height: 20.0),
                        FieldPass,
                        SizedBox(height: 20.0),
                        registerNameCode,
                        SizedBox(height: 30.0),
                        loginButon,

                      ],
                    ),
                  ),
                ),
                /*FutureBuilder<List<RegisterDoc>>(
                future: fetchRegisterDoc(http.Client()),
                builder: (context, snapshot) {
                  //_sideDB.insertSide("Xuân Đào Minh 2");
                  if (snapshot.hasError)
                    print(snapshot.error);
                  return snapshot.hasData
                      ? RegisterDocList(registerdoc: snapshot.data)
                      : Center(child: CircularProgressIndicator());
                }
            )*/
              ]
          ),
        ),


      );
    }

    List<Widget> buildMaterialColors() {
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
            /*labelBloc.updateColorSelection(
            ColorPalette(colors.colorName, colors.colorValue),
          );*/
          },
        ));
      });
      return projectWidgetList;
    }

    signIn(String email, pass, platformImei) async {
      Options options = Options(
        contentType: "application/json",
      );
      Response response = await dio.post('/api/loginpodoc/lgpodoc',
          data: {"UserName": email, "Password": pass}, options: options);

      /*print(response.statusCode.toString());
    print(response.headers.toString());
    print(response.data.toString());
    print(email+'-'+pass);*/
     // print(email+'-'+pass);

      if(response.statusCode == 200) {
        _firebaseMessaging.getToken().then(
                (token) => {
              firebasenotifiId = token//, print(token)
            }
        );
        //print("imei2:" + firebasenotifiId);
        //print("Imei:" + platformImei);

        addRegisterDoc(firebasenotifiId, email, "1", "POWADOC", platformImei, "vi-VN");

        /* showDialog(
            context: context,
            builder: (_) => NetworkGiffyDialog (
                //image: Image.network("https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif", fit: BoxFit.cover),
                title: Text('Granny Eating Chocolate', textAlign: TextAlign.center, style: TextStyle(
                    fontSize: 22.0, fontWeight: FontWeight.w600 )
                ),
                description:Text('Đăng nhập thành công.',
                    textAlign: TextAlign.center
                ),
                onOkButtonPressed: () {
                  Navigator.of(context).pop();
                }
            )
        );*/

      }
      else {
        setState(() {
          _isLoading = false;
        });
        print("Lỗi...");
      }
    }

    //softname = "POWADOC"; culture = "vi-VN"
    addRegisterDoc(firebasenotifiId, username, softid, softname, platformImei, culture) async {
      Options options = Options(
        contentType: "application/json",
      );

      Response response = await dio.post('/api/registerdoc?firebasenotifiId=' + firebasenotifiId + '&username=' + username + '&softId=' + softid + '&softName=' + softname + '&platformImei=' + platformImei + '&culture=vi-VN');
      ///api/registerdoc?firebasenotifiId=e&username=lenguyen&softId=1&softName=22&eee=r2&culture=vi-VN
      //print(firebasenotifiId + "-" + username+ "-" + softid+ "-" + softname+ "-" + platformImei+ "-" + culture);

      //print(response.statusCode);
      if(response.statusCode == 200) {
        showDialog(
            context: context,
            builder: (_) => NetworkGiffyDialog (
              //image: Image.network("https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif", fit: BoxFit.cover),
                image: Image.asset("assets/logoPOWA.png"),
                title: Text('Đăng ký nhận tin', textAlign: TextAlign.center, style: TextStyle(
                    fontSize: 22.0, fontWeight: FontWeight.w600 )
                ),
                description:Text('Đăng ký thành công.',
                    textAlign: TextAlign.center
                ),
                onOkButtonPressed: () {
                  Navigator.of(context).pop();
                }
            )
        );
      }
      else {
        setState(() {
          _isLoading = false;
        });
        showDialog(
            context: context,
            builder: (_) => NetworkGiffyDialog (
                image: Image.asset("assets/logoPOWA.png"),
                title: Text('Đăng ký lỗi', textAlign: TextAlign.center, style: TextStyle(
                    fontSize: 22.0, fontWeight: FontWeight.w600,
                    color: Colors.red )
                ),
                description:Text('Đăng ký lỗi! Kiểm tra lại.',
                    textAlign: TextAlign.center
                ),
                onOkButtonPressed: () {
                  Navigator.of(context).pop();
                }
            )
        );
      }
    }
  }


Future<List<RegisterDoc>> fetchRegisterDoc(http.Client client) async {
  final response =  await client.get('http://192.168.1.19:88/api/vi-VN/categorynews/1');
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseRegisterDoc, response.body);
}

// A function that converts a response body into a List<Photo>.
List<RegisterDoc> parseRegisterDoc(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<RegisterDoc>((json) => RegisterDoc.fromJson(json)).toList();
}

class RegisterDocList extends StatelessWidget {
  final List<RegisterDoc> registerdoc;
  RegisterDocList({Key key, this.registerdoc}) : super(key: key);
  //SideDB _sideDB = SideDB.get();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: registerdoc.length,
      itemBuilder: (context, index) {
        //_sideDB.insertSide(side[index].name);
        return Text(registerdoc[index].tendangky);
      },
    );
  }
}




class RegisterName {
  int id;
  String name;

  RegisterName(this.id, this.name);

  static List<RegisterName> getRegisterName() {
    return <RegisterName>[
      RegisterName(1, 'Văn bản'),
      RegisterName(2, 'Nhân sự'),
      RegisterName(3, 'Android'),
      RegisterName(4, 'Apple'),
      RegisterName(5, 'LG'),
    ];
  }
}