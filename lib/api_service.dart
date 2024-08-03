import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<Map<String, dynamic>> fetchOutput() async {
    final response = await http.get(Uri.parse('http://100.67.130.194:5000/'));

    if (response.statusCode == 200) {
      print("Working");
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load output');
    }
  }
}
