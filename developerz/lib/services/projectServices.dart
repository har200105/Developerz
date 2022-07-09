import 'dart:convert';

import 'package:developerz/utils/APIUrl.dart';
import 'package:http/http.dart' as http;

class ProjectService {
  final String url = API.api;
  final client = http.Client();

  Future fetchProjects() async {
    final Uri uri = Uri.parse(url + "/getProjects");
    final http.Response response = await client.get(uri, headers: {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    });
    if (response.statusCode == 201) {
      return response.body;
    }
  }

  Future fetchProjectOfUserById(String id) async {
    final Uri uri = Uri.parse(url + "/getProjectsByUser/" + id);
    final http.Response response = await client.get(uri, headers: {});
    if (response.statusCode == 201) {
      return response.body;
    }
  }

  Future getProjectDetailsById(String id) async {
    final Uri uri = Uri.parse(url + "/getProjectById/" + id);
    final http.Response response = await client.get(uri, headers: {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    });
    if (response.statusCode == 201) {
      return response.body;
    }
  }

  Future getSearchedQuery(String query) async {
    final Uri uri = Uri.parse(url + "/getSearchResults/?search=" + query);
    final http.Response response = await client.get(uri, headers: {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    });
    if (response.statusCode == 201) {
      return response.body;
    }
  }

  Future addProject(
      String? token,
      String? name,
      String? description,
      String? github,
      String? live,
      String? image,
      List<String>? techStacksUsed) async {
    if (token != null) {
      final Uri uri = Uri.parse(url + "/addProject");

      Map<String, dynamic> data = {
        'name': name,
        'description': description,
        'github': github,
        'live': live,
        'image': image,
        'techStacksUsed': techStacksUsed
      };

      final http.Response response = await client.post(uri,
          headers: {
            "Authorization": token,
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode(data));
      if (response.statusCode == 201) {
        return response.body;
      }
    }
  }

  Future upVoteProject(String? token, String? id) async {
    if (token != null) {
      final Uri uri = Uri.parse(url + "/upVoteProject/$id");

      final http.Response response = await client.put(uri, headers: {
        "Authorization": token,
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      if (response.statusCode == 201) {
        return response.body;
      }
    }
  }

  Future downVoteProject(String? token, String? id) async {
    if (token != null) {
      final Uri uri = Uri.parse(url + "/downVoteProject/$id");
      final http.Response response = await client.put(uri, headers: {
        "Authorization": token,
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      if (response.statusCode == 201) {
        return response.body;
      }
    }
  }
}
