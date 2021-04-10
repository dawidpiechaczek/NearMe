import 'package:NearMe/widgets/appBackground.dart';
import 'package:NearMe/widgets/circleButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileMainPage extends StatefulWidget {
  ProfileMainPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _ProfileMainPageState createState() => _ProfileMainPageState();
}

class _ProfileMainPageState extends State<ProfileMainPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    print("InitState");
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainProfileAppBar(),
      body: Stack(children: [
        backgroundGradient(),
        SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                userInfo(),
                preferencesTile(),
                premiumInfo(),
                premiumInfoButton()
              ],
            ),
          ),
        ),
      ]),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Padding premiumInfo() {
    return Padding(
      padding: EdgeInsets.only(right: 16, left: 16),
      child: Text(
        "Korzystaj w pełni z aplikacji, zdobądź korzyści takie jak nielimitowane polubienia oraz wiadomości",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Padding premiumInfoButton() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: RichText(
        text: TextSpan(
          text: "Aktywuj NearApp Premium",
          style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Padding userInfo() {
    return Padding(
      padding: EdgeInsets.only(top: 32, right: 16, left: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(
                foregroundImage: AssetImage("assets/images/profile_photo.png"),
                radius: 40,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleButton(
                  backgroundColor: Colors.white,
                  icon: Icon(Icons.edit),
                  onTap: () {},
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 16, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dawid Piechaczek",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  "27 lat",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding preferencesTile() {
    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Container(
        width: double.infinity,
        decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Padding(
          padding: EdgeInsets.only(bottom: 8, top: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              preferenceItem("assets/images/icon_group.png", "Preferencje",
                  "Wybierz właściwości do spotkania"),
              preferenceItem("assets/images/icon_heart.png", "Ulubione",
                  "Zobacz kto polubił Twój profil"),
              preferenceItem("assets/images/icon_user_add.png", "Zaproś osoby",
                  "Zarabiaj na polecaniu znajomych"),
              preferenceItem("assets/images/icon_settings.png",
                  "Ustawienia aplikacji", "Sprawdź najnowsze powiadomienia"),
              preferenceItem("assets/images/icon_help.png", "Pomoc",
                  "Najczestsze pytania uzytkowników"),
            ],
          ),
        ),
      ),
    );
  }

  Padding preferenceItem(String iconAsset, String title, String message) {
    return Padding(
      padding: EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 8),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {},
        child: Row(children: [
          Padding(
            padding: EdgeInsets.only(left: 8, right: 16),
            child: Image.asset(iconAsset),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                message,
                style: TextStyle(color: Colors.black, fontSize: 16),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ]),
      ),
    );
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.bolt), label: 'Nearby'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.place), label: 'Met people'),
          BottomNavigationBarItem(
              icon: Icon(Icons.message_rounded), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        iconSize: 40,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTap,
        elevation: 5);
  }

  AppBar mainProfileAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.blue),
      actionsIconTheme: IconThemeData(color: Colors.blue),
      title: Text(
        "Konto uzytkownika",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
