import 'package:NearMe/gallery.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class _MyHomePageState extends State<LoginPage> {
  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  @override
  void initState() {
    super.initState();
    print("InitState");
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      print("user changes");
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact(_currentUser);
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleGetContact(GoogleSignInAccount? user) async {
    setState(() {
      _contactText = "Loading contact info...";
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user?.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = "People API gave a ${response.statusCode} "
            "response. Check logs for details.";
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = "I see you know $namedContact!";
      } else {
        _contactText = "No contacts to display.";
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'];
    final Map<String, dynamic> contact = connections.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic> name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    try {
      print("SignIn");
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  void _navigateToGallery() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return GalleryPage();
    }));
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
                roundedButton(
                    Colors.blue,
                    "Login with Facebook",
                    FontAwesomeIcons.facebook,
                    12,
                    12,
                    4,
                    Colors.transparent,
                    _navigateToGallery),
                roundedButton(
                    Colors.red,
                    "Login with Google",
                    FontAwesomeIcons.google,
                    12,
                    12,
                    4,
                    Colors.transparent,
                    _handleSignIn),
                roundedButton(Colors.transparent, "Login with phone number",
                    null, 16, 16, 0, Colors.white, _navigateToGallery),
                Text("TEXT: $_contactText")
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
      IconData? icon,
      double paddingTop,
      double paddingBottom,
      double elevation,
      Color borderColor,
      Function() onPress) {
    return Padding(
        padding: EdgeInsets.only(left: 30, right: 30, bottom: 12),
        child: ElevatedButton(
          child: Padding(
            padding: EdgeInsets.only(top: paddingTop, bottom: paddingBottom),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (icon != null)
                  Padding(
                      padding: EdgeInsets.only(right: 12), child: FaIcon(icon)),
                Text(
                  text,
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
          onPressed: onPress,
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: borderColor))),
              elevation: MaterialStateProperty.all(elevation),
              backgroundColor: MaterialStateProperty.all(backgroundColor),
              textStyle:
                  MaterialStateProperty.all(TextStyle(color: Colors.white))),
        ));
  }
}
