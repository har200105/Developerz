import 'dart:convert';
// import 'dart:html';
import 'package:developerz/models/developer.dart';
import 'package:developerz/providers/imageUtility.dart';
import 'package:developerz/screens/login.dart';
import 'package:developerz/screens/verifyEmail.dart';
import 'package:developerz/services/authenticationServices.dart';
import 'package:developerz/widgets/bottomnavbar.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
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
    _loading = true;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString("token") != null) {
      String? token = preferences.getString("token");
      var response = await _authentication.getUser(token);
      Data userData = Data.fromJson(jsonDecode(response));
      print("setting user");
      print(userData.email);
      _Isuser = userData.email != null ? true : false;
      _data = userData;
      _loading = false;
      notifyListeners();
    } else {
      _loading = false;
      notifyListeners();
    }
  }

  logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _data = Data();
    _Isuser = false;
    preferences.remove("token");
    preferences.clear();
  }

  Future Signup(BuildContext context, String name, String email,
      String password, String image) async {
    try {
      var userData =
          await _authentication.signupUser(email, password, name, image);
      Map<String, dynamic> parsedData = await jsonDecode(userData);
      print(parsedData['success']);
      final success = parsedData['success'];
      final message = parsedData['message'];
      // var utils = Provider.of<UtilityNotifier>(context, listen: false);
      if (success == true) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Login Successfull")));
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => VerifyEmail(email: email)));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
  }

  Future LoginService(
      BuildContext context, String email, String password) async {
    try {
      var userData = await _authentication.loginUser(email, password);
      Map<String, dynamic> parsedData = await jsonDecode(userData);
      print(parsedData['token']);

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
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Login Successfull"), backgroundColor: Colors.green));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Login()));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Invalid Email or Password"),
            backgroundColor: Colors.red));
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something Went Wrong"), backgroundColor: Colors.red));
    }
  }
}
