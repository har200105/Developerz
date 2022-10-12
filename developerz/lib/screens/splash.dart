import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:developerz/providers/user.dart';
import 'package:developerz/widgets/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).setUser();
    Timer(
        const Duration(seconds: 7),
        () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomNavigationBarExample()))
            });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(6, 40, 61, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Image.asset(
                "assets/devv.png",
                width: 70,
                height: 70,
                color: Colors.white,
              ),
            ),
            Center(
              child: Text(
                "Developerz",
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            ),
            SizedBox(height: 10),
            Center(
                child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  "A Platform to connect with Developers",
                  textStyle: TextStyle(color: Colors.blueGrey, fontSize: 15),
                  speed: const Duration(milliseconds: 150),
                ),
              ],
              totalRepeatCount: 1,
            )),
          ],
        ),
      ),
    );
  }
}
