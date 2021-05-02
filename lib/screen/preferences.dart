import 'package:NearMe/screen/profile_settings.dart';
import 'package:NearMe/widgets/appBackground.dart';
import 'package:NearMe/widgets/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PreferencesPage extends StatefulWidget {
  PreferencesPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  RangeValues _currentRangeValues = const RangeValues(22, 30);

  @override
  void initState() {
    super.initState();
    print("InitState");
  }

  void _navigateToProfile() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ProfileSettingsPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: preferencesAppBar(),
      body: Stack(children: [
        backgroundGradient(),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              genderTitle(),
              rowWithConditionTiles(),
              ageTitle(),
              ageRange(),
              conditionsHint(),
              conditionsCookies(),
              agreeButton()
            ],
          ),
        ),
      ]),
    );
  }

  Padding genderTitle() {
    return Padding(
        padding: EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 16),
        child: Text(
          "Pokazuj:",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ));
  }

  Padding ageTitle() {
    return Padding(
        padding: EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 16),
        child: Text(
          "Określ wiek osoby:",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ));
  }

  Padding ageRange() {
    return Padding(
      padding: EdgeInsets.only(right: 8, left: 8),
      child: RangeSlider(
        values: _currentRangeValues,
        min: 18,
        activeColor: Colors.white,
        inactiveColor: Colors.grey,
        max: 100,
        divisions: 100,
        labels: RangeLabels(
          _currentRangeValues.start.round().toString(),
          _currentRangeValues.end.round().toString(),
        ),
        onChanged: (RangeValues values) {
          setState(() {
            _currentRangeValues = values;
          });
        },
      ),
    );
  }

  Row rowWithConditionTiles() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        genderTile(
            Image.asset(
              'assets/images/icon_technical_conditions.png',
            ),
            "Kobiety"),
        genderTile(
            Image.asset(
              'assets/images/icon_analytical_conditions.png',
            ),
            "Męzczyzn")
      ],
    );
  }

  Padding conditionsHint() {
    return Padding(
        padding: EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 32),
        child: Text(
          "Kliknij na ikonę aby dowiedzieć się więcej na temat wymagań technicznych i celów analitycznych",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ));
  }

  Padding conditionsCookies() {
    return Padding(
        padding: EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 32),
        child: Text(
          "Zapoznaj się równiez z polityką cookies",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ));
  }

  Padding agreeButton() {
    return Padding(
      padding: EdgeInsets.only(top: 24),
      child: roundedButton(Color(0xFFFBC02D), 'Wyrazam zgodę', null, 16, 16, 4,
          Colors.transparent, _navigateToProfile),
    );
  }

  InkWell genderTile(Image tileIcon, String tileTitle) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          width: 160.0,
          height: 80.0,
          child: Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                tileIcon,
                Padding(
                  padding: EdgeInsets.only(right: 8, left: 8),
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

  AppBar preferencesAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.blue),
      actionsIconTheme: IconThemeData(color: Colors.blue),
      title: Text(
        "Preferencje",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
