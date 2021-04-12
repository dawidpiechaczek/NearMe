import 'package:NearMe/screen/gallery.dart';
import 'package:NearMe/widgets/appBackground.dart';
import 'package:NearMe/widgets/circleButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileEditPage extends StatefulWidget {
  ProfileEditPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEditPage> {
  final PageController controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    print("InitState");
  }

  void _navigateToGallery() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return GalleryPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileEditAppBar(),
      body: Stack(
        children: [
          backgroundGradient(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              pagerWithPhotos(),
              basicUserInfo(),
              userDescription(),
              editDescriptionButton()
            ],
          ),
        ],
      ),
    );
  }

  Padding editDescriptionButton() {
    return Padding(
      padding: EdgeInsets.only(left: 24, top: 24),
      child: RichText(
          text: TextSpan(
        text: "Edytuj opis",
        style: TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 18,
            fontWeight: FontWeight.bold),
      )),
    );
  }

  Padding userDescription() {
    return Padding(
        padding: EdgeInsets.only(left: 24, top: 16),
        child: Text(
          "Nawiąze kontakt z nowymi osobami o podobnych zainteresowaniach",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ));
  }

  Padding basicUserInfo() {
    return Padding(
      padding: EdgeInsets.only(top: 12),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: EdgeInsets.only(left: 12, right: 12),
          child: Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
        Text(
          "Dawid Piechaczek",
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Padding(
            padding: EdgeInsets.only(right: 16, left: 32),
            child: Text(
              "27 lat",
              style: TextStyle(fontSize: 24, color: Colors.white),
            )),
      ]),
    );
  }

  Container pagerWithPhotos() {
    return Container(
      height: MediaQuery.of(context).size.height * 3 / 5,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 6.0,
                )
              ],
            ),
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: controller,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  child: Image.asset(
                    "assets/images/profile_photo.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Text('Second Page'),
                ),
                Center(
                  child: Text('Third Page'),
                )
              ],
            ),
          ),
          photoButton()
        ],
      ),
    );
  }

  Positioned photoButton() {
    return Positioned(
      bottom: 0,
      left: 0.5,
      right: 0.5,
      child: Padding(
        padding: EdgeInsets.only(bottom: 12),
        child: CircleButton(
          backgroundColor: Colors.white,
          icon: Icon(
            Icons.camera_alt,
            size: 30,
          ),
          onTap: () {
            _navigateToGallery();
          },
          size: 60,
        ),
      ),
    );
  }

  AppBar profileEditAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.blue),
      actionsIconTheme: IconThemeData(color: Colors.blue),
      title: Text(
        "Profil",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
