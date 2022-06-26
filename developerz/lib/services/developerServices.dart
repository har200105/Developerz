import 'dart:convert';

import 'package:developerz/utils/APIUrl.dart';
import 'package:http/http.dart' as http;

class DeveloperService {
  final String url = API.api;
  final client = http.Client();

  Future fetchDevelopers() async {
    final Uri uri = Uri.parse(url + "/getAllDevelopers");

    final http.Response response = await client.get(uri, headers: {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    });

    if (response.statusCode == 201) {
      return response.body;
    }
  }

  Future fetchDeveloperById(String id) async {
    final Uri uri = Uri.parse(url + "/getDeveloperById/" + id);

    final http.Response response = await client.get(uri, headers: {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    });

    if (response.statusCode == 201) {
      return response.body;
    }
  }

  Future updateProfile(String? token,
      {String? bio,
      String? github,
      String? linkedurl,
      String? twitter,
      String? website,
      List<String>? skills}) async {
    if (token != null) {
      print(twitter);
      final Uri uri = Uri.parse(url + "/updateUserProfile");

      Map<String, dynamic> data = {
        'bio': bio ?? "",
        'github': github ?? "",
        'linkedin': linkedurl ?? "",
        'twitter': twitter ?? "",
        'website': website ?? "",
        'skills': skills ?? []
      };

      final http.Response response = await client.put(uri,
          headers: {
            // "Content-type": "application/json",
            // "Accept": "application/json",
            // "Access-Control-Allow-Origin": "*",
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
}
