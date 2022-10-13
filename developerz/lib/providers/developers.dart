import 'dart:convert';
import 'package:developerz/models/developer.dart';
import 'package:developerz/services/developerServices.dart';
import 'package:developerz/widgets/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DevelopersProvider extends ChangeNotifier {
  List<Data> _developers = [];
  List<Data> get getDevelopers => _developers;

  Data? _developer;
  Data? get getDeveloper => _developer;

  bool _loading = false;
  bool get getLoading => _loading;

  final DeveloperService _developerService = DeveloperService();

  Future fetchDevelopers(BuildContext context) async {
    try {
      if (_developers.isEmpty) {
        _loading = true;
      }
      var response = await _developerService.fetchDevelopers();
      Developer modelData = Developer.fromJson(jsonDecode(response));
      _developers = modelData.data!;
      _loading = false;
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Something Went Wrong",
          ),
          backgroundColor: Colors.red,
        ),
      );
      _loading = false;
      notifyListeners();
    }
  }

  Future fetchDeveloperById(BuildContext context, String id) async {
    try {
      if (_developer == null) {
        _loading = true;
      }
      var response = await _developerService.fetchDeveloperById(id);
      Data modelData = Data.fromJson(jsonDecode(response)['data']);
      _developer = modelData;
      _loading = false;
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Something Went Wrong",
          ),
          backgroundColor: Colors.red,
        ),
      );
      _loading = false;
      notifyListeners();
    }
  }

  Future followDeveloper(BuildContext context, String id) async {
    try {
      _loading = true;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      if (preferences.getString("token") != null) {
        var response = await _developerService.followDeveloper(
            preferences.getString("token"), id);
        print(jsonDecode(response));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Please Login to Follow",
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Something Went Wrong",
          ),
          backgroundColor: Colors.red,
        ),
      );
      _loading = false;
      notifyListeners();
    }
  }

  Future unfollowDeveloper(BuildContext context, String id) async {
    try {
      _loading = true;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      if (preferences.getString("token") != null) {
        var response = await _developerService.unfollowDeveloper(
            preferences.getString("token"), id);
        print(jsonDecode(response));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Please Login to Follow",
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Something Went Wrong",
          ),
          backgroundColor: Colors.red,
        ),
      );
      _loading = false;
      notifyListeners();
    }
  }

  Future updateProfile(BuildContext context,
      {String? bio,
      String? github,
      String? linkedurl,
      String? twitter,
      String? website,
      List<String>? skills}) async {
    try {
      if (_developer == null) {
        _loading = true;
      }
      SharedPreferences preferences = await SharedPreferences.getInstance();
      if (preferences.getString("token") != null) {
        var response = await _developerService.updateProfile(
            preferences.getString("token"),
            bio: bio,
            github: github,
            linkedurl: linkedurl,
            twitter: twitter,
            website: website,
            skills: skills);
        if (json.decode(response)['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Profile Updated"),
            backgroundColor: Colors.tealAccent,
          ));
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => BottomNavigationBarExample()));
        }
        _loading = false;
        notifyListeners();
      } else {
        return;
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Something Went Wrong",
          ),
          backgroundColor: Colors.red,
        ),
      );
      _loading = false;
      notifyListeners();
    }
  }

  void resetDeveloperProfile() {
    _developer = null;
    notifyListeners();
  }
}
