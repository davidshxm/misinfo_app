import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<Map<String, dynamic>> fetchOutput() async {
    final url = Uri.parse('$baseUrl/'); // Use baseUrl for flexibility
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print("Working");
        return json.decode(response.body); // Decode the JSON response
      } else {
        print('Failed to load output: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load output');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load output');
    }
  }
}
