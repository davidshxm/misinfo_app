import 'package:flutter/material.dart';

import 'api_service.dart'; // Ensure this import is correct
import 'flag.dart';
import 'flag.dart'; // Ensure this import is correct

class OutputScreen extends StatefulWidget {
  final String userName;

  OutputScreen({required this.userName});

  @override
  _OutputScreenState createState() => _OutputScreenState();
}

class _OutputScreenState extends State<OutputScreen> {
  final _nameController = TextEditingController();
  List<String> _text = [];
}

class NextPage extends StatefulWidget {
  final String userName; // Add userName parameter

  NextPage({required this.userName}); // Update constructor

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  final _nameController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _nameController.text = widget.userName;
  }

  void _navigateToFlagPage(String index) {
    final name = _nameController.text;
    print('Navigate to Flag Page');
    print('Entered Name: $name');
    print('Flag Index: $index');

    if (name.isNotEmpty) {
      print("test");
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
    final size = MediaQuery
        .of(context)
        .size;
    List<String> text = List<String>.filled(140, "hello");

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
    itemCount: text.length,
    itemBuilder: (context, index) {
    return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: ElevatedButton(
    onPressed: () {
    _navigateToFlagPage('$index');
    },
    child: Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => Flag(userName: index.toString())),
    );
    },
    child: Text(
    text[index],
    style: TextStyle(fontSize: 18),
    ),
    style: ElevatedButton.styleFrom(
    minimumSize: Size(double.infinity, 50),
    ),
    )
    ,
    );
  }

  ,
  ),
  ),
  ],
  ),
  ),
  )

  ,

  )

  ,

  );
}}


