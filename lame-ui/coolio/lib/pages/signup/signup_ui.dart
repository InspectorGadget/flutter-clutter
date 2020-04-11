import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: Colors.white,
        constraints: BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Container(
                height: _screenSize.height * 0.35,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 0,
                      top: 0,
                      right: 0,
                      bottom: 40,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),),
                            // gradient: LinearGradient(
                            //   begin: Alignment(0.4, 0.5),
                            //   end: Alignment(1, -2.899),
                            //   stops: [0, 1],
                            //   colors: [Colors.black, Colors.white],
                            // ),
                            color: Colors.red[500]
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.black,
                            //     blurRadius: 0.0,
                            //     spreadRadius: 1,
                            //     offset: Offset(
                            //       0.9,
                            //       0.9,
                            //     ), // shadow direction: bottom right
                            //   )
                            // ],
                            ),
                        child: Container(
                          padding:
                              EdgeInsets.only(top: 35, left: 15, right: 15),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: RawMaterialButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Icon(
                                          Icons.arrow_left,
                                          color: Colors.white,
                                          size: 40.0,
                                        ),
                                        elevation: 2.0,
                                        padding: EdgeInsets.all(15.0),
                                      ),
                                    ),
                                    Container(
                                      child: RawMaterialButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed('home');
                                        },
                                        child: Icon(
                                          Icons.home,
                                          color: Colors.white,
                                          size: 40.0,
                                        ),
                                        elevation: 2.0,
                                        padding: EdgeInsets.all(15.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Hero(
                                      tag: 'logo',
                                      child: Container(
                                        child: Icon(
                                          Icons.arrow_right,
                                          size: 90,
                                        ),
                                      ),
                                    ),
                                    // Text(
                                    //   "Register your account",
                                    //   textAlign: TextAlign.center,
                                    //   style: TextStyle(
                                    //     color: Colors.white,
                                    //     fontWeight: FontWeight.w300,
                                    //     fontSize: 25,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  _emailTextField(),
                  SizedBox(height: 20.0),
                  _passwordTextField(),
                  SizedBox(height: 20.0),
                  _loginButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      autocorrect: false,
      style: TextStyle(
        color: Colors.black,
      ),
      validator: (_input) {
        return _input.length != 0 && _input.contains('@')
            ? null
            : 'Please enter a valid email';
      },
      onSaved: (_input) {
        setState(() {
          _email = _input;
        });
      },
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: 'Email Address',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      autocorrect: false,
      obscureText: true,
      style: TextStyle(
        color: Colors.black,
      ),
      validator: (_input) {
        return _input.length != 0 ? null : 'Please enter a password';
      },
      onSaved: (_input) {
        setState(() {
          _password = _input;
        });
      },
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: 'Password',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return Container(
      height: MediaQuery.of(context).size.width * 0.12,
      width: MediaQuery.of(context).size.width,
      child: MaterialButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        elevation: 10.0,
        color: Colors.black,
        child: Text(
          "REGISTER",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
