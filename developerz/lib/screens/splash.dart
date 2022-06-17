import 'dart:async';
import 'package:developerz/providers/user.dart';
import 'package:developerz/screens/home.dart';
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
        const Duration(seconds: 3),
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
            children: const [
              Center(
                child: Text(
                  "Developerz",
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  "A Platform to connect with Developers",
                  style: TextStyle(color: Colors.blueGrey),
                ),
              ),
            ],
          ),
        ));
  }
}
