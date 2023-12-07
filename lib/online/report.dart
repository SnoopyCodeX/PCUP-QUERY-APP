// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:query_app/main.dart';
import 'package:query_app/online/accreditation.dart';
import 'package:query_app/online/household.dart';
import 'package:query_app/online/leaders_members.dart';
import 'package:query_app/online/main.dart';
import 'package:query_app/online/settings.dart';
import 'package:query_app/source/crime_data_source.dart';
import 'package:query_app/source/report_data_source.dart';

class ReportScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const ReportScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final ROWS_PER_PAGE = 5;

  List<Map<String, dynamic>> reports = [];
  List<Map<String, dynamic>> violators = [];
  List<String> barangayNames = [];
  List<String> barangayCrimeNames = [];

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

  void clearTextControllers() {
    reportName.clear();
    reportFacilitator.clear();
    reportDate.clear();
    reportBarangay.clear();
    reportObjectives.clear();
    crimeViolation.clear();
    crimeBarangay.clear();
    crimeDate.clear();
    crimeVictim.clear();
    crimeViolator.clear();
  }

  @override
  void initState() {
    super.initState();
    fetchBarangayNames();
    fetchBarangayCrimeNames();

    fetchReports();
    fetchCrimes();
  }

  Future<void> fetchReports() async {
    final Uri apiUrl = Uri.parse('http://sweet-salvador.kenkarlo.com/PCUP-API/online/fetch_report.php');
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
          debugPrint('API did not return valid JSON data.');
        }
      } else {
        // Handle non-200 status codes, indicating an API error.
        debugPrint('API Error: Status Code ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions, such as network errors or invalid JSON data.
      debugPrint('Error fetching data: $e');
    }
  }

  Future<void> fetchCrimes() async {
    final Uri apiUrl = Uri.parse('http://sweet-salvador.kenkarlo.com/PCUP-API/online/fetch_crime.php');
    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is List) {
          setState(() {
            violators = List<Map<String, dynamic>>.from(data);
          });
        } else {
          // Handle the case where the API did not return a JSON array as expected.
          debugPrint('API did not return valid JSON data.');
        }
      } else {
        // Handle non-200 status codes, indicating an API error.
        debugPrint('API Error: Status Code ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions, such as network errors or invalid JSON data.
      debugPrint('Error fetching data: $e');
    }
  }

  Future<void> fetchBarangayNames() async {
    final Uri apiUrl = Uri.parse('https://sweet-salvador.kenkarlo.com/PCUP-API/online/fetch_baranggayName.php');
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
            barangayNames = names;
          });
        } else {
          debugPrint('API did not return valid JSON data.');
        }
      } else {
        debugPrint('API Error: Status Code ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching barangay names: $e');
    }
  }

  Future<void> fetchBarangayCrimeNames() async {
    final Uri apiUrl = Uri.parse('https://sweet-salvador.kenkarlo.com/PCUP-API/online/fetch_baranggayName.php');
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
            barangayCrimeNames = names;
          });
        } else {
          debugPrint('API did not return valid JSON data.');
        }
      } else {
        debugPrint('API Error: Status Code ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching barangay names: $e');
    }
  }

  Widget _buildListTile(BuildContext context, String title, IconData iconData, double fontSize, VoidCallback onTap) {
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePageOnline(userData: widget.userData)));
        break;
      case 'Accreditation':
        Navigator.push(context, MaterialPageRoute(builder: (context) => AccreditationScreen(userData: widget.userData)));
        break;
      case 'Leaders and Members':
        Navigator.push(context, MaterialPageRoute(builder: (context) => LeadersScreen(userData: widget.userData)));
        break;
      case 'Household':
        Navigator.push(context, MaterialPageRoute(builder: (context) => houseHoldScreen(userData: widget.userData)));
        break;
      case 'Report':
        Navigator.push(context, MaterialPageRoute(builder: (context) => ReportScreen(userData: widget.userData)));
        break;
      case 'Settings':
        Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen(userData: widget.userData)));
        break;
      case 'Logout':
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(userData: widget.userData)));
        break;
    }
  }

  bool _validateFieldsReport() {
    return reportName.text.isNotEmpty && reportFacilitator.text.isNotEmpty && reportDate.text.isNotEmpty && reportBarangay.text.isNotEmpty && reportObjectives.text.isNotEmpty;
  }

  bool _validateFieldsCrime() {
    return crimeViolator.text.isNotEmpty && crimeVictim.text.isNotEmpty && crimeViolation.text.isNotEmpty && crimeBarangay.text.isNotEmpty && crimeDate.text.isNotEmpty;
  }

  void _showRequiredFieldsAlertReport(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Required Fields"),
          content: const Text("Please fill in all required fields."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the alert
              },
              child: const Text("OK"),
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
          title: const Text("Required Fields"),
          content: const Text("Please fill in all required fields."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the alert
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _submitReport() async {
    final apiUrl = Uri.parse('https://sweet-salvador.kenkarlo.com/PCUP-API/online/add_report.php');
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
      await fetchReports();

      WidgetsBinding.instance.addPostFrameCallback((_) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Successfully Added'),
            ),
          ));

      clearTextControllers();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to submit data'),
            ),
          ));
    }
  }

  void _submitUpdatedReport(int index) async {
    final apiUrl = Uri.parse('https://sweet-salvador.kenkarlo.com/PCUP-API/online/update_report.php');
    final response = await http.post(
      apiUrl,
      body: {
        'report_id': reports[index]['report_id'],
        'report_name': reportName.text,
        'report_facilitator': reportFacilitator.text,
        'report_date': reportDate.text,
        'report_barangay': reportBarangay.text,
        'report_objective': reportObjectives.text,
      },
    );

    if (response.statusCode == 200) {
      await fetchReports();

      WidgetsBinding.instance.addPostFrameCallback((_) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Successfully updated'),
            ),
          ));

      clearTextControllers();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to submit updated data'),
            ),
          ));
    }
  }

  void _submitCrime() async {
    final apiUrl = Uri.parse('https://sweet-salvador.kenkarlo.com/PCUP-API/online/add_crime.php');
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
      await fetchCrimes();

      WidgetsBinding.instance.addPostFrameCallback((_) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Successfully Added'),
            ),
          ));

      clearTextControllers();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to submit data'),
            ),
          ));
    }
  }

  void _submitUpdatedCrime(int index) async {
    final apiUrl = Uri.parse('https://sweet-salvador.kenkarlo.com/PCUP-API/online/update_crime.php');
    final response = await http.post(
      apiUrl,
      body: {
        'crime_id': violators[index]['crime_id'],
        'crime_violation': crimeViolation.text,
        'crime_date': crimeDate.text,
        'crime_victim': crimeVictim.text,
        'crime_perpetrator': crimeViolator.text,
        'crime_barangay': crimeBarangay.text,
      },
    );

    if (response.statusCode == 200) {
      await fetchCrimes();

      WidgetsBinding.instance.addPostFrameCallback((_) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Successfully Updated'),
            ),
          ));

      clearTextControllers();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to submit updated data'),
            ),
          ));
    }
  }

  DateTime? selectedsheduleDate;
  DateTime? selectedcrimeDate;
  Future<void> _selectscheduleDate(BuildContext context) async {
    final DateTime? picked = (await showDatePicker(
      context: context,
      initialDate: selectedsheduleDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ));

    if (picked != null && picked != selectedsheduleDate) {
      setState(() {
        selectedsheduleDate = picked;
        reportDate.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  Future<void> _selectschedulecrimeDate(BuildContext context) async {
    final DateTime? picked = (await showDatePicker(
      context: context,
      initialDate: selectedcrimeDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ));

    if (picked != null && picked != selectedcrimeDate) {
      setState(() {
        selectedcrimeDate = picked;
        crimeDate.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  void _showInsertReport(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Insert Reports'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: reportName,
                  decoration: const InputDecoration(labelText: 'Program Head'),
                ),
                TextFormField(
                  controller: reportFacilitator,
                  decoration: const InputDecoration(labelText: 'Facilitator'),
                ),
                TextFormField(
                  controller: reportDate,
                  decoration: const InputDecoration(
                    labelText: 'Report Birthdate',
                    hintText: 'Select date',
                    labelStyle: TextStyle(color: Colors.grey),
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.calendar_today, color: Colors.blue),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onTap: () {
                    _selectscheduleDate(context);
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Select Barangay'),
                  value: barangayNames.isNotEmpty ? barangayNames[0] : null,
                  items: barangayNames.map((String barangayName) {
                    return DropdownMenuItem<String>(
                      value: barangayName,
                      child: Text(barangayName),
                    );
                  }).toList(),
                  onChanged: (selectedBarangay) {
                    setState(() {
                      reportBarangay.text = selectedBarangay ?? '';
                    });
                  },
                ),
                TextFormField(
                  controller: reportObjectives,
                  decoration: const InputDecoration(labelText: 'Description'),
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
              child: const Text('Cancel'),
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
              child: const Text("Insert"),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateReport(BuildContext context, int index) {
    reportName = TextEditingController(text: reports[index]['report_name'].toString());
    reportFacilitator = TextEditingController(text: reports[index]['report_facilitator'].toString());
    reportDate = TextEditingController(text: reports[index]['report_date'].toString());
    reportBarangay = TextEditingController(text: reports[index]['report_barangay'].toString());
    reportObjectives = TextEditingController(text: reports[index]['report_objective'].toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Insert Reports'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: reportName,
                  decoration: const InputDecoration(labelText: 'Program Head'),
                ),
                TextFormField(
                  controller: reportFacilitator,
                  decoration: const InputDecoration(labelText: 'Facilitator'),
                ),
                TextFormField(
                  controller: reportDate,
                  decoration: const InputDecoration(
                    labelText: 'Report Birthdate',
                    hintText: 'Select date',
                    labelStyle: TextStyle(color: Colors.grey),
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.calendar_today, color: Colors.blue),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onTap: () {
                    _selectscheduleDate(context);
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Select Barangay'),
                  value: reportBarangay.text.isEmpty || reportBarangay.text == 'null' ? null : reportBarangay.text,
                  items: barangayNames.map((String barangayName) {
                    return DropdownMenuItem<String>(
                      value: barangayName,
                      child: Text(barangayName),
                    );
                  }).toList(),
                  onChanged: (selectedBarangay) {
                    setState(() {
                      reportBarangay.text = selectedBarangay ?? '';
                    });
                  },
                ),
                TextFormField(
                  controller: reportObjectives,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),

                // Add more TextFormFields with respective controllers for other fields
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                clearTextControllers();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_validateFieldsReport()) {
                  _submitUpdatedReport(index);
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  _showRequiredFieldsAlertReport(context);
                }
              },
              child: const Text("Update"),
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
          title: const Text('Insert Crime'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: crimeViolation,
                  decoration: const InputDecoration(labelText: 'Crime Violation'),
                ),
                TextFormField(
                  controller: crimeDate,
                  decoration: const InputDecoration(
                    labelText: 'Crime Date',
                    hintText: 'Select date',
                    labelStyle: TextStyle(color: Colors.grey),
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.calendar_today, color: Colors.blue),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onTap: () {
                    _selectschedulecrimeDate(context);
                  },
                ),
                TextFormField(
                  controller: crimeVictim,
                  decoration: const InputDecoration(labelText: 'Crime Victim'),
                ),
                TextFormField(
                  controller: crimeViolator,
                  decoration: const InputDecoration(labelText: 'Crime Violator'),
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Select Barangay'),
                  value: barangayCrimeNames.isNotEmpty ? barangayCrimeNames[0] : null,
                  items: barangayCrimeNames.map((String barangaycrimeName) {
                    return DropdownMenuItem<String>(
                      value: barangaycrimeName,
                      child: Text(barangaycrimeName),
                    );
                  }).toList(),
                  onChanged: (selectedBarangay) {
                    setState(() {
                      crimeBarangay.text = selectedBarangay ?? '';
                    });
                  },
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
              child: const Text('Cancel'),
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
              child: const Text("Insert"),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateCrime(BuildContext context, int index) {
    crimeViolation = TextEditingController(text: violators[index]['crime_violation'].toString());
    crimeDate = TextEditingController(text: violators[index]['crime_date'].toString());
    crimeVictim = TextEditingController(text: violators[index]['crime_victim'].toString());
    crimeViolator = TextEditingController(text: violators[index]['crime_perpetrator'].toString());
    crimeBarangay = TextEditingController(text: violators[index]['crime_barangay'].toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Crime'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: crimeViolation,
                  decoration: const InputDecoration(labelText: 'Crime Violation'),
                ),
                TextFormField(
                  controller: crimeDate,
                  decoration: const InputDecoration(
                    labelText: 'Crime Date',
                    hintText: 'Select date',
                    labelStyle: TextStyle(color: Colors.grey),
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.calendar_today, color: Colors.blue),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onTap: () {
                    _selectschedulecrimeDate(context);
                  },
                ),
                TextFormField(
                  controller: crimeVictim,
                  decoration: const InputDecoration(labelText: 'Crime Victim'),
                ),
                TextFormField(
                  controller: crimeViolator,
                  decoration: const InputDecoration(labelText: 'Crime Violator'),
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Select Barangay'),
                  value: crimeBarangay.text.toUpperCase(),
                  items: barangayCrimeNames.map((String barangaycrimeName) {
                    return DropdownMenuItem<String>(
                      value: barangaycrimeName,
                      child: Text(barangaycrimeName),
                    );
                  }).toList(),
                  onChanged: (selectedBarangay) {
                    setState(() {
                      crimeBarangay.text = selectedBarangay ?? '';
                    });
                  },
                ),

                // Add more TextFormFields with respective controllers for other fields
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                clearTextControllers();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_validateFieldsCrime()) {
                  _submitUpdatedCrime(index);
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  _showRequiredFieldsAlertCrime(context);
                }
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userData = widget.userData;
    const userImage = AssetImage('assets/images/avatar.png');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage: userImage,
                          ),
                          Text(
                            '${userData['user_name']}',
                            style: const TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${userData['user_email']}',
                            style: const TextStyle(color: Colors.white, fontSize: 16),
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
              _navigateToScreen(context, 'Home'); // Pass context to _navigateToScreen
            }),
            _buildListTile(
                context, // Pass the context
                'Accreditation',
                Icons.verified_user,
                16, () {
              _navigateToScreen(context, 'Accreditation'); // Pass context to _navigateToScreen
            }),
            _buildListTile(
                context, // Pass the context
                'Leaders and Members',
                Icons.group,
                16, () {
              _navigateToScreen(context, 'Leaders and Members'); // Pass context to _navigateToScreen
            }),
            _buildListTile(
                context, // Pass the context
                'Household',
                Icons.home_work,
                16, () {
              _navigateToScreen(context, 'Household'); // Pass context to _navigateToScreen
            }),
            _buildListTile(
                context, // Pass the context
                'Report',
                Icons.list_alt_rounded,
                16, () {
              _navigateToScreen(context, 'Report'); // Pass context to _navigateToScreen
            }),
            _buildListTile(
                context, // Pass the context
                'Settings',
                Icons.settings,
                16, () {
              _navigateToScreen(context, 'Settings'); // Pass context to _navigateToScreen
            }),
            _buildListTile(
                context, // Pass the context
                'Logout',
                Icons.logout,
                16, () {
              _navigateToScreen(context, 'Logout'); // Pass context to _navigateToScreen
            }),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: PaginatedDataTable(
                  columns: const [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Facilitator')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Objective')),
                    DataColumn(label: Text('Barangay')),
                  ],
                  source: ReportDataSource(
                    data: reports,
                    onLongPress: (selectedIndex) => _showUpdateReport(context, selectedIndex),
                  ),
                  rowsPerPage: reports.length < ROWS_PER_PAGE ? reports.length + 1 : ROWS_PER_PAGE,
                  header: const Center(
                    child: Text('Reports'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Flexible(
              child: SingleChildScrollView(
                child: PaginatedDataTable(
                  columns: const [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Violation')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Victim')),
                    DataColumn(label: Text('Perpetrator')),
                    DataColumn(label: Text('Barangay')),
                  ],
                  source: CrimeDataSource(
                    data: violators,
                    onLongPress: (selectedIndex) => _showUpdateCrime(context, selectedIndex),
                  ),
                  rowsPerPage: violators.length < ROWS_PER_PAGE ? violators.length + 1 : ROWS_PER_PAGE,
                  header: const Center(
                    child: Text('Crimes'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 300),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              _showInsertReport(context);
            },
            label: const Text('Add Report'), // Name for the first button
            icon: const Icon(Icons.add),
          ),
          const SizedBox(height: 16), // Add some spacing between the two buttons
          FloatingActionButton.extended(
            onPressed: () {
              _showInsertCrime(context);
            },
            label: const Text('Add Crime'), // Name for the second button
            icon: const Icon(Icons.add), // Replace with the desired icon
          ),
        ],
      ),
    );
  }
}
