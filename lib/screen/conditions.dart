import 'package:NearMe/widgets/appBackground.dart';
import 'package:NearMe/widgets/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConditonsPage extends StatefulWidget {
  ConditonsPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _ConditonsPageState createState() => _ConditonsPageState();
}

class _ConditonsPageState extends State<ConditonsPage> {
  @override
  void initState() {
    super.initState();
    print("InitState");
  }

  void _navigateToProfile() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ConditonsPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: conditionsAppBar(),
      body: Stack(children: [
        backgroundGradient(),
        Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                        top: 20, left: 16, right: 16, bottom: 32),
                    child: Text(
                      "Przechowujemy Twoje dane w tajemnicy",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Colors.white),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    conditionTile(
                        Image.asset(
                          'assets/images/icon_technical_conditions.png',
                        ),
                        "Wymagania techniczne"),
                    conditionTile(
                        Image.asset(
                          'assets/images/icon_analytical_conditions.png',
                        ),
                        "Cele analityczne")
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: 20, left: 16, right: 16, bottom: 32),
                    child: Text(
                      "Kliknij na ikonę aby dowiedzieć się więcej na temat wymagań technicznych i celów analitycznych",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: 20, left: 16, right: 16, bottom: 32),
                    child: Text(
                      "Zapoznaj się równiez z polityką cookies",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: roundedButton(Color(0xFFFBC02D), 'Wyrazam zgodę', null,
                      16, 16, 4, Colors.transparent, _navigateToProfile),
                )
              ]),
        ),
      ]),
    );
  }

  InkWell conditionTile(Image tileIcon, String tileTitle) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          width: 160.0,
          height: 160.0,
          child: Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                tileIcon,
                Padding(
                  padding: EdgeInsets.only(top: 8, right: 8, left: 8),
                  child: Text(
                    tileTitle,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar conditionsAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.blue),
      actionsIconTheme: IconThemeData(color: Colors.blue),
      title: Text(
        "Regulaminy",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
