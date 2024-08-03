import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'http://100.67.130.194:5000/'; // Update with your Flask server URL

  Future<String> fetchData() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/api/data'));

      if (response.statusCode == 200) {
        print("Working");
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['value'];
      } else {
        print("Fail");
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
