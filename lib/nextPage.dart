import 'package:flutter/material.dart';
import 'api_service.dart'; // Import the ApiService class

class Flag extends StatelessWidget {
  final String userName;

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
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              print('No route to pop');
            }
          } else if (index == 1) {
            // Handle 'Delete' action
            print('Delete tapped');
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
          child: Text(
            'WARNING! '
                'This information may not be accurate. Please review the following source: ',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}

class NextPage extends StatefulWidget {
  final String userName;

  NextPage({required this.userName});

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  final _nameController = TextEditingController();
  List<String> _text = []; // Initialize the _text list
  late ApiService _apiService; // Declare ApiService instance

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.userName;
    _apiService = ApiService('http://100.67.130.194:5000'); // Initialize ApiService with baseUrl
    _fetchData(); // Fetch data after initializing ApiService
  }

  Future<void> _fetchData() async {
    try {
      final response = await _apiService.fetchOutput();
      setState(() {
        _text = List<String>.from(response['data']); // Update the list with fetched data
      });
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error as needed, e.g., show an error message
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Flag(userName: _text[index]),
                              ),
                            );
                          },
                          child: Text(
                            _text[index],
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
