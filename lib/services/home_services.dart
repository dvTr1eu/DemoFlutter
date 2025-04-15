import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeService {
  static const String _baseUrl = 'https://randomuser.me/api/?results=20';

  static fetchUser() async {
    final response = await http.get(Uri.parse(_baseUrl));

    try {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return json['results'];
      } else {
        throw Exception("Failed to load weather data");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
