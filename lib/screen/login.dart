import 'package:NearMe/widgets/appBackground.dart';
import 'package:NearMe/screen/gallery.dart';
import 'package:NearMe/widgets/roundedButton.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class _LoginPageState extends State<LoginPage> {
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: null,
      body: Stack(children: [
        backgroundPhoto(),
        backgroundGradient(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            welcomeText(),
            roundedButton(
                Colors.blue,
                "Login with Facebook",
                FontAwesomeIcons.facebook,
                16,
                16,
                4,
                Colors.transparent,
                _navigateToGallery),
            roundedButton(
                Colors.red,
                "Login with Google",
                FontAwesomeIcons.google,
                16,
                16,
                4,
                Colors.transparent,
                _handleSignIn),
            roundedButton(Colors.transparent, "Login with phone number", null,
                18, 18, 0, Colors.white, _navigateToGallery),
            privacyPolicyAndRulesText()
          ],
        ),
        logo(),
      ]),
    );
  }

  Align logo() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 64),
        child: Image.asset(
          'assets/images/app_logo.png',
        ),
      ),
    );
  }

  Padding welcomeText() {
    return Padding(
        padding: EdgeInsets.only(bottom: 72, right: 32, left: 32, top: 64),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
                text: "Poznawaj ",
                style: TextStyle(
                    fontSize: 36,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: 'ludzi, którzy są w zasięgu Twojego wzroku',
                style: TextStyle(
                    fontSize: 36, fontFamily: 'Nunito', color: Colors.white))
          ]),
        ));
  }

  Padding privacyPolicyAndRulesText() {
    return Padding(
        padding: EdgeInsets.only(top: 32, right: 32, left: 32),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              style: TextStyle(
                  fontSize: 14, fontFamily: 'Nunito', color: Colors.white),
              children: [
                TextSpan(
                  text: "Rejestrując się zgadzasz się na ",
                ),
                TextSpan(
                  text: "warunki regulaminu ",
                  style: TextStyle(decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      await launch(
                        "http://www.google.com",
                      );
                    },
                ),
                TextSpan(
                  text: "oraz ",
                ),
                TextSpan(
                  text: "polityki prywatności",
                  style: TextStyle(decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      await launch("http://www.google.com");
                    },
                )
              ]),
        ));
  }

  Padding backgroundPhoto() {
    return Padding(
      padding: EdgeInsets.only(bottom: 100),
      child: Image.asset(
        'assets/images/background.png',
        fit: BoxFit.fitHeight,
        height: 450,
        alignment: Alignment.centerLeft,
      ),
    );
  }
}
