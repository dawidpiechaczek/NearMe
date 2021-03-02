import 'package:NearMe/gallery.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LoginPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: homeBackground(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: null,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                logo(),
                roundedButton(Colors.blue, "Login with Facebook",
                    FontAwesomeIcons.facebook, 12, 12, 4, Colors.transparent),
                roundedButton(Colors.red, "Login with Google",
                    FontAwesomeIcons.google, 12, 12, 4, Colors.transparent),
                roundedButton(Colors.transparent, "Login with phone number",
                    null, 16, 16, 0, Colors.white)
              ],
            ),
          ),
        ));
  }

  BoxDecoration homeBackground() {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.3, 0.5, 0.9],
            colors: [Color(0xFFB3E5FC), Color(0xFF81D4FA), Color(0xFF4FC3F7)]));
  }

  Padding logo() {
    return Padding(
        padding: EdgeInsets.only(bottom: 100),
        child: Column(children: <Widget>[
          Image.asset('assets/images/logo.png', scale: 3.0),
          Text('Near Me',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white))
        ]));
  }

  Widget roundedButton(
      Color backgroundColor,
      String text,
      IconData icon,
      double paddingTop,
      double paddingBottom,
      double elevation,
      Color borderColor) {
    return Padding(
        padding: EdgeInsets.only(left: 30, right: 30, bottom: 12),
        child: RaisedButton(
            child: Padding(
              padding: EdgeInsets.only(top: paddingTop, bottom: paddingBottom),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (icon != null)
                    Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: FaIcon(icon)),
                  Text(
                    text,
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return GalleryPage();
              }));
            },
            textColor: Colors.white,
            color: backgroundColor,
            elevation: elevation,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(color: borderColor))));
  }
}
