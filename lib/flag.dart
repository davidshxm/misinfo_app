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
            icon: Icon(Icons.save), // Add an icon if needed
            label: 'Save for later',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete), // Add an icon if needed
            label: 'Delete',
          ),
        ],
        onTap: (int index) {
          if (index == 0) {
            // Handle 'Save for later' action
            print('Save for later tapped');
            // Navigate back if possible
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              // If no route to pop, handle accordingly (e.g., show a message)
              print('No route to pop');
            }
          } else if (index == 1) {
            // Handle 'Delete' action
            print('Delete tapped');
            // Navigate back if possible
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              // If no route to pop, handle accordingly (e.g., show a message)
              print('No route to pop');
            }
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Text(
            'WARNING! '
            'This information may not be accurate. Please review the following source: ',
            //''
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}


/* import 'package:flutter/material.dart';
import 'nextPage.dart'; // Ensure this import is correct

class Flag extends StatefulWidget {
  final String flagNum; // This holds the string values for flag identification

  Flag({required this.flagNum}); // Constructor to receive flagNum

  @override
  _FlagState createState() => _FlagState(); // Create state for this widget
}

class _FlagState extends State<Flag> {
  final _nameController = TextEditingController();
  bool delete = false;

  @override
  void initState() {
    super.initState();
    // You can perform additional setup here if needed
  }
  
  void _navigateToNextPage(String index) {
    final name = _nameController.text;
    print('Navigate to Flag Page');
    print('Entered Name: $name');
    print('Flag Index: $index');

    if (name.isNotEmpty) {
      print("test");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>(userName: index),
        ),
      );
    } else {
      print('Name is empty. Navigation not triggered.');
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
         icon: SizedBox.shrink(), // Hide the icon by setting an empty widget
          label: 'Save for later',
        ),
        BottomNavigationBarItem(
         icon: SizedBox.shrink(), // Hide the icon by setting an empty widget
           label: 'Delete',
         ),
         ],
        
        onTap: (int index) {
          if (index == 0) {
            // Handle 'Save for later' action
            print('Save for later tapped');
            // Navigate back if possible
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              // If no route to pop, handle accordingly (e.g., show a message)
              print('No route to pop');
            }
          } else if (index == 1) {
            // Handle 'Delete' action
            print('Delete tapped');
            // Navigate back if possible
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              // If no route to pop, handle accordingly (e.g., show a message)
              print('No route to pop');
            }
          }
        }

        ),
      );
  }
}

*/