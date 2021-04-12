import 'dart:io';
import 'package:NearMe/screen/conditions.dart';
import 'package:NearMe/widgets/appBackground.dart';
import 'package:NearMe/widgets/circleButton.dart';
import 'package:NearMe/widgets/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<File?> _images = List.filled(4, null);
  final picker = ImagePicker();

  Future _getImage() async {
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

  int _removeImage(int index) {
    setState(() {
      _images[index] = null;
    });

    return index;
  }

  void _navigateToConditions() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ConditonsPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: galleryAppBar(),
      body: Stack(children: [
        backgroundGradient(),
        Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                addPhotoTitle(),
                photosContainer(),
                roundedButton(Color(0xFFFBC02D), 'Zaakceptuj i przejdź dalej',
                    null, 16, 16, 4, Colors.transparent, _navigateToConditions),
                skipButton()
              ]),
        ),
      ]),
    );
  }

  Expanded photosContainer() {
    return Expanded(
      child: GridView.builder(
          itemCount: _images.length,
          padding: EdgeInsets.only(right: 8, left: 8, bottom: 8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.75),
            crossAxisCount: 2,
          ),
          itemBuilder: (ctx, index) {
            return gridElement(index);
          }),
    );
  }

  Padding gridElement(int index) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: imageWithRemovalButton(index),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: _images[index] == null
                ? CircleButton(
                    onTap: () => _getImage(),
                    size: 30,
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.black)
                : null,
          ),
        ),
      ]),
    );
  }

  Stack imageWithRemovalButton(int index) {
    return Stack(
      children: <Widget>[
        Container(
          constraints: BoxConstraints(minWidth: 250, maxWidth: 300),
          child: _images[index] != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(_images[index]!, fit: BoxFit.fitWidth))
              : null,
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: CircleButton(
                onTap: () => _removeImage(index),
                size: 30,
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                backgroundColor: Colors.black),
          ),
        ),
      ],
    );
  }

  Padding skipButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: TextButton(
        onPressed: null,
        child: Text(
          "POMIŃ",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Padding addPhotoTitle() {
    return Padding(
      padding: EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 16),
      child: Text(
        "Wgraj swoje zdjęcie aby inni mogli Cię zobaczyć!",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  AppBar galleryAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.blue),
      actionsIconTheme: IconThemeData(color: Colors.blue),
      title: Text(
        "Zdjęcia",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
