import 'package:developerz/providers/user.dart';
import 'package:developerz/screens/home.dart';
import 'package:developerz/screens/projectscreen.dart';
import 'package:developerz/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarExample extends StatefulWidget {
  @override
  _BottomNavigationBarExampleState createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  PageController pageController = PageController();
  int currentIndex = 0;
  List<Widget> currentTab = [
    const HomeScreen(),
    const ProjectScreen(),
    const Search(),
  ];

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).setUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        body: PageView(
          children: currentTab,
          controller: pageController,
          onPageChanged: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromRGBO(6, 40, 61, 1),
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn);
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(LineIcons.home, color: Colors.white), label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  LineIcons.code,
                  color: Colors.white,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  LineIcons.search,
                  color: Colors.white,
                ),
                label: ""),
          ],
        ),
      ),
    );
  }
}
