import 'package:flutter/material.dart';
import 'nextPage.dart'; // Ensure this import is correct

class Flag extends StatefulWidget {
  final String flagNum; // This holds the string values for flag identification

  Flag({required this.flagNum}); // Constructor to receive flagNum

  @override
  _FlagState createState() => _FlagState(); // Create state for this widget
}

class _FlagState extends State<Flag> {
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // You can perform additional setup here if needed
  }

  void _navigateToNextPage() {
    final name = _nameController.text;

    if (name.isNotEmpty) {
      print("test");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => OutputScreen(userName: name),
        ),
      );
    } else {
      print('Name is empty. Navigation not triggered.');
    }
  }

  void _navigateBackWithResult() {
    final name = _nameController.text;

    if (name.isNotEmpty) {
      Navigator.of(context).pop(name); // Pass data when navigating back
    } else {
      Navigator.of(context).pop(); // Just navigate back if no data
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 0, 0), // Red color
        title: Center(
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/redAlert.png"), // Ensure this asset exists
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back),
            label: 'Back',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.navigate_next),
            label: 'Next',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            _navigateBackWithResult(); // Handle back navigation
          } else if (index == 1) {
            _navigateToNextPage(); // Handle next navigation
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Text(
            'This is flag number ${widget.flagNum}',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}