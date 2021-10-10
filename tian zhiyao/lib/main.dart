import 'package:digi/map.dart';
import 'package:digi/posting.dart';
// import 'package:digi/message.dart/';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

import 'notification.dart';
import 'homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Digi',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedPageIndex = 0;

  var pages = [
    // MainPage(),
    HomePage(),
    // Notifications(),
    Map(),
    // Message(),
    Posting(),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: pages[selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[300],
        items: [
          BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text("homepage"),
            icon: Icon(
              FontAwesomeIcons.home,
              color: selectedPageIndex == 0 ? Colors.green : Colors.blueGrey,
            ),
          ),
          BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Text("map"),
              icon: Icon(
                FontAwesomeIcons.mapMarkedAlt,
                color: selectedPageIndex == 1 ? Colors.green : Colors.blueGrey,
              )),
          BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text("post"),
            icon: Icon(
              FontAwesomeIcons.plusCircle,
              color: selectedPageIndex == 2 ? Colors.green : Colors.blueGrey,
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedPageIndex = index;
          });
        },
        currentIndex: selectedPageIndex,
      ),
    );
  }
}
