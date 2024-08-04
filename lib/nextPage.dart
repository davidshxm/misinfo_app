import 'package:flutter/material.dart';
import 'api_service.dart';
import 'flag.dart';

class NextPage extends StatefulWidget {
  final String userName;

  NextPage({required this.userName});

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  final _nameController = TextEditingController();
  List<Map<String, String>> questions = [];
  late ApiService _apiService;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.userName;
    _apiService = ApiService();
    _apiService.startFetching((fetchedData) {
      setState(() {
        var splitData = _splitFetchedData(fetchedData);

        // If 'Initial Response' is 'true', remove it from the list
        if (splitData['Initial Response'] == 'true') {
          questions.removeWhere((item) => item['prompt'] == splitData['prompt']);
        } else if (splitData['Initial Response'] == 'false') {
          // Only add data if 'Initial Response' is 'false' and 'Source Response' is not empty
          if (!_containsPrompt(splitData['prompt'] ?? '') && splitData['Source Response']?.isNotEmpty == true) {
            questions.add(splitData);
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _apiService.stopFetching();
    super.dispose();
  }

  Map<String, String> _splitFetchedData(String data) {
    print(data);

    // Regular expressions to match the required parts of the data
    final promptRegExp = RegExp(r'Prompt:\s*(.*?)\n');
    final initialResponseRegExp = RegExp(r'Initial Response:\s*(.*?)\n');
    final sourceResponseRegExp = RegExp(r'Source Response:\s*(.*)');

    // Extract prompt and initial response
    final promptMatch = promptRegExp.firstMatch(data);
    final initialResponseMatch = initialResponseRegExp.firstMatch(data);

    // Check if 'Initial Response' is 'true'
    final isInitialResponseTrue = initialResponseMatch?.group(1)?.trim() == 'true';

    // If 'Initial Response' is 'true', return only prompt and initial response
    if (isInitialResponseTrue) {
      return {
        'prompt': promptMatch?.group(1)?.trim() ?? '',
        'Initial Response': 'true', // Explicitly setting 'true' to match the check
        'Source Response': '', // Empty as it should not be included
      };
    }

    // If 'Initial Response' is not 'true', also extract source response
    final sourceResponseMatch = sourceResponseRegExp.firstMatch(data);

    // Return data only if 'Source Response' is not empty
    final sourceResponse = sourceResponseMatch?.group(1)?.trim() ?? '';
    if (sourceResponse.isEmpty) {
      return {}; // Return an empty map to indicate no valid data
    }

    return {
      'prompt': promptMatch?.group(1)?.trim() ?? '',
      'Initial Response': initialResponseMatch?.group(1)?.trim() ?? '',
      'Source Response': sourceResponse,
    };
  }

  bool _containsPrompt(String prompt) {
    return questions.any((item) => item['prompt'] == prompt);
  }

  // Callback to remove an item from the list
  void _removeQuestion(String prompt) {
    setState(() {
      questions.removeWhere((item) => item['prompt'] == prompt);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffb3c1c5),
        title: Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/logo.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Text(
                'Misinformation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: Color(0xffb3c1c5),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),
            width: size.width - 50,
            height: size.height - 100,
            child: Column(
              children: [
                Expanded(
                  child: questions.isEmpty
                      ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'No Flagged Information',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                      : ListView.builder(
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      var item = questions[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Flag(
                                  userName: item['prompt'] ?? '',
                                  sourceResponse: item['Source Response'] ?? '',
                                  onDelete: () => _removeQuestion(item['prompt'] ?? ''),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            item['prompt'] ?? '',
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
