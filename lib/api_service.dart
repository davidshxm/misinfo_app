import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'http://127.0.0.1:5000/'; // Update with your machine's IP address

  Future<String> fetchData() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl'));

      if (response.statusCode == 200) {
        print("Working");
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['result'];  // Use 'result' instead of 'value'
      } else {
        print("Fail");
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
