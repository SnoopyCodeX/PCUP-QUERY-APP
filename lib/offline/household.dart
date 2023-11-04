import 'package:flutter/material.dart';
import 'package:query_app/offline/report.dart';
import 'package:query_app/offline/accreditation.dart';
import 'package:query_app/offline/main.dart';
import 'package:query_app/offline/leaders_members.dart';
import 'package:query_app/offline/settings.dart';
import 'package:query_app/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class houseHoldScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  houseHoldScreen({required this.userData});

  @override
  _houseHoldScreenState createState() => _houseHoldScreenState();
}

class _houseHoldScreenState extends State<houseHoldScreen> {
  List<Map<String, dynamic>> household = [];
  TextEditingController householdLastnameController = TextEditingController();
  TextEditingController householdFirstnameController = TextEditingController();
  TextEditingController householdMiddlenameController = TextEditingController();
  TextEditingController hourseholdSuffixController = TextEditingController();
  TextEditingController householdBirthdateController = TextEditingController();
  TextEditingController householdAgeController = TextEditingController();
  TextEditingController householdSexController = TextEditingController();
  TextEditingController pregnantController = TextEditingController();
  TextEditingController lastPregnantController = TextEditingController();
  TextEditingController noChildrenController = TextEditingController();
  TextEditingController baranggayController = TextEditingController();
  TextEditingController educAttainmentController = TextEditingController();
  TextEditingController schoolGraudatedController = TextEditingController();
  TextEditingController incomeController = TextEditingController();
  TextEditingController employedController = TextEditingController();
  TextEditingController householdLeaderController = TextEditingController();
  TextEditingController leaderRelationController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  @override
  void dispose() {
    householdLastnameController.dispose();
    householdFirstnameController.dispose();
    householdMiddlenameController.dispose();
    hourseholdSuffixController.dispose();
    householdBirthdateController.dispose();
    householdAgeController.dispose();
    householdSexController.dispose();
    lastPregnantController.dispose();
    pregnantController.dispose();
    noChildrenController.dispose();
    baranggayController.dispose();
    educAttainmentController.dispose();
    schoolGraudatedController.dispose();
    incomeController.dispose();
    employedController.dispose();
    householdLeaderController.dispose();
    leaderRelationController.dispose();
    remarksController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchHousehold();
  }

  Future<void> fetchHousehold() async {
    final Uri apiUrl =
        Uri.parse('http://192.168.254.159:8080/pcup-api/fetch_household.php');
    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is List) {
          setState(() {
            household = List<Map<String, dynamic>>.from(data);
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

  Widget _buildListTile(BuildContext context, String title, IconData iconData,
      double fontSize, VoidCallback onTap) {
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

  void _navigateToScreen(BuildContext context, String routeName) {
    Navigator.of(context).pop(); // Close the sidebar
    switch (routeName) {
      case 'Home':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MyHomePageOffline(userData: widget.userData)));
        break;
      case 'Accreditation':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AccreditationScreen(userData: widget.userData)));
        break;
      case 'Leaders and Members':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LeadersScreen(userData: widget.userData)));
        break;
      case 'Household':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    houseHoldScreen(userData: widget.userData)));
        break;
      case 'Report':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReportScreen(userData: widget.userData)));
        break;
      case 'Settings':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SettingsScreen(userData: widget.userData)));
        break;
      case 'Back':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    FolderSelectionScreen(userData: widget.userData)));
        break;
    }
  }

  bool _validateFields() {
    return householdLastnameController.text.isNotEmpty &&
        householdFirstnameController.text.isNotEmpty &&
        householdMiddlenameController.text.isNotEmpty &&
        hourseholdSuffixController.text.isNotEmpty &&
        householdAgeController.text.isNotEmpty &&
        householdBirthdateController.text.isNotEmpty &&
        householdSexController.text.isNotEmpty &&
        pregnantController.text.isNotEmpty &&
        lastPregnantController.text.isNotEmpty &&
        noChildrenController.text.isNotEmpty &&
        baranggayController.text.isNotEmpty &&
        educAttainmentController.text.isNotEmpty &&
        schoolGraudatedController.text.isNotEmpty &&
        incomeController.text.isNotEmpty &&
        employedController.text.isNotEmpty &&
        householdLeaderController.text.isNotEmpty &&
        leaderRelationController.text.isNotEmpty &&
        remarksController.text.isNotEmpty;
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
        Uri.parse('http://192.168.254.159:8080/pcup-api/add_household.php');
    final response = await http.post(
      apiUrl,
      body: {
        'household_lastname': householdLastnameController.text,
        'household_firstname': householdFirstnameController.text,
        'household_middlename': householdMiddlenameController.text,
        'household_suffix': hourseholdSuffixController.text,
        'household_birthdate': householdBirthdateController.text,
        'household_age': householdAgeController.text.toString(),
        'household_sex': householdSexController.text,
        'pregnant': pregnantController.text,
        'last_preg': lastPregnantController.text,
        'children': noChildrenController.text.toString(),
        'household_barangay': baranggayController.text,
        'household_education': educAttainmentController.text,
        'household_school': schoolGraudatedController.text,
        'source': incomeController.text,
        'employment': employedController.text,
        'household_leader': householdLeaderController.text,
        'household_relation': leaderRelationController.text,
        'household_remarks': remarksController.text,
      },
    );

    if (response.statusCode == 200) {
      fetchHousehold();
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

  void _showInsertDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Insert Data'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: householdLastnameController,
                  decoration: InputDecoration(labelText: 'Household LastName'),
                ),
                TextFormField(
                  controller: householdFirstnameController,
                  decoration: InputDecoration(labelText: 'Household FirstName'),
                ),
                TextFormField(
                  controller: householdMiddlenameController,
                  decoration:
                      InputDecoration(labelText: 'Household MiddleName'),
                ),
                TextFormField(
                  controller: hourseholdSuffixController,
                  decoration: InputDecoration(labelText: 'Household Suffix'),
                ),
                TextFormField(
                  controller: householdBirthdateController,
                  decoration: InputDecoration(labelText: 'Household Birthdate'),
                ),
                TextFormField(
                  controller: householdAgeController,
                  decoration: InputDecoration(labelText: 'Household Age'),
                ),
                TextFormField(
                  controller: householdSexController,
                  decoration: InputDecoration(labelText: 'Household Sex'),
                ),
                TextFormField(
                  controller: pregnantController,
                  decoration: InputDecoration(labelText: 'Household Pregnant'),
                ),
                TextFormField(
                  controller: lastPregnantController,
                  decoration:
                      InputDecoration(labelText: 'Household Last Pregnant'),
                ),
                TextFormField(
                  controller: noChildrenController,
                  decoration: InputDecoration(labelText: 'Household No. Child'),
                ),
                TextFormField(
                  controller: baranggayController,
                  decoration: InputDecoration(labelText: 'Household Baranggay'),
                ),
                TextFormField(
                  controller: educAttainmentController,
                  decoration: InputDecoration(
                      labelText: 'Household Educational Attainment'),
                ),
                TextFormField(
                  controller: schoolGraudatedController,
                  decoration:
                      InputDecoration(labelText: 'Household School Graduated'),
                ),
                TextFormField(
                  controller: incomeController,
                  decoration:
                      InputDecoration(labelText: 'Household Source of Income'),
                ),
                TextFormField(
                  controller: employedController,
                  decoration: InputDecoration(labelText: 'Currently Employed'),
                ),
                TextFormField(
                  controller: householdLeaderController,
                  decoration: InputDecoration(labelText: 'Household Leader'),
                ),
                TextFormField(
                  controller: leaderRelationController,
                  decoration: InputDecoration(labelText: 'Household Relation'),
                ),
                TextFormField(
                  controller: remarksController,
                  decoration: InputDecoration(labelText: 'Household Remarks'),
                ),
                // Add more TextFormFields with respective controllers for other fields
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userData = widget.userData;
    return Scaffold(
      appBar: AppBar(
        title: Text('Household'),
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
                                          'assets/images/avatar.png'), // Replace with actual user image
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
            _buildListTile(
                context, // Pass the context
                'Home',
                Icons.home,
                16, () {
              _navigateToScreen(
                  context, 'Home'); // Pass context to _navigateToScreen
            }),
            _buildListTile(
                context, // Pass the context
                'Accreditation',
                Icons.verified_user,
                16, () {
              _navigateToScreen(context,
                  'Accreditation'); // Pass context to _navigateToScreen
            }),
            _buildListTile(
                context, // Pass the context
                'Leaders and Members',
                Icons.group,
                16, () {
              _navigateToScreen(context,
                  'Leaders and Members'); // Pass context to _navigateToScreen
            }),
            _buildListTile(
                context, // Pass the context
                'Household',
                Icons.home_work,
                16, () {
              _navigateToScreen(
                  context, 'Household'); // Pass context to _navigateToScreen
            }),
            _buildListTile(
                context, // Pass the context
                'Report',
                Icons.list_alt_rounded,
                16, () {
              _navigateToScreen(
                  context, 'Report'); // Pass context to _navigateToScreen
            }),
            _buildListTile(
                context, // Pass the context
                'Settings',
                Icons.settings,
                16, () {
              _navigateToScreen(
                  context, 'Settings'); // Pass context to _navigateToScreen
            }),
            _buildListTile(
                context, // Pass the context
                'Back',
                Icons.logout_rounded,
                16, () {
              _navigateToScreen(
                  context, 'Back'); // Pass context to _navigateToScreen
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
              DataColumn(label: Text('Household LastName')),
              DataColumn(label: Text('Household FirstName')),
              DataColumn(label: Text('Household MiddleName')),
              DataColumn(label: Text('Household Suffix')),
              DataColumn(label: Text('Household Birthdate')),
              DataColumn(label: Text('Household Age')),
              DataColumn(label: Text('Household Sex')),
              DataColumn(label: Text('Household Pregnant')),
              DataColumn(label: Text('Household Last Pregnant')),
              DataColumn(label: Text('Household No. Child')),
              DataColumn(label: Text('Household Barangay')),
              DataColumn(label: Text('Household Educational Attainment')),
              DataColumn(label: Text('Household School Graduated')),
              DataColumn(label: Text('Household Source of Income')),
              DataColumn(label: Text('Household Currently Employed')),
              DataColumn(label: Text('Household Leader')),
              DataColumn(label: Text('Household Relation')),
              DataColumn(label: Text('Leader Remarks')),
            ],
            rows: household
                .map(
                  (accreditation) => DataRow(
                    cells: <DataCell>[
                      DataCell(
                          Text(accreditation['household_lastname'].toString())),
                      DataCell(Text(
                          accreditation['household_firstname'].toString())),
                      DataCell(Text(
                          accreditation['household_middlename'].toString())),
                      DataCell(
                          Text(accreditation['household_suffix'].toString())),
                      DataCell(Text(
                          accreditation['household_birthdate'].toString())),
                      DataCell(Text(accreditation['household_age'].toString())),
                      DataCell(Text(accreditation['household_sex'].toString())),
                      DataCell(Text(accreditation['pregnant'].toString())),
                      DataCell(Text(accreditation['last_preg'].toString())),
                      DataCell(Text(accreditation['children'].toString())),
                      DataCell(
                          Text(accreditation['household_barangay'].toString())),
                      DataCell(Text(
                          accreditation['household_education'].toString())),
                      DataCell(
                          Text(accreditation['household_school'].toString())),
                      DataCell(Text(accreditation['source'].toString())),
                      DataCell(Text(accreditation['employment'].toString())),
                      DataCell(
                          Text(accreditation['household_leader'].toString())),
                      DataCell(
                          Text(accreditation['household_relation'].toString())),
                      DataCell(
                          Text(accreditation['household_remarks'].toString())),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              _showInsertDataDialog(context);
            },
            label: Text('Add Household'), // Name for the first button
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
