import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<File?> _images = List.filled(9, null);
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        int firstNull = _images.indexOf(null);
        _images[firstNull] = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  int removeImage(int index) {
    setState(() {
      _images[index] = null;
    });

    return index;
  }

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
      child: GridView.builder(
          itemCount: _images.length,
          padding: EdgeInsets.only(right: 8, left: 8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 3 / 4,
            crossAxisCount: 3,
          ),
          itemBuilder: (ctx, index) {
            return gridElement(index);
          }),
    );
  }

  Padding gridElement(int index) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: InkWell(
        onTap: getImage,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xFFE0E0E0), borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: _images[index] == null
                ? Icon(Icons.add)
                : imageWithRemovalButton(index),
          ),
        ),
      ),
    );
  }

  Stack imageWithRemovalButton(int index) {
    return Stack(
      children: <Widget>[
        InkWell(
          child: _images[index] != null ? Image.file(_images[index]!) : null,
          onTap: () {
            removeImage(index);
          },
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Padding(padding: EdgeInsets.all(8), child: Icon(Icons.delete)),
        )
      ],
    );
  }

  TextButton skipButton() {
    return TextButton(
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
          onPressed: () {},
        )
      ],
      title: Text(
        "Zdjęcia",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
