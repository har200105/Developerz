import 'package:developerz/providers/developers.dart';
import 'package:developerz/providers/imageUtility.dart';
import 'package:developerz/providers/projects.dart';
import 'package:developerz/providers/user.dart';
import 'package:developerz/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UtilityNotifier(),
        ),
        ChangeNotifierProvider(create: (context) => ProjectProvider()),
        ChangeNotifierProvider(create: (context) => DevelopersProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Developerz',
        theme: ThemeData(
          fontFamily: 'Poppins',
          backgroundColor: const Color.fromRGBO(6, 40, 61, 1),
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
