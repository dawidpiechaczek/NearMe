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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: galleryAppBar(),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              addPhotoTitle(),
              addPhotoMessage(),
              photosContainer(),
              skipButton()
            ]),
      ),
    );
  }

  Expanded photosContainer() {
    return Expanded(
      child: GridView.count(
        padding: EdgeInsets.only(right: 8, left: 8),
        childAspectRatio: 3 / 4,
        crossAxisCount: 3,
        children: List.generate(9, (index) {
          return Padding(
            padding: EdgeInsets.all(4),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: index == 0 ? Icon(Icons.add) : null,
              ),
            ),
          );
        }),
      ),
    );
  }

  FlatButton skipButton() {
    return FlatButton(
      onPressed: null,
      child: Text(
        "POMIŃ",
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Padding addPhotoMessage() {
    return Padding(
        padding: EdgeInsets.only(top: 8, bottom: 16, right: 16, left: 16),
        child: Text(
          "Pierwsze zdjęcie w Twoim albumie musi przedstawiać Ciebie",
          textAlign: TextAlign.center,
        ));
  }

  Padding addPhotoTitle() {
    return Padding(
      padding: EdgeInsets.only(top: 16, right: 16, left: 16),
      child: Text(
        "Przeciągnij i upuść, aby uporządkować swoje zdjęcia!",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  AppBar galleryAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.blue),
      actionsIconTheme: IconThemeData(color: Colors.blue),
      actions: [
        IconButton(
          icon: Icon(Icons.check, color: Colors.blue),
        )
      ],
      title: Text(
        "Zdjęcia",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
