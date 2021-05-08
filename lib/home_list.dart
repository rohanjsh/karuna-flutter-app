import 'package:flutter/material.dart';
import 'package:karuna_flutter_app/custom.dart';
import 'package:karuna_flutter_app/pages/resources_index_0.dart';
import 'package:karuna_flutter_app/pages/surveys_index_1.dart';
import 'package:karuna_flutter_app/pages/chat_index_2.dart';

//main
class HomeList extends StatefulWidget {
  const HomeList({Key key}) : super(key: key);

  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  int currentTabIndex;

  @override
  void initState() {
    super.initState();
    currentTabIndex = 0;
  }

  void setCurrentIndex(int val) {
    setState(() {
      currentTabIndex = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff34A7FF),
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Resources'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Surveys'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Chat'),
        ],
        currentIndex: currentTabIndex,
        onTap: setCurrentIndex,
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Karuna',
          style: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: PersistentTabs(
        currentTabIndex: currentTabIndex,
        screenWidgets: [Resources(), Surveys(), SimpleLoginScreen()],
      ),
    );
  }
}
