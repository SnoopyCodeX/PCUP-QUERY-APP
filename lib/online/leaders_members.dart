import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:query_app/online/settings.dart';
import 'package:query_app/online/report.dart';
import 'package:query_app/online/accreditation.dart';
import 'package:query_app/online/household.dart';
import 'package:query_app/online/login.dart';
import 'package:query_app/online/main.dart';

class LeadersScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  LeadersScreen({required this.userData});
  List<String> barangayNames = [];

  @override
  _LeadersScreenState createState() => _LeadersScreenState();
}

class _LeadersScreenState extends State<LeadersScreen> {
  List<Map<String, dynamic>> leaders = [];
  TextEditingController leaderNameController = TextEditingController();
  TextEditingController leaderPositionController = TextEditingController();
  TextEditingController leaderSexController = TextEditingController();
  TextEditingController leaderAgeController = TextEditingController();
  TextEditingController barangayController = TextEditingController();
  TextEditingController civilStatusController = TextEditingController();
  TextEditingController famMembersController = TextEditingController();
  TextEditingController totalMaleController = TextEditingController();
  TextEditingController totalFemaleController = TextEditingController();
  TextEditingController pwdMaleController = TextEditingController();
  TextEditingController pwdFemaleController = TextEditingController();
  TextEditingController srMaleController = TextEditingController();
  TextEditingController srFemaleController = TextEditingController();
  TextEditingController minorMaleController = TextEditingController();
  TextEditingController minorFemaleController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  @override
  void dispose() {
    leaderNameController.dispose();
    leaderPositionController.dispose();
    leaderSexController.dispose();
    leaderAgeController.dispose();
    barangayController.dispose();
    civilStatusController.dispose();
    famMembersController.dispose();
    totalMaleController.dispose();
    totalFemaleController.dispose();
    pwdMaleController.dispose();
    pwdFemaleController.dispose();
    srMaleController.dispose();
    srFemaleController.dispose();
    minorMaleController.dispose();
    minorFemaleController.dispose();
    remarksController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchBarangayNames();
    fetchLeaders();
  }

  Future<void> fetchLeaders() async {
    final Uri apiUrl =
        Uri.parse('http://192.168.254.159:8080/pcup-api/fetch_leaders.php');
    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is List) {
          setState(() {
            leaders = List<Map<String, dynamic>>.from(data);
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

  Future<void> fetchBarangayNames() async {
    final Uri apiUrl = Uri.parse(
        'http://192.168.254.159:8080/pcup-api/fetch_baranggayName.php');
    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is List) {
          final names = data.map((item) {
            // Extract the "Name" property from each object and convert it to a string
            return item['Name'].toString();
          }).toList();

          setState(() {
            widget.barangayNames = names;
          });
        } else {
          print('API did not return valid JSON data.');
        }
      } else {
        print('API Error: Status Code ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching barangay names: $e');
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
                builder: (context) => LoginScreen(userData: widget.userData)));
        break;
    }
  }

  bool _validateFields() {
    return leaderNameController.text.isNotEmpty &&
        leaderAgeController.text.isNotEmpty &&
        leaderSexController.text.isNotEmpty &&
        leaderPositionController.text.isNotEmpty &&
        barangayController.text.isNotEmpty &&
        civilStatusController.text.isNotEmpty &&
        famMembersController.text.isNotEmpty &&
        totalMaleController.text.isNotEmpty &&
        totalFemaleController.text.isNotEmpty &&
        pwdMaleController.text.isNotEmpty &&
        pwdFemaleController.text.isNotEmpty &&
        srFemaleController.text.isNotEmpty &&
        srMaleController.text.isNotEmpty &&
        minorFemaleController.text.isNotEmpty &&
        minorMaleController.text.isNotEmpty &&
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
        Uri.parse('http://192.168.254.159:8080/pcup-api/add_leaders.php');
    final response = await http.post(
      apiUrl,
      body: {
        'leader_name': leaderNameController.text,
        'leader_position': leaderPositionController.text,
        'leader_sex': leaderSexController.text,
        'leader_age': leaderAgeController.text.toString(),
        'leader_barangay': barangayController.text,
        'leader_civilstatus': civilStatusController.text,
        'leader_num_family_members': famMembersController.text.toString(),
        'leader_total_male': totalMaleController.text.toString(),
        'leader_total_female': totalFemaleController.text.toString(),
        'leader_totalpwd_physical_male': pwdMaleController.text.toString(),
        'leader_totalpwd_physical_female': pwdFemaleController.text.toString(),
        'leader_senior_male': srMaleController.toString(),
        'leader_senior_female': srFemaleController.text.toString(),
        'leader_below_18_male': minorMaleController.text.toString(),
        'leader_below_18_female': minorFemaleController.text.toString(),
        'leader_remarks': remarksController.text,
      },
    );

    if (response.statusCode == 200) {
      fetchLeaders();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully Added'),
        ),
      );
      leaderNameController.text = '';
      leaderPositionController.text = '';
      leaderSexController.text = '';
      leaderAgeController.text = '';
      barangayController.text = '';
      civilStatusController.text = '';
      famMembersController.text = '';
      totalFemaleController.text = '';
      totalMaleController.text = '';
      pwdFemaleController.text = '';
      pwdMaleController.text = '';
      srFemaleController.text = '';
      srMaleController.text = '';
      minorFemaleController.text = '';
      srMaleController.text = '';
      remarksController.text = '';
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to submit data'),
        ),
      );
    }
  }

  String? selectedPosition; // Set the default position
  String? selectedCivilStatus;
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
                  controller: leaderNameController,
                  decoration: InputDecoration(labelText: 'Leader Name'),
                ),

                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Leader Position'),
                  value: selectedPosition,
                  items: [
                    DropdownMenuItem(
                      value: 'PRESIDENT',
                      child: Text('PRESIDENT'),
                    ),
                    DropdownMenuItem(
                      value: 'MEMBER',
                      child: Text('MEMBER'),
                    ),
                  ],
                  onChanged: (selectedItem) {
                    setState(() {
                      selectedPosition = selectedItem;
                      leaderPositionController.text =
                          selectedItem!; // Update leaderPositionController
                    });
                  },
                ),

                TextFormField(
                  controller: leaderSexController,
                  decoration: InputDecoration(labelText: 'Leader Sex'),
                ),
                TextFormField(
                  controller: leaderAgeController,
                  decoration: InputDecoration(labelText: 'Leader Age'),
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Leader Barangay'),
                  value: widget.barangayNames.isNotEmpty
                      ? widget.barangayNames[0]
                      : null,
                  items: widget.barangayNames.map((String barangayName) {
                    return DropdownMenuItem<String>(
                      value: barangayName,
                      child: Text(barangayName),
                    );
                  }).toList(),
                  onChanged: (selectedBarangay) {
                    setState(() {
                      barangayController.text = selectedBarangay ?? '';
                    });
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Leader Civil Status'),
                  value: selectedCivilStatus,
                  items: [
                    DropdownMenuItem(
                      value: 'Single',
                      child: Text('Single'),
                    ),
                    DropdownMenuItem(
                      value: 'Married',
                      child: Text('Married'),
                    ),
                  ],
                  onChanged: (selectedItem) {
                    setState(() {
                      selectedCivilStatus = selectedItem;
                      civilStatusController.text =
                          selectedItem!; // Update leaderPositionController
                    });
                  },
                ),

                TextFormField(
                  controller: famMembersController,
                  decoration:
                      InputDecoration(labelText: 'Leader Family Members'),
                ),
                TextFormField(
                  controller: totalMaleController,
                  decoration: InputDecoration(labelText: 'Leader Total Male'),
                ),
                TextFormField(
                  controller: totalFemaleController,
                  decoration: InputDecoration(labelText: 'Leader Total Female'),
                ),
                TextFormField(
                  controller: pwdMaleController,
                  decoration:
                      InputDecoration(labelText: 'Leader Total PWD Male'),
                ),
                TextFormField(
                  controller: pwdFemaleController,
                  decoration:
                      InputDecoration(labelText: 'Leader Total PWD Female'),
                ),
                TextFormField(
                  controller: srMaleController,
                  decoration: InputDecoration(labelText: 'Leader Senior Male'),
                ),
                TextFormField(
                  controller: srFemaleController,
                  decoration:
                      InputDecoration(labelText: 'Leader Senior Female'),
                ),
                TextFormField(
                  controller: minorMaleController,
                  decoration:
                      InputDecoration(labelText: 'Leader Below 18 Male'),
                ),
                TextFormField(
                  controller: minorFemaleController,
                  decoration:
                      InputDecoration(labelText: 'Leader Below 18 Female'),
                ),
                TextFormField(
                  controller: remarksController,
                  decoration: InputDecoration(labelText: 'Leader Remarks'),
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
    final userImage = AssetImage('assets/images/avatar.png');
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaders and Members'),
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
          child: DataTable(
            columns: <DataColumn>[
              DataColumn(label: Text('Leader Name')),
              DataColumn(label: Text('Leader Position')),
              DataColumn(label: Text('Leader Sex')),
              DataColumn(label: Text('Leader Age')),
              DataColumn(label: Text('Leader Baranggay')),
              DataColumn(label: Text('Leader Civil Status')),
              DataColumn(label: Text('Leader Number Family Members')),
              DataColumn(label: Text('Leader Total Male')),
              DataColumn(label: Text('Leader Total Female')),
              DataColumn(label: Text('Leader PWD Total Male')),
              DataColumn(label: Text('Leader PWD Total Female')),
              DataColumn(label: Text('Leader Senior Male')),
              DataColumn(label: Text('Leader Senior Female')),
              DataColumn(label: Text('Leader Below 18 Male')),
              DataColumn(label: Text('Leader Below 18 Female')),
              DataColumn(label: Text('Leader Remarks')),
            ],
            rows: leaders
                .map(
                  (accreditation) => DataRow(
                    cells: <DataCell>[
                      DataCell(Text(accreditation['leader_name'].toString())),
                      DataCell(
                          Text(accreditation['leader_position'].toString())),
                      DataCell(Text(accreditation['leader_sex'].toString())),
                      DataCell(Text(accreditation['leader_age'].toString())),
                      DataCell(
                          Text(accreditation['leader_barangay'].toString())),
                      DataCell(
                          Text(accreditation['leader_civilstatus'].toString())),
                      DataCell(Text(accreditation['leader_num_family_members']
                          .toString())),
                      DataCell(
                          Text(accreditation['leader_total_male'].toString())),
                      DataCell(Text(
                          accreditation['leader_total_female'].toString())),
                      DataCell(Text(
                          accreditation['leader_totalpwd_physical_male']
                              .toString())),
                      DataCell(Text(
                          accreditation['leader_totalpwd_physical_female']
                              .toString())),
                      DataCell(
                          Text(accreditation['leader_senior_male'].toString())),
                      DataCell(Text(
                          accreditation['leader_senior_female'].toString())),
                      DataCell(Text(
                          accreditation['leader_below_18_male'].toString())),
                      DataCell(Text(
                          accreditation['leader_below_18_female'].toString())),
                      DataCell(
                          Text(accreditation['leader_remarks'].toString())),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showInsertDataDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
