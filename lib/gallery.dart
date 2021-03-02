import 'package:flutter/material.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
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
              children: <Widget>[Text('data')],
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
}
