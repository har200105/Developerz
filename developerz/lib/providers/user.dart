import 'dart:convert';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:developerz/models/developer.dart';
import 'package:developerz/screens/login.dart';
import 'package:developerz/services/authenticationServices.dart';
import 'package:developerz/widgets/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  final Authentication _authentication = Authentication();

  Data? _data = Data();
  Data? get user => _data!;

  bool _loading = false;
  bool get loading => _loading;

  bool _Isuser = false;
  bool get getIsUser => _Isuser;

  setUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      _loading = true;
      if (await preferences.getString("token") != null) {
        String? token = await preferences.getString("token");
        var response = await _authentication.getUser(token);
        Data userData = Data.fromJson(jsonDecode(response));
        _Isuser = userData.email != null ? true : false;
        _data = userData;
        _loading = false;
        notifyListeners();
      } else {
        _loading = false;
        logout();
        notifyListeners();
      }
    } catch (e) {
      logout();
      print(e.toString() + " error");
      _loading = false;
      notifyListeners();
    }
  }

  void logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _data = Data();
    _Isuser = false;
    preferences.remove("token");
    preferences.clear();
    notifyListeners();
  }

  Future Signup(BuildContext context, String name, String email,
      String password, String image) async {
    try {
      var userData =
          await _authentication.signupUser(email, password, name, image);
      Map<String, dynamic> parsedData = await jsonDecode(userData);
      final success = parsedData['success'];
      final message = parsedData['message'];
      if (success == true) {
        AnimatedSnackBar.material("Signup Successfull",
                type: AnimatedSnackBarType.success)
            .show(context);
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
      } else {
        AnimatedSnackBar.material(message, type: AnimatedSnackBarType.error)
            .show(context);
      }
    } catch (e) {
      print(e.toString());
      AnimatedSnackBar.material("Something Went Wrong",
              type: AnimatedSnackBarType.error)
          .show(context);
    }
  }

  Future LoginService(
      BuildContext context, String email, String password) async {
    try {
      var userData = await _authentication.loginUser(email, password);
      Map<String, dynamic> parsedData = await jsonDecode(userData);

      final token = parsedData['token'];
      final success = parsedData['success'];
      if (token != null && success) {
        final userjwt = parsedData['token'];
        final names = parsedData['name'];
        final id = parsedData['_id'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("name", names);
        prefs.setString("token", userjwt);
        prefs.setString("id", id);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNavigationBarExample()));
        AnimatedSnackBar.material("Login Successfull",
                type: AnimatedSnackBarType.success)
            .show(context);
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Login()));
        AnimatedSnackBar.material("Invalid Email or Password",
                type: AnimatedSnackBarType.error)
            .show(context);
      }
    } catch (e) {
      print(e.toString());
      AnimatedSnackBar.material("Something Went Wrong",
              type: AnimatedSnackBarType.error)
          .show(context);
    }
  }

  void showSnackBar(BuildContext context, String message) {
    AnimatedSnackBar.material(message, type: AnimatedSnackBarType.info)
        .show(context);
    notifyListeners();
  }
}
