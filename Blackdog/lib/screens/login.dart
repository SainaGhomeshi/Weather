import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../main.dart';
import 'loading_screen.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController signinEmailController = TextEditingController();
  TextEditingController signinPasswordController = TextEditingController();
  GlobalKey<FormState> _signinFormKey = GlobalKey();
  bool _obscureTextSignin = true;
  void dispose() {
    signinEmailController.dispose();
    signinPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _hight = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          width: _width,
          height: _hight,
          color: Color(0xFFffffff),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 47),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(
                          _hight* 0.05),
                      child: Container(
                        width: _width - 50,
                        height: _width - 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/logo.jpg'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: _signinFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 12.0,
                          ),
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            controller: signinEmailController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              fillColor: Color(0xFFf2f5fa),
                              contentPadding: EdgeInsets.all(15),
                              hintText: "Email",
                              hintStyle: TextStyle(
                                  fontFamily: 'SegoeUI',
                                  fontSize: 15.0,
                                  color: Color(0xffabb0c6)),
                            ),
                            validator: (String email) {
                              if (email.isEmpty ||
                                  !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                      .hasMatch(email)) {
                                return 'Entering a correct email address is necessary';
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 25.0,
                          ),
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            controller: signinPasswordController,
                            obscureText: _obscureTextSignin,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              fillColor: Color(0xFFf2f5fa),
                              contentPadding: EdgeInsets.all(15),
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  fontFamily: 'SegoeUI',
                                  fontSize: 15.0,
                                  color: Color(0xffabb0c6)),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _obscureTextSignin = !_obscureTextSignin;
                                },
                                child: Icon(
                                  _obscureTextSignin
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  size: 15.0,
                                  color: Color(0xffabb0c6),
                                ),
                              ),
                            ),
                            validator: (String password) {
                              if (password.isEmpty && password.length < 4) {
                                return 'Please Enter a password with more than 4 letters';
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Builder(
                    builder: (context) => InkWell(
                      child: Container(
                        height: 53,
                        width: MediaQuery.of(context).size.width * 0.76,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.orange,
                                Colors.deepOrange,
                              ]),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child:Text(
                            'Log in',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "SegoeUI",
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xffffffff),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                      onTap:() async {
                        if (_signinFormKey.currentState.validate())
                          await storage.write(key: 'isLoggedIn', value: true.toString());
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return LoadingScreen();
                          }));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
