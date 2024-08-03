import 'package:flutter/material.dart';

class Flag extends StatefulWidget {
  final String flagNum; // This holds the string values for flag identification

  Flag({required this.flagNum}); // Constructor to receive flagNum

  @override
  _FlagState createState() => _FlagState(); // Create state for this widget
}

class _FlagState extends State<Flag> {
  @override
  void initState() {
    super.initState();
    // You can perform additional setup here if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 0, 0), // Red color
        title: Center(
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/redAlert.png"), // Ensure this asset exists
                fit: BoxFit.cover,
              ),
              
            ),
            child: Center(
              child: Text(
                'Flag ${widget.flagNum}', // Display the flag number
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
      body: Padding(
        padding: const EdgeInsets.all(18.0),
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
