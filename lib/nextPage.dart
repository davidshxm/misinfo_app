import 'package:flutter/material.dart';
import 'api_service.dart'; // Ensure this import is correct
import 'flag.dart';

class OutputScreen extends StatefulWidget {
  final String userName;

  OutputScreen({required this.userName});

  @override
  _OutputScreenState createState() => _OutputScreenState();
}

class _OutputScreenState extends State<OutputScreen> {
  final _nameController = TextEditingController();
  List<String> _text = [];

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.userName;
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final data = await ApiService('http://localhost:5000').fetchOutput();
      setState(() {
        _text = List<String>.from([data['output']]); // Adjust according to your API response
      });
    } catch (e) {
      print('Error fetching data: $e');
      // Optionally, you can show an error message to the user
    }
  }

  void _navigateToFlagPage(String index) {
    final name = _nameController.text;
    print('Navigate to Flag Page');
    print('Entered Name: $name');
    print('Flag Index: $index');

    if (name.isNotEmpty) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Flag(flagNum: index),
        ),
      );
    } else {
      print('Name is empty. Navigation not triggered.');
    }
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
                if (_text.isEmpty)
                  Center(
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
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _text.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ElevatedButton(
                          onPressed: () {
                            _navigateToFlagPage('$index');
                          },
                          child: Text(
                            _text[index],
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(150, 50), // Set the minimum size for width and height
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15), // Keep the rounded edges
                            ),
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
