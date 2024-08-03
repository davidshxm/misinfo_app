import 'package:flutter/material.dart';

class Flag extends StatelessWidget {
  final String userName;

  // Constructor with named parameter
  Flag({required this.userName});

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
    _nameController.text = widget.userName; // Pre-fill the text field with userName
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
          builder: (context) => Flag(userName: index),
        ),
      );
    } else {
      print('Name is empty. Navigation not triggered.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                            Navigator.push(
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