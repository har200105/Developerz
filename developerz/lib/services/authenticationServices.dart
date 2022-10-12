import 'package:developerz/utils/APIUrl.dart';
import 'package:http/http.dart' as http;

class Authentication {
  final client = http.Client();

  Future loginUser(String email, String password) async {
    final http.Response response = await http.post(
        Uri.parse("${API.api}/login"),
        body: {'email': email, 'password': password});
    // if (response.statusCode == 200) {
    return response.body;
    // }
  }

  Future signupUser(
      String email, String password, String name, String image) async {
    print("Signup");
    print(email);
    final http.Response response =
        await http.post(Uri.parse("${API.api}/signup"), body: {
      'email': email,
      'password': password,
      'name': name,
      'image': image != ""
          ? image
          : "https://image.shutterstock.com/image-vector/avatar-vector-male-profile-gray-260nw-538707355.jpg"
    }, headers: {
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    });
    print(response.body);
    return response.body;
  }

  Future getUser(String? token) async {
    if (token != null) {
      final http.Response response = await http.get(
          Uri.parse("${API.api}/getUser"),
          headers: {"Authorization": token});
      // if (response.statusCode == 200) {
      print("Response 1");
      print(response.body);
      return response.body;
    }
  }
}
