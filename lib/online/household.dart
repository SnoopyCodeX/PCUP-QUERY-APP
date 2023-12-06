// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:query_app/main.dart';
import 'package:query_app/online/accreditation.dart';
import 'package:query_app/online/leaders_members.dart';
import 'package:query_app/online/main.dart';
import 'package:query_app/online/report.dart';
import 'package:query_app/online/settings.dart';
import 'package:query_app/source/household_data_source.dart';

class houseHoldScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const houseHoldScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<houseHoldScreen> createState() => _houseHoldScreenState();
}

class _houseHoldScreenState extends State<houseHoldScreen> {
  final int ROWS_PER_PAGE = 8;

  List<Map<String, dynamic>> household = [];
  List<String> barangayNames = [];
  List<String> accreditationNames = [];

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
    fetchBarangayNames();
    fetchHousehold();
    fetchAccreditationNames();
  }

  Future<void> fetchHousehold() async {
    final Uri apiUrl = Uri.parse('https://sweet-salvador.kenkarlo.com/PCUP-API/online/fetch_household.php');
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

  Future<void> fetchAccreditationNames() async {
    final Uri apiUrl = Uri.parse('https://sweet-salvador.kenkarlo.com/PCUP-API/online/fetch_householdLeader.php');
    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is List) {
          final names = data.map((item) {
            // Extract the "Name" property from each object and convert it to a string
            return item['accreditation_name'].toString();
          }).toList();

          setState(() {
            accreditationNames = names;
          });
        } else {
          debugPrint('API did not return valid JSON data.');
        }
      } else {
        debugPrint('API Error: Status Code ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching accreditation names: $e');
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

  void clearTextControllers() {
    householdLastnameController.clear();
    householdFirstnameController.clear();
    householdMiddlenameController.clear();
    hourseholdSuffixController.clear();
    householdBirthdateController.clear();
    householdAgeController.clear();
    householdSexController.clear();
    lastPregnantController.clear();
    pregnantController.clear();
    noChildrenController.clear();
    baranggayController.clear();
    educAttainmentController.clear();
    schoolGraudatedController.clear();
    incomeController.clear();
    employedController.clear();
    householdLeaderController.clear();
    leaderRelationController.clear();
    remarksController.clear();
  }

  void _submitData() async {
    final apiUrl = Uri.parse('https://sweet-salvador.kenkarlo.com/PCUP-API/online/add_household.php');
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
    debugPrint(response.body);
    if (response.statusCode == 200) {
      fetchHousehold();
      WidgetsBinding.instance.addPostFrameCallback((_) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Successfully Added'),
            ),
          ));
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to submit data'),
            ),
          ));
    }
  }

  void _submitUpdatedData(int index) async {
    final apiUrl = Uri.parse('https://sweet-salvador.kenkarlo.com/PCUP-API/online/update_household.php');
    final response = await http.post(
      apiUrl,
      body: {
        'household_id': household[index]['household_id'],
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
    debugPrint(response.body);
    if (response.statusCode == 200) {
      await fetchHousehold();
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

  String? selectedSuffix;
  String? selectedSex;
  DateTime? selectedDateBirthdate;
  DateTime? selectedDateLastPreg;
  String? selectPreg;
  String? selecteducAttainment;
  String? selectEmployed;
  String? selectedleaderRelation;
  String? selectRemarks;

  Future<void> _selectDateBD(BuildContext context) async {
    final DateTime? picked = (await showDatePicker(
      context: context,
      initialDate: selectedDateBirthdate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ));

    if (picked != null && picked != selectedDateBirthdate) {
      setState(() {
        selectedDateBirthdate = picked;
        householdBirthdateController.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  Future<void> _selectDateLP(BuildContext context) async {
    final DateTime? picked = (await showDatePicker(
      context: context,
      initialDate: selectedDateLastPreg ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ));

    if (picked != null && picked != selectedDateLastPreg) {
      setState(() {
        selectedDateLastPreg = picked;
        lastPregnantController.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  void _showInsertDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Insert Data'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: householdLastnameController,
                  decoration: const InputDecoration(labelText: 'Household LastName'),
                ),
                TextFormField(
                  controller: householdFirstnameController,
                  decoration: const InputDecoration(labelText: 'Household FirstName'),
                ),
                TextFormField(
                  controller: householdMiddlenameController,
                  decoration: const InputDecoration(labelText: 'Household MiddleName'),
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Household Suffix'),
                  value: selectedSuffix!.toUpperCase().substring(0, selectedSuffix!.lastIndexOf('.') + 1),
                  items: const [
                    DropdownMenuItem(
                      value: 'JR.',
                      child: Text('JR.'),
                    ),
                    DropdownMenuItem(
                      value: 'SR.',
                      child: Text('SR.'),
                    ),
                    DropdownMenuItem(
                      value: 'III.',
                      child: Text('III.'),
                    ),
                  ],
                  onChanged: (selectedItem) {
                    setState(() {
                      selectedSuffix = selectedItem;
                      hourseholdSuffixController.text = selectedItem!; // Update leaderPositionController
                    });
                  },
                ),
                TextFormField(
                  controller: householdBirthdateController,
                  decoration: const InputDecoration(
                    labelText: 'Household Birthdate',
                    hintText: 'Select date',
                    labelStyle: TextStyle(color: Colors.grey),
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.calendar_today, color: Colors.blue),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onTap: () {
                    _selectDateBD(context);
                  },
                ),
                TextFormField(
                  controller: householdAgeController,
                  decoration: const InputDecoration(labelText: 'Household Age'),
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Household Sex'),
                  value: selectedSex!.toUpperCase(),
                  items: const [
                    DropdownMenuItem(
                      value: 'MALE',
                      child: Text('Male'),
                    ),
                    DropdownMenuItem(
                      value: 'FEMALE',
                      child: Text('Female'),
                    ),
                  ],
                  onChanged: (selectedItem) {
                    setState(() {
                      selectedSex = selectedItem;
                      householdSexController.text = selectedItem!; // Update leaderPositionController
                    });
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Household Pregnant'),
                  value: selectPreg!.toUpperCase(),
                  items: const [
                    DropdownMenuItem(
                      value: 'YES',
                      child: Text('Yes'),
                    ),
                    DropdownMenuItem(
                      value: 'NO',
                      child: Text('No'),
                    ),
                    DropdownMenuItem(
                      value: 'N/A',
                      child: Text('No'),
                    ),
                  ],
                  onChanged: (selectedItem) {
                    setState(() {
                      selectPreg = selectedItem;
                      pregnantController.text = selectedItem!; // Update leaderPositionController
                    });
                  },
                ),
                TextFormField(
                  controller: lastPregnantController,
                  decoration: const InputDecoration(
                    labelText: 'Household Last Pregnant',
                    hintText: 'Select date',
                    labelStyle: TextStyle(color: Colors.grey),
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.calendar_today, color: Colors.blue),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onTap: () {
                    _selectDateLP(context);
                  },
                ),
                TextFormField(
                  controller: noChildrenController,
                  decoration: const InputDecoration(labelText: 'Household No. Child'),
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Household Barangay'),
                  value: barangayNames.isNotEmpty ? barangayNames[0] : null,
                  items: barangayNames.map((String barangayName) {
                    return DropdownMenuItem<String>(
                      value: barangayName,
                      child: Text(barangayName),
                    );
                  }).toList(),
                  onChanged: (selectedBarangay) {
                    setState(() {
                      baranggayController.text = selectedBarangay ?? '';
                    });
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Household Educational Attainment'),
                  value: selecteducAttainment!.toUpperCase(),
                  items: const [
                    DropdownMenuItem(
                      value: 'ELEMENTARY LEVEL',
                      child: Text('ELEMENTARY LEVEL'),
                    ),
                    DropdownMenuItem(
                      value: 'ELEMENTARY GRADUATE',
                      child: Text('ELEMENTARY GRADUATE'),
                    ),
                    DropdownMenuItem(
                      value: 'HIGHSCHOOL LEVEL',
                      child: Text('HIGHSCHOOL LEVEL'),
                    ),
                    DropdownMenuItem(
                      value: 'HIGHSCHOOL GRADUATE',
                      child: Text('HIGHSCHOOL GRADUATE'),
                    ),
                    DropdownMenuItem(
                      value: 'COLLEGE LEVEL',
                      child: Text('COLLEGE LEVEL'),
                    ),
                    DropdownMenuItem(
                      value: 'COLLEGE GRADUATE',
                      child: Text('COLLEGE GRADUATE'),
                    ),
                  ],
                  onChanged: (selectedItem) {
                    setState(() {
                      selecteducAttainment = selectedItem;
                      educAttainmentController.text = selectedItem!; // Update leaderPositionController
                    });
                  },
                ),
                TextFormField(
                  controller: schoolGraudatedController,
                  decoration: const InputDecoration(labelText: 'Household School Graduated'),
                ),
                TextFormField(
                  controller: incomeController,
                  decoration: const InputDecoration(labelText: 'Household Source of Income'),
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Currently Employed'),
                  value: selectEmployed!.toUpperCase(),
                  items: const [
                    DropdownMenuItem(
                      value: 'YES',
                      child: Text('Yes'),
                    ),
                    DropdownMenuItem(
                      value: 'NO',
                      child: Text('No'),
                    ),
                  ],
                  onChanged: (selectedItem) {
                    setState(() {
                      selectEmployed = selectedItem;
                      employedController.text = selectedItem!; // Update leaderPositionController
                    });
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Household Leader'),
                  value: accreditationNames.isNotEmpty ? accreditationNames[0] : null,
                  items: accreditationNames.map((String householdLeader) {
                    return DropdownMenuItem<String>(
                      value: householdLeader,
                      child: Text(householdLeader),
                    );
                  }).toList(),
                  onChanged: (selectedLeader) {
                    setState(() {
                      householdLeaderController.text = selectedLeader ?? '';
                    });
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Leader Relation'),
                  value: selectedleaderRelation!.toUpperCase(),
                  items: const [
                    DropdownMenuItem(
                      value: 'FATHER',
                      child: Text('FATHER'),
                    ),
                    DropdownMenuItem(
                      value: 'MOTHER',
                      child: Text('MOTHER'),
                    ),
                    DropdownMenuItem(
                      value: 'GRANDMOTHER',
                      child: Text('GRANDMOTHER'),
                    ),
                    DropdownMenuItem(
                      value: 'GRANDFATHER',
                      child: Text('GRANDFATHER'),
                    ),
                    DropdownMenuItem(
                      value: 'SIBLING',
                      child: Text('SIBLING'),
                    ),
                    DropdownMenuItem(
                      value: 'RELATIVE',
                      child: Text('RELATIVE'),
                    ),
                    DropdownMenuItem(
                      value: 'SPOUSE',
                      child: Text('SPOUSE'),
                    ),
                  ],
                  onChanged: (selectedItem) {
                    setState(() {
                      selectedSuffix = selectedItem;
                      leaderRelationController.text = selectedItem!; // Update leaderPositionController
                    });
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Remarks'),
                  value: selectRemarks,
                  items: const [
                    DropdownMenuItem(
                      value: 'NEW',
                      child: Text('NEW'),
                    ),
                    DropdownMenuItem(
                      value: 'APPROVED',
                      child: Text('APPROVED'),
                    ),
                  ],
                  onChanged: (selectedItem) {
                    setState(() {
                      selectRemarks = selectedItem;
                      remarksController.text = selectedItem!; // Update leaderPositionController
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
                if (_validateFields()) {
                  _submitData();
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  _showRequiredFieldsAlert(context);
                }
              },
              child: const Text("Insert"),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateDataDialog(BuildContext context, int index) {
    householdLastnameController = TextEditingController(text: household[index]['household_lastname'].toString());
    householdFirstnameController = TextEditingController(text: household[index]['household_firstname'].toString());
    householdMiddlenameController = TextEditingController(text: household[index]['household_middlename'].toString());
    hourseholdSuffixController = TextEditingController(text: household[index]['household_suffix'].toString());
    householdBirthdateController = TextEditingController(text: household[index]['household_birthdate'].toString());
    householdAgeController = TextEditingController(text: household[index]['household_age'].toString());
    householdSexController = TextEditingController(text: household[index]['household_sex'].toString());
    pregnantController = TextEditingController(text: household[index]['pregnant'].toString());
    lastPregnantController = TextEditingController(text: household[index]['last_preg'].toString());
    noChildrenController = TextEditingController(text: household[index]['children'].toString());
    baranggayController = TextEditingController(text: household[index]['household_barangay'].toString());
    educAttainmentController = TextEditingController(text: household[index]['household_education'].toString());
    schoolGraudatedController = TextEditingController(text: household[index]['household_school'].toString());
    incomeController = TextEditingController(text: household[index]['source'].toString());
    employedController = TextEditingController(text: household[index]['employment'].toString());
    householdLeaderController = TextEditingController(text: household[index]['household_leader'].toString());
    leaderRelationController = TextEditingController(text: household[index]['household_relation'].toString());
    remarksController = TextEditingController(text: household[index]['household_remarks'].toString());

    selectedSuffix = household[index]['household_suffix'].toString();
    selectedSex = household[index]['household_sex'].toString();
    selectPreg = household[index]['pregnant'].toString();
    selecteducAttainment = household[index]['household_education'].toString();
    selectEmployed = household[index]['employment'].toString();
    selectedleaderRelation = household[index]['household_relation'].toString();
    selectRemarks = household[index]['household_remarks'].toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Data'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: householdLastnameController,
                  decoration: const InputDecoration(labelText: 'Household LastName'),
                ),
                TextFormField(
                  controller: householdFirstnameController,
                  decoration: const InputDecoration(labelText: 'Household FirstName'),
                ),
                TextFormField(
                  controller: householdMiddlenameController,
                  decoration: const InputDecoration(labelText: 'Household MiddleName'),
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Household Suffix'),
                  value: selectedSuffix!.toUpperCase().substring(0, selectedSuffix!.lastIndexOf('.') + 1),
                  items: const [
                    DropdownMenuItem(
                      value: 'JR.',
                      child: Text('JR.'),
                    ),
                    DropdownMenuItem(
                      value: 'SR.',
                      child: Text('SR.'),
                    ),
                    DropdownMenuItem(
                      value: 'III.',
                      child: Text('III.'),
                    ),
                  ],
                  onChanged: (selectedItem) {
                    setState(() {
                      selectedSuffix = selectedItem;
                      hourseholdSuffixController.text = selectedItem!; // Update leaderPositionController
                    });
                  },
                ),
                TextFormField(
                  controller: householdBirthdateController,
                  decoration: const InputDecoration(
                    labelText: 'Household Birthdate',
                    hintText: 'Select date',
                    labelStyle: TextStyle(color: Colors.grey),
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.calendar_today, color: Colors.blue),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onTap: () {
                    _selectDateBD(context);
                  },
                ),
                TextFormField(
                  controller: householdAgeController,
                  decoration: const InputDecoration(labelText: 'Household Age'),
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Household Sex'),
                  value: selectedSex!.toUpperCase(),
                  items: const [
                    DropdownMenuItem(
                      value: 'MALE',
                      child: Text('Male'),
                    ),
                    DropdownMenuItem(
                      value: 'FEMALE',
                      child: Text('Female'),
                    ),
                  ],
                  onChanged: (selectedItem) {
                    setState(() {
                      selectedSex = selectedItem;
                      householdSexController.text = selectedItem!; // Update leaderPositionController
                    });
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Household Pregnant'),
                  value: selectPreg!.toUpperCase(),
                  items: const [
                    DropdownMenuItem(
                      value: 'YES',
                      child: Text('Yes'),
                    ),
                    DropdownMenuItem(
                      value: 'NO',
                      child: Text('No'),
                    ),
                    DropdownMenuItem(
                      value: 'N/A',
                      child: Text('N/A'),
                    ),
                  ],
                  onChanged: (selectedItem) {
                    setState(() {
                      selectPreg = selectedItem;
                      pregnantController.text = selectedItem!; // Update leaderPositionController
                    });
                  },
                ),
                TextFormField(
                  controller: lastPregnantController,
                  decoration: const InputDecoration(
                    labelText: 'Household Last Pregnant',
                    hintText: 'Select date',
                    labelStyle: TextStyle(color: Colors.grey),
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.calendar_today, color: Colors.blue),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onTap: () {
                    _selectDateLP(context);
                  },
                ),
                TextFormField(
                  controller: noChildrenController,
                  decoration: const InputDecoration(labelText: 'Household No. Child'),
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Household Barangay'),
                  value: barangayNames.isNotEmpty ? barangayNames[0] : null,
                  items: barangayNames.map((String barangayName) {
                    return DropdownMenuItem<String>(
                      value: barangayName,
                      child: Text(barangayName),
                    );
                  }).toList(),
                  onChanged: (selectedBarangay) {
                    setState(() {
                      baranggayController.text = selectedBarangay ?? '';
                    });
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Household Educational Attainment'),
                  value: selecteducAttainment!.toUpperCase(),
                  items: const [
                    DropdownMenuItem(
                      value: 'ELEMENTARY LEVEL',
                      child: Text('ELEMENTARY LEVEL'),
                    ),
                    DropdownMenuItem(
                      value: 'ELEMENTARY GRADUATE',
                      child: Text('ELEMENTARY GRADUATE'),
                    ),
                    DropdownMenuItem(
                      value: 'HIGHSCHOOL LEVEL',
                      child: Text('HIGHSCHOOL LEVEL'),
                    ),
                    DropdownMenuItem(
                      value: 'HIGHSCHOOL GRADUATE',
                      child: Text('HIGHSCHOOL GRADUATE'),
                    ),
                    DropdownMenuItem(
                      value: 'COLLEGE LEVEL',
                      child: Text('COLLEGE LEVEL'),
                    ),
                    DropdownMenuItem(
                      value: 'COLLEGE GRADUATE',
                      child: Text('COLLEGE GRADUATE'),
                    ),
                  ],
                  onChanged: (selectedItem) {
                    setState(() {
                      selecteducAttainment = selectedItem;
                      educAttainmentController.text = selectedItem!; // Update leaderPositionController
                    });
                  },
                ),
                TextFormField(
                  controller: schoolGraudatedController,
                  decoration: const InputDecoration(labelText: 'Household School Graduated'),
                ),
                TextFormField(
                  controller: incomeController,
                  decoration: const InputDecoration(labelText: 'Household Source of Income'),
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Currently Employed'),
                  value: selectEmployed!.toUpperCase(),
                  items: const [
                    DropdownMenuItem(
                      value: 'YES',
                      child: Text('Yes'),
                    ),
                    DropdownMenuItem(
                      value: 'NO',
                      child: Text('No'),
                    ),
                  ],
                  onChanged: (selectedItem) {
                    setState(() {
                      selectEmployed = selectedItem;
                      employedController.text = selectedItem!; // Update leaderPositionController
                    });
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Household Leader'),
                  value: accreditationNames.isNotEmpty ? accreditationNames[0] : null,
                  items: accreditationNames.map((String householdLeader) {
                    return DropdownMenuItem<String>(
                      value: householdLeader,
                      child: Text(householdLeader),
                    );
                  }).toList(),
                  onChanged: (selectedLeader) {
                    setState(() {
                      householdLeaderController.text = selectedLeader ?? '';
                    });
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Leader Relation'),
                  value: selectedleaderRelation!.toUpperCase(),
                  items: const [
                    DropdownMenuItem(
                      value: 'FATHER',
                      child: Text('FATHER'),
                    ),
                    DropdownMenuItem(
                      value: 'MOTHER',
                      child: Text('MOTHER'),
                    ),
                    DropdownMenuItem(
                      value: 'GRANDMOTHER',
                      child: Text('GRANDMOTHER'),
                    ),
                    DropdownMenuItem(
                      value: 'GRANDFATHER',
                      child: Text('GRANDFATHER'),
                    ),
                    DropdownMenuItem(
                      value: 'SIBLING',
                      child: Text('SIBLING'),
                    ),
                    DropdownMenuItem(
                      value: 'RELATIVE',
                      child: Text('RELATIVE'),
                    ),
                    DropdownMenuItem(
                      value: 'SPOUSE',
                      child: Text('SPOUSE'),
                    ),
                  ],
                  onChanged: (selectedItem) {
                    setState(() {
                      selectedSuffix = selectedItem;
                      leaderRelationController.text = selectedItem!; // Update leaderPositionController
                    });
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Remarks'),
                  value: selectRemarks,
                  items: const [
                    DropdownMenuItem(
                      value: 'NEW',
                      child: Text('NEW'),
                    ),
                    DropdownMenuItem(
                      value: 'APPROVED',
                      child: Text('APPROVED'),
                    ),
                  ],
                  onChanged: (selectedItem) {
                    setState(() {
                      selectRemarks = selectedItem;
                      remarksController.text = selectedItem!; // Update leaderPositionController
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
                if (_validateFields()) {
                  _submitUpdatedData(index);
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  _showRequiredFieldsAlert(context);
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
        title: const Text('Household'),
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
        child: PaginatedDataTable(
          columns: const [
            DataColumn(label: Text("ID")),
            DataColumn(label: Text("Last Name")),
            DataColumn(label: Text("First Name")),
            DataColumn(label: Text("Middle Name")),
            DataColumn(label: Text("Name Suffix")),
            DataColumn(label: Text("Birthdate")),
            DataColumn(label: Text("Age")),
            DataColumn(label: Text("Gender")),
            DataColumn(label: Text("Student")),
            DataColumn(label: Text("Education")),
            DataColumn(label: Text("Employment")),
            DataColumn(label: Text("Source")),
            DataColumn(label: Text("Pregnant")),
            DataColumn(label: Text("Last Pregnant")),
            DataColumn(label: Text("Children")),
            DataColumn(label: Text("Type")),
            DataColumn(label: Text("Leader")),
            DataColumn(label: Text("Relation")),
            DataColumn(label: Text("Association")),
            DataColumn(label: Text("Remarks")),
            DataColumn(label: Text("Barangay")),
            DataColumn(label: Text("School")),
          ],
          source: HouseholdDataSource(
            data: household,
            onLongPress: (selectedIndex) => _showUpdateDataDialog(context, selectedIndex),
          ),
          rowsPerPage: household.length < ROWS_PER_PAGE ? household.length + 1 : ROWS_PER_PAGE,
          header: const Center(
            child: Text('Household'),
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
            label: const Text('Add Household'), // Name for the first button
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
