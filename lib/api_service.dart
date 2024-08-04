import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'http://127.0.0.1:5000/'; // Update with your machine's IP address
  Timer? _timer;
  final Duration _fetchInterval = Duration(seconds: 2); // Adjust the interval as needed

  Future<String> fetchData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        print("Working");
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['result']; // Use 'result' instead of 'value'
      } else {
        print("Fail");
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  void startFetching(Function(String) onDataFetched) {
    _timer = Timer.periodic(_fetchInterval, (Timer t) async {
      try {
        String result = await fetchData();
        print("Fetched data: $result");
        onDataFetched(result); // Callback to update the state with fetched data
      } catch (e) {
        print("Error fetching data: $e");
      }
    });
  }

  void stopFetching() {
    _timer?.cancel();
  }
}
