import 'package:flutter/material.dart';
import 'package:youtube_clone/CustomSearchDelegate.dart';
import 'package:youtube_clone/screens/HomeScreen.dart';
import 'package:youtube_clone/screens/LibraryScreen.dart';
import 'package:youtube_clone/screens/SubscriptionScreen.dart';
import 'package:youtube_clone/screens/TrendingScreen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  String _result = "";

  @override
  Widget build(BuildContext context) {

    List<Widget> screens = [
      HomeScreen(_result),
      TrendingScreen(),
      SubscriptionScreen(),
      LibraryScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey
        ),
        backgroundColor: Colors.white,
        title: Image.asset(
          "images/youtube.png",
          width: 98,
          height: 22,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String res = await showSearch(
                context: context,
                delegate: CustomSearchDelegate()
              );
              setState(() {
                _result = res;
              });
            },
          ),
          /*IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {
              print("Action: videocam");
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              print("Action: account");
            },
          ),*/

        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Trending",
            icon: Icon(Icons.whatshot)
          ),
          BottomNavigationBarItem(
            label: "Subscriptions",
            icon: Icon(Icons.subscriptions)
          ),
          BottomNavigationBarItem(
            label: "Library",
            icon: Icon(Icons.folder)
          ),

        ],
      ),
    );
  }
}
