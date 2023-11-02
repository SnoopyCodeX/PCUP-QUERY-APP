import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:query_app/online/settings.dart';
import 'package:query_app/online/report.dart';
import 'package:query_app/online/leaders_members.dart';
import 'package:query_app/online/household.dart';
import 'package:query_app/online/main.dart';

class AccreditationScreen extends StatefulWidget {
  @override
  _AccreditationScreenState createState() => _AccreditationScreenState();
}

class _AccreditationScreenState extends State<AccreditationScreen> {
  List<Map<String, dynamic>> accreditations = [];
  String message = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController presidentController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController sexController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAccreditations();
  }

  Future<void> fetchAccreditations() async {
    final Uri apiUrl = Uri.parse(
        'http://sweet-salvador.kenkarlo.com/fetch_accreditations.php');
    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is List) {
          setState(() {
            accreditations = List<Map<String, dynamic>>.from(data);
          });
        } else {
          // Handle the case where the API did not return a JSON array as expected.
          print('API did not return valid JSON data.');
        }
      } else {
        // Handle non-200 status codes, indicating an API error.
        print('API Error: Status Code ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions, such as network errors or invalid JSON data.
      print('Error fetching data: $e');
    }
  }

  void _openModal(BuildContext context) {
    // Clear text fields when opening the modal
    nameController.clear();
    addressController.clear();
    presidentController.clear();
    contactController.clear();
    sexController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _buildModalContent(context);
      },
    );
  }

  Widget _buildModalContent(BuildContext context) {
    return AlertDialog(
      title: Text("Add Accreditation"),
      content: SingleChildScrollView(
        // Wrap the content in a SingleChildScrollView to make it scrollable
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Input fields
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: presidentController,
              decoration: InputDecoration(labelText: 'President'),
            ),
            TextField(
              controller: contactController,
              decoration: InputDecoration(labelText: 'Contact'),
            ),
            TextField(
              controller: sexController,
              decoration: InputDecoration(labelText: 'Sex'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            if (_validateFields()) {
              _submitData();
              Navigator.of(context).pop(); // Close the dialog
            } else {
              _showRequiredFieldsAlert(context);
            }
          },
          child: Text("Insert"),
        ),
      ],
    );
  }

  bool _validateFields() {
    return nameController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        presidentController.text.isNotEmpty &&
        contactController.text.isNotEmpty &&
        sexController.text.isNotEmpty;
  }

  Widget _buildListTile(
      String title, IconData iconData, double fontSize, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          leading: Icon(
            iconData,
            color: Colors.black,
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: fontSize),
          ),
          onTap: onTap,
        ),
      ),
    );
  }

  void _showRequiredFieldsAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Required Fields"),
          content: Text("Please fill in all required fields."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the alert
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _submitData() async {
    final apiUrl =
        Uri.parse('http://sweet-salvador.kenkarlo.com/add_accreditation.php');
    final response = await http.post(
      apiUrl,
      body: {
        'Name': nameController.text,
        'Address': addressController.text,
        'President': presidentController.text,
        'Contact': contactController.text,
        'Sex': sexController.text,
      },
    );

    if (response.statusCode == 200) {
      fetchAccreditations();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully Added'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to submit data'),
        ),
      );
    }
  }

  void _navigateToScreen(String routeName) {
    Navigator.of(context).pop(); // Close the sidebar
    switch (routeName) {
      case 'Home':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePageOnline()));
        break;
      case 'Accreditation':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AccreditationScreen()));
        break;
      case 'Leaders and Members':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LeadersScreen()));
        break;
      case 'Household':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => houseHoldScreen()));
        break;
      case 'Report':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ReportScreen()));
        break;
      case 'Settings':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SettingsScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accreditation'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10),
                    FutureBuilder<Map<String, dynamic>>(
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text(
                            'Error loading user data',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          );
                        } else {
                          // Static text
                          final firstname = 'John';
                          final lastname = 'Doe';
                          final userEmail = 'john.doe@example.com';

                          return Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 3,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.blueAccent[100],
                                      radius: 30,
                                      backgroundImage: AssetImage(
                                          'assets/images/logo.png'), // Replace with actual user image
                                    ),
                                    Text(
                                      '$firstname $lastname',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '$userEmail',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            _buildListTile('Home', Icons.home, 16, () {
              _navigateToScreen('Home');
            }),
            _buildListTile('Accreditation', Icons.verified_user, 16, () {
              _navigateToScreen('Accreditation');
            }),
            _buildListTile('Leaders and Members', Icons.group, 16, () {
              _navigateToScreen('Leaders and Members');
            }),
            _buildListTile('Household', Icons.home_work, 16, () {
              _navigateToScreen('Household');
            }),
            _buildListTile('Report', Icons.list_alt_rounded, 16, () {
              _navigateToScreen('Report');
            }),
            _buildListTile('Settings', Icons.settings, 16, () {
              _navigateToScreen('Settings');
            }),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: <DataColumn>[
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Address')),
              DataColumn(label: Text('President')),
              DataColumn(label: Text('Contact')),
              DataColumn(label: Text('Sex')),
            ],
            rows: accreditations
                .map(
                  (accreditation) => DataRow(
                    cells: <DataCell>[
                      DataCell(Text(accreditation['Name'].toString())),
                      DataCell(Text(accreditation['address'].toString())),
                      DataCell(Text(accreditation['president'].toString())),
                      DataCell(Text(accreditation['contact'].toString())),
                      DataCell(Text(accreditation['sex'].toString())),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openModal(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AccreditationScreen(),
  ));
}
