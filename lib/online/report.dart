import 'package:flutter/material.dart';
import 'package:query_app/main.dart';
import 'package:query_app/online/login.dart';
import 'package:query_app/online/settings.dart';
import 'package:query_app/online/leaders_members.dart';
import 'package:query_app/online/accreditation.dart';
import 'package:query_app/online/household.dart';
import 'package:query_app/online/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReportScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  ReportScreen({required this.userData});

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<Map<String, dynamic>> reports = [];
  List<Map<String, dynamic>> violators = [];
  TextEditingController reportName = TextEditingController();
  TextEditingController reportFacilitator = TextEditingController();
  TextEditingController reportDate = TextEditingController();
  TextEditingController reportBarangay = TextEditingController();
  TextEditingController reportObjectives = TextEditingController();
  TextEditingController crimeViolation = TextEditingController();
  TextEditingController crimeDate = TextEditingController();
  TextEditingController crimeVictim = TextEditingController();
  TextEditingController crimeViolator = TextEditingController();
  TextEditingController crimeBarangay = TextEditingController();

  @override
  void dispose() {
    reportName.dispose();
    reportFacilitator.dispose();
    reportDate.dispose();
    reportBarangay.dispose();
    reportObjectives.dispose();
    crimeViolation.dispose();
    crimeBarangay.dispose();
    crimeDate.dispose();
    crimeVictim.dispose();
    crimeViolator.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchReports();
  }

  Future<void> fetchReports() async {
    final Uri apiUrl =
        Uri.parse('http://192.168.254.159:8080/pcup-api/fetch_report.php');
    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is List) {
          setState(() {
            reports = List<Map<String, dynamic>>.from(data);
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
                    MyHomePageOnline(userData: widget.userData)));
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
      case 'Logout':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    FolderSelectionScreen(userData: widget.userData)));
        break;
    }
  }

  bool _validateFieldsReport() {
    return reportName.text.isNotEmpty &&
        reportFacilitator.text.isNotEmpty &&
        reportDate.text.isNotEmpty &&
        reportBarangay.text.isNotEmpty &&
        reportObjectives.text.isNotEmpty;
  }

  bool _validateFieldsCrime() {
    return crimeViolator.text.isNotEmpty &&
        crimeVictim.text.isNotEmpty &&
        crimeViolation.text.isNotEmpty &&
        crimeBarangay.text.isNotEmpty &&
        crimeDate.text.isNotEmpty;
  }

  void _showRequiredFieldsAlertReport(BuildContext context) {
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

  void _showRequiredFieldsAlertCrime(BuildContext context) {
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

  void _submitReport() async {
    final apiUrl =
        Uri.parse('http://192.168.254.159:8080/pcup-api/add_report.php');
    final response = await http.post(
      apiUrl,
      body: {
        'report_name': reportName.text,
        'report_facilitator': reportFacilitator.text,
        'report_date': reportDate.text,
        'report_barangay': reportBarangay.text,
        'report_objective': reportObjectives.text,
      },
    );

    if (response.statusCode == 200) {
      fetchReports();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully Added'),
        ),
      );
      reportName.clear();
      reportBarangay.clear();
      reportDate.clear();
      reportFacilitator.clear();
      reportObjectives.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to submit data'),
        ),
      );
    }
  }

  void _submitCrime() async {
    final apiUrl =
        Uri.parse('http://192.168.254.159:8080/pcup-api/add_crime.php');
    final response = await http.post(
      apiUrl,
      body: {
        'crime_violation': crimeViolation.text,
        'crime_date': crimeDate.text,
        'crime_victim': crimeVictim.text,
        'crime_perpetrator': crimeViolator.text,
        'crime_barangay': crimeBarangay.text,
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully Added'),
        ),
      );
      crimeViolation.clear();
      crimeDate.clear();
      crimeVictim.clear();
      crimeViolator.clear();
      crimeBarangay.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to submit data'),
        ),
      );
    }
  }

  void _showInsertReport(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Insert Reports'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: reportName,
                  decoration: InputDecoration(labelText: 'Program Head'),
                ),
                TextFormField(
                  controller: reportFacilitator,
                  decoration: InputDecoration(labelText: 'Facilitator'),
                ),
                TextFormField(
                  controller: reportDate,
                  decoration: InputDecoration(labelText: 'Schedule Date'),
                ),
                TextFormField(
                  controller: reportBarangay,
                  decoration: InputDecoration(labelText: 'Barangay'),
                ),
                TextFormField(
                  controller: reportObjectives,
                  decoration: InputDecoration(labelText: 'Description'),
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
                if (_validateFieldsReport()) {
                  _submitReport();
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  _showRequiredFieldsAlertReport(context);
                }
              },
              child: Text("Insert"),
            ),
          ],
        );
      },
    );
  }

  void _showInsertCrime(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Insert Crime'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: crimeViolation,
                  decoration: InputDecoration(labelText: 'Crime Violation'),
                ),
                TextFormField(
                  controller: crimeDate,
                  decoration: InputDecoration(labelText: 'Crime Date'),
                ),
                TextFormField(
                  controller: crimeVictim,
                  decoration: InputDecoration(labelText: 'Crime Victim'),
                ),
                TextFormField(
                  controller: crimeViolator,
                  decoration: InputDecoration(labelText: 'Crime Violator'),
                ),
                TextFormField(
                  controller: crimeBarangay,
                  decoration: InputDecoration(labelText: 'Crime Barangay'),
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
                if (_validateFieldsCrime()) {
                  _submitCrime();
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  _showRequiredFieldsAlertCrime(context);
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
    final userImage = AssetImage('assets/images/avatar.png');
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
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
                            radius: 30,
                            backgroundImage: userImage,
                          ),
                          Text(
                            '${userData['user_name']}',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '${userData['user_email']}',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
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
                'Logout',
                Icons.logout,
                16, () {
              _navigateToScreen(
                  context, 'Logout'); // Pass context to _navigateToScreen
            }),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          /*      child: DataTable(
            columns: <DataColumn>[
              DataColumn(label: Text('Program Head')),
              DataColumn(label: Text('Facilitator')),
              DataColumn(label: Text('Schedule Date')),
              DataColumn(label: Text('Barangay')),
              DataColumn(label: Text('Description')),
            ],
            rows: reports
                .map(
                  (accreditation) => DataRow(
                    cells: <DataCell>[
                      DataCell(Text(accreditation['report_name'].toString())),
                      DataCell(
                          Text(accreditation['report_facilitator'].toString())),
                      DataCell(Text(accreditation['report_date'].toString())),
                      DataCell(
                          Text(accreditation['report_barangay'].toString())),
                      DataCell(
                          Text(accreditation['report_objective'].toString())),
                    ],
                  ),
                )
                .toList(),
          ), */
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              _showInsertReport(context);
            },
            label: Text('Add Report'), // Name for the first button
            icon: Icon(Icons.add),
          ),
          SizedBox(height: 16), // Add some spacing between the two buttons
          FloatingActionButton.extended(
            onPressed: () {
              _showInsertCrime(context);
            },
            label: Text('Another Crime'), // Name for the second button
            icon: Icon(Icons.add), // Replace with the desired icon
          ),
        ],
      ),
    );
  }
}
