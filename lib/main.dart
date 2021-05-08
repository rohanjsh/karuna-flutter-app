import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karuna_flutter_app/home_list.dart';
import 'package:karuna_flutter_app/custom.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Karuna',
      theme: ThemeData(
        primaryColor: Color(0xff34A7FF),
        appBarTheme: AppBarTheme(elevation: 0.0),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String assetName = 'assets/logos/isolated-monochrome-white.svg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff34A7FF),
      appBar: AppBar(),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(left: 50, right: 50, bottom: 50),
          child: SingleChildScrollView(
            child: Column(
              children: intersperse(
                SizedBox(
                  height: 10,
                ),
                [
                  SvgPicture.asset(
                    assetName,
                    height: 45,
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  SimpleTextField(
                    textInputType: TextInputType.text,
                    accentColor: Colors.black,
                    textColor: Colors.white,
                    labelText: 'City',
                  ),
                  SimpleTextField(
                    textInputType: TextInputType.number,
                    accentColor: Colors.black,
                    textColor: Colors.white,
                    labelText: 'Pin Code',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SimpleElevatedButton(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Join",
                      style: TextStyle(color: Colors.black),
                    ),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomeList()));
                    },
                  ),
                ],
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
