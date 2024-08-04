import 'package:flutter/material.dart';

class Flag extends StatelessWidget {
  final String userName;
  final String sourceResponse;
  final VoidCallback onDelete;

  Flag({required this.userName, required this.sourceResponse, required this.onDelete});

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
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              print('No route to pop');
            }
          } else if (index == 1) {
            // Handle 'Delete' action
            print('Delete tapped');
            onDelete(); // Call the delete callback
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              print('No route to pop');
            }
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            children: [
              Text(sourceResponse),
              Text(
                'WARNING! '
                    'This information may not be accurate. Please review the following source: ',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
