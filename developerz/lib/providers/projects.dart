import 'dart:convert';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:developerz/models/developer.dart' as d;
import 'package:developerz/models/project.dart';
import 'package:developerz/services/projectServices.dart';
import 'package:developerz/widgets/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProjectProvider extends ChangeNotifier {
  List<Project> _projects = [];
  List<Project> get getProjects => _projects;

  Project? _project;
  Project? get getProject => _project;

  List<Project> _projectsUser = [];
  List<Project> get projectsUser => _projectsUser;

  List<Project> _searchedProjects = [];
  List<Project> get getSearchedProjects => _searchedProjects;

  List<d.Data> _searchedDevelopers = [];
  List<d.Data>? get getSearchedDevelopers => _searchedDevelopers;

  bool _loading = false;
  bool get getLoading => _loading;

  bool _isUpVoted = false;
  bool get getIsUpVoted => _isUpVoted;

  bool _isDownVoted = false;
  bool get getIsDownVoted => _isDownVoted;

  final ProjectService _projectService = ProjectService();

  Future fetchProjects(BuildContext context) async {
    try {
      if (_projects.isEmpty) {
        _loading = true;
      }
      var response = await _projectService.fetchProjects();
      Projects modelData = Projects.fromJson(jsonDecode(response));
      _projects = modelData.projects;
      _loading = false;
      notifyListeners();
    } catch (e) {
      AnimatedSnackBar.material("Something Went Wrong",
              type: AnimatedSnackBarType.error)
          .show(context);
      _loading = false;
      notifyListeners();
    }
  }

  Future getProjectsDoneByDevelopersById(
      BuildContext context, String id) async {
    try {
      if (_projectsUser.isEmpty) {
        _loading = true;
      }
      var response = await _projectService.fetchProjectOfUserById(id);
      Projects modelData = Projects.fromJson(jsonDecode(response));
      _projectsUser = modelData.projects;
      _loading = false;
      notifyListeners();
    } catch (e) {
      print(e.toString());
      AnimatedSnackBar.material("Something Went Wrong",
              type: AnimatedSnackBarType.error)
          .show(context);
      _loading = false;
      notifyListeners();
    }
  }

  Future getProjectDetailsById(BuildContext context, String id) async {
    try {
      if (_project == null) {
        _loading = true;
      }
      var response = await _projectService.getProjectDetailsById(id);
      Project modelData = Project.fromJson(jsonDecode(response));
      _project = modelData;
      _loading = false;
      notifyListeners();
    } catch (e) {
      AnimatedSnackBar.material("Something Went Wrong",
              type: AnimatedSnackBarType.error)
          .show(context);
      _loading = false;
      notifyListeners();
    }
  }

  Future getSearchedData(BuildContext context, String query) async {
    try {
      _loading = true;
      var response = await _projectService.getSearchedQuery(query);
      Projects modelData = Projects.fromJson(jsonDecode(response));
      d.Developer modelData1 = d.Developer.fromJson(jsonDecode(response));
      _searchedProjects = modelData.projects;
      _searchedDevelopers = modelData1.data!;
      _loading = false;
      notifyListeners();
    } catch (e) {
      print(e.toString());
      AnimatedSnackBar.material("Something Went Wrong",
              type: AnimatedSnackBarType.error)
          .show(context);
      _loading = false;
      notifyListeners();
    }
  }

  Future addProject(
      BuildContext context,
      String name,
      String description,
      String github,
      String live,
      String image,
      List<String> techStacksUsed) async {
    try {
      _loading = true;
      if (name.isEmpty || description.isEmpty) {
        AnimatedSnackBar.material("Name and Description is required",
                type: AnimatedSnackBarType.info)
            .show(context);
        return;
      }
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString("token");
      var response = await _projectService.addProject(
          token, name, description, github, live, image, techStacksUsed);
      _loading = false;
      if (json.decode(response)['success'] == true) {
        AnimatedSnackBar.material("Project Added",
                type: AnimatedSnackBarType.success)
            .show(context);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => BottomNavigationBarExample()));
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
      AnimatedSnackBar.material("Something Went Wrong",
              type: AnimatedSnackBarType.error)
          .show(context);
      _loading = false;
      notifyListeners();
    }
  }

  Future upVoteProject(BuildContext context, String id) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      _isUpVoted = true;
      var token = preferences.getString("token");
      var response = await _projectService.upVoteProject(token, id);
      _loading = false;
      if (json.decode(response)['success'] == true) {
        AnimatedSnackBar.material("Project upvoted",
                type: AnimatedSnackBarType.success)
            .show(context);
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
      AnimatedSnackBar.material("Something Went Wrong",
              type: AnimatedSnackBarType.error)
          .show(context);
      _loading = false;
      notifyListeners();
    }
  }

  Future deleteProject(BuildContext context, String id) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      _isUpVoted = true;
      var token = preferences.getString("token");
      var response = await _projectService.deleteProject(token, id);
      _loading = false;
      if (json.decode(response)['success'] == true) {
        AnimatedSnackBar.material("Project deleted",
                type: AnimatedSnackBarType.success)
            .show(context);
      } else {
        AnimatedSnackBar.material("Project Not found",
                type: AnimatedSnackBarType.error)
            .show(context);
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
      AnimatedSnackBar.material("Something Went Wrong",
              type: AnimatedSnackBarType.error)
          .show(context);
      _loading = false;
      notifyListeners();
    }
  }

  Future downVoteProject(BuildContext context, String id) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      _isDownVoted = true;
      var token = preferences.getString("token");
      var response = await _projectService.downVoteProject(token, id);
      _loading = false;
      if (json.decode(response)['success'] == true) {
        AnimatedSnackBar.material("Project Downvoted",
                type: AnimatedSnackBarType.success)
            .show(context);
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
      AnimatedSnackBar.material("Something Went Wrong",
              type: AnimatedSnackBarType.error)
          .show(context);
      _loading = false;
      notifyListeners();
    }
  }

  void resetProjectDetail() {
    _project = null;
    _projectsUser = [];
    notifyListeners();
  }
}
