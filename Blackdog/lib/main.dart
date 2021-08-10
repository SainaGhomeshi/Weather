import 'package:Blackdog/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Blackdog/screens/loading_screen.dart';

final storage = FlutterSecureStorage();
var all;
bool isLoggedIn;
void main() => runApp(Blackdog());

class Blackdog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: NavigatorClass(),
    );
  }
}

class NavigatorClass extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    _readAll().then((value) => {
      if(all!=null) {
        _readLogin(),
      }
    });

    return FutureBuilder(
        future: _getInfo(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            if(isLoggedIn == true){
              return LoadingScreen();
            }
            else
              return LogIn();
          }
          else{
            return Container(
              child: SpinKitDoubleBounce(
                size: 100.0,
                color: Colors.red,
              ),
            );
          }
        }

    );
      isLoggedIn?LoadingScreen():LogIn();
  }
  Future<bool> _getInfo() => Future.delayed(Duration(seconds: 1), () async {
    if ( isLoggedIn == null){
      isLoggedIn = false;
    }
    //await loadJsonData();
    return true;
  });
}

Future<Null> _readAll() async {
  all = await storage.readAll();
}

Future<Null> _readLogin() async {
  all.keys.contains('isLoggedIn')
      ? isLoggedIn = (await storage.read(key: 'isLoggedIn')).toLowerCase() == 'true'
      : isLoggedIn =  false;
  print(isLoggedIn);
}