// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:query_app/main.dart';
import 'package:query_app/online/accreditation.dart';
import 'package:query_app/online/household.dart';
import 'package:query_app/online/main.dart';
import 'package:query_app/online/report.dart';
import 'package:query_app/online/settings.dart';
import 'package:query_app/source/leaders_and_members_data_source.dart';

class LeadersScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const LeadersScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<LeadersScreen> createState() => _LeadersScreenState();
}

class _LeadersScreenState extends State<LeadersScreen> {
  final ROWS_PER_PAGE = 8;

  List<Map<String, dynamic>> leaders = [];
  List<String> barangayNames = [];
  TextEditingController leaderNameController = TextEditingController();
  TextEditingController leaderMiddlenameController = TextEditingController();
  TextEditingController leaderLastnameController = TextEditingController();
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
    leaderMiddlenameController.dispose();
    leaderLastnameController.dispose();
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
    final Uri apiUrl = Uri.parse('https://sweet-salvador.kenkarlo.com/PCUP-API/online/fetch_leaders.php');
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
    return leaderNameController.text.isNotEmpty && leaderAgeController.text.isNotEmpty && leaderSexController.text.isNotEmpty && leaderPositionController.text.isNotEmpty && barangayController.text.isNotEmpty && civilStatusController.text.isNotEmpty && famMembersController.text.isNotEmpty && remarksController.text.isNotEmpty;
  }

  void clearTextControllers() {
    leaderNameController.clear();
    leaderMiddlenameController.clear();
    leaderLastnameController.clear();
    leaderPositionController.clear();
    leaderSexController.clear();
    leaderAgeController.clear();
    barangayController.clear();
    civilStatusController.clear();
    famMembersController.clear();
    totalMaleController.clear();
    totalFemaleController.clear();
    pwdMaleController.clear();
    pwdFemaleController.clear();
    srMaleController.clear();
    srFemaleController.clear();
    minorMaleController.clear();
    minorFemaleController.clear();
    remarksController.clear();
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

  void _submitData() async {
    final apiUrl = Uri.parse('https://sweet-salvador.kenkarlo.com/PCUP-API/online/add_leaders.php');
    final response = await http.post(
      apiUrl,
      body: {
        'leader_name': leaderNameController.text,
        'leader_lname': leaderLastnameController.text,
        'leader_mname': leaderMiddlenameController.text,
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
      await fetchLeaders();

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

  void _submitUpdatedData(int index) async {
    final apiUrl = Uri.parse('https://sweet-salvador.kenkarlo.com/PCUP-API/online/update_leaders.php');
    final response = await http.post(
      apiUrl,
      body: {
        'leader_id': leaders[index]['leader_id'],
        'leader_name': leaderNameController.text,
        'leader_lname': leaderLastnameController.text,
        'leader_mname': leaderMiddlenameController.text,
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
      await fetchLeaders();

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

  String? selectedPosition; // Set the default position
  String? selectedCivilStatus;
  String? selectedSex;
  String? selectRemarks;

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
                  controller: leaderNameController,
                  decoration: const InputDecoration(labelText: 'Leader Firstname'),
                ),

                TextFormField(
                  controller: leaderMiddlenameController,
                  decoration: const InputDecoration(labelText: 'Leader Middlename'),
                ),

                TextFormField(
                  controller: leaderLastnameController,
                  decoration: const InputDecoration(labelText: 'Leader Lastname'),
                ),

                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Leader Position'),
                  value: selectedPosition,
                  items: const [
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
                      leaderPositionController.text = selectedItem!; // Update leaderPositionController
                    });
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Leader Sex'),
                  value: selectedSex,
                  items: const [
                    DropdownMenuItem(
                      value: 'Male',
                      child: Text('Male'),
                    ),
                    DropdownMenuItem(
                      value: 'Female',
                      child: Text('Female'),
                    ),
                  ],
                  onChanged: (selectedItem) {
                    setState(() {
                      selectedSex = selectedItem;
                      leaderSexController.text = selectedItem!; // Update leaderPositionController
                    });
                  },
                ),
                TextFormField(
                  controller: leaderAgeController,
                  decoration: const InputDecoration(labelText: 'Leader Age'),
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Leader Barangay'),
                  value: barangayNames.isNotEmpty ? barangayNames[0] : null,
                  items: barangayNames.map((String barangayName) {
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
                  decoration: const InputDecoration(labelText: 'Leader Civil Status'),
                  value: selectedCivilStatus,
                  items: const [
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
                      civilStatusController.text = selectedItem!; // Update leaderPositionController
                    });
                  },
                ),

                TextFormField(
                  controller: famMembersController,
                  decoration: const InputDecoration(labelText: 'Leader Family Members'),
                ),
                TextFormField(
                  controller: totalMaleController,
                  decoration: const InputDecoration(labelText: 'Leader Total Male'),
                ),
                TextFormField(
                  controller: totalFemaleController,
                  decoration: const InputDecoration(labelText: 'Leader Total Female'),
                ),
                TextFormField(
                  controller: pwdMaleController,
                  decoration: const InputDecoration(labelText: 'Leader Total PWD Male'),
                ),
                TextFormField(
                  controller: pwdFemaleController,
                  decoration: const InputDecoration(labelText: 'Leader Total PWD Female'),
                ),
                TextFormField(
                  controller: srMaleController,
                  decoration: const InputDecoration(labelText: 'Leader Senior Male'),
                ),
                TextFormField(
                  controller: srFemaleController,
                  decoration: const InputDecoration(labelText: 'Leader Senior Female'),
                ),
                TextFormField(
                  controller: minorMaleController,
                  decoration: const InputDecoration(labelText: 'Leader Below 18 Male'),
                ),
                TextFormField(
                  controller: minorFemaleController,
                  decoration: const InputDecoration(labelText: 'Leader Below 18 Female'),
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Leader Remarks'),
                  value: selectRemarks,
                  items: const [
                    DropdownMenuItem(
                      value: 'NEW',
                      child: Text('NEW'),
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
    leaderNameController = TextEditingController(text: leaders[index]['leader_name'].toString());
    leaderMiddlenameController = TextEditingController(text: leaders[index]['leader_mname'].toString());
    leaderLastnameController = TextEditingController(text: leaders[index]['leader_lname'].toString());
    leaderPositionController = TextEditingController(text: leaders[index]['leader_position'].toString());
    leaderSexController = TextEditingController(text: leaders[index]['leader_sex'].toString());
    leaderAgeController = TextEditingController(text: leaders[index]['leader_age'].toString());
    barangayController = TextEditingController(text: leaders[index]['leader_barangay'].toString());
    civilStatusController = TextEditingController(text: leaders[index]['leader_civilstatus'].toString());
    famMembersController = TextEditingController(text: leaders[index]['leader_num_family_members'].toString());
    totalMaleController = TextEditingController(text: leaders[index]['leader_total_male'].toString());
    totalFemaleController = TextEditingController(text: leaders[index]['leader_total_female'].toString());
    pwdMaleController = TextEditingController(text: leaders[index]['leader_totalpwd_physical_male'].toString());
    pwdFemaleController = TextEditingController(text: leaders[index]['leader_totalpwd_physical_female'].toString());
    srMaleController = TextEditingController(text: leaders[index]['leader_senior_male'].toString());
    srFemaleController = TextEditingController(text: leaders[index]['leader_senior_female'].toString());
    minorMaleController = TextEditingController(text: leaders[index]['leader_below_18_male'].toString());
    minorFemaleController = TextEditingController(text: leaders[index]['leader_below_18_female'].toString());
    remarksController = TextEditingController(text: leaders[index]['leader_remarks'].toString());

    selectedPosition = leaders[index]['leader_position'];
    selectedCivilStatus = leaders[index]['leader_civilstatus'].toString();
    selectedSex = leaders[index]['leader_sex'].toString();
    selectRemarks = leaders[index]['leader_remarks'].toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Data'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: leaderNameController,
                  decoration: const InputDecoration(labelText: 'Leader Fullname (ex. Dela Cruz, Juan)'),
                ),

                TextFormField(
                  controller: leaderMiddlenameController,
                  decoration: const InputDecoration(labelText: 'Leader Middlename'),
                ),

                TextFormField(
                  controller: leaderLastnameController,
                  decoration: const InputDecoration(labelText: 'Leader Lastname'),
                ),

                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Leader Position'),
                  value: selectedPosition == null ? null : selectedPosition!.toUpperCase(),
                  items: const [
                    DropdownMenuItem(
                      value: 'PRESIDENT',
                      child: Text('PRESIDENT'),
                    ),
                    DropdownMenuItem(
                      value: 'VICE PRESIDENT',
                      child: Text('VICE PRESIDENT'),
                    ),
                    DropdownMenuItem(
                      value: 'MEMBER',
                      child: Text('MEMBER'),
                    ),
                  ],
                  onChanged: (selectedItem) {
                    setState(() {
                      selectedPosition = selectedItem;
                      leaderPositionController.text = selectedItem!; // Update leaderPositionController
                    });
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Leader Sex'),
                  value: selectedSex == 'null' ? null : selectedSex!.substring(0, 1).toUpperCase(),
                  items: const [
                    DropdownMenuItem(
                      value: 'M',
                      child: Text('Male'),
                    ),
                    DropdownMenuItem(
                      value: 'F',
                      child: Text('Female'),
                    ),
                  ],
                  onChanged: (selectedItem) {
                    setState(() {
                      selectedSex = selectedItem;
                      leaderSexController.text = selectedItem!; // Update leaderPositionController
                    });
                  },
                ),
                TextFormField(
                  controller: leaderAgeController,
                  decoration: const InputDecoration(labelText: 'Leader Age'),
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Leader Barangay'),
                  value: leaders[index]['leader_barangay'].toString() == 'null' ? null : leaders[index]['leader_barangay'].toString(),
                  items: barangayNames.map((String barangayName) {
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
                  decoration: const InputDecoration(labelText: 'Leader Civil Status'),
                  value: selectedCivilStatus == 'null' ? null : selectedCivilStatus,
                  items: const [
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
                      civilStatusController.text = selectedItem!; // Update leaderPositionController
                    });
                  },
                ),

                TextFormField(
                  controller: famMembersController,
                  decoration: const InputDecoration(labelText: 'Leader Family Members'),
                ),
                TextFormField(
                  controller: totalMaleController,
                  decoration: const InputDecoration(labelText: 'Leader Total Male'),
                ),
                TextFormField(
                  controller: totalFemaleController,
                  decoration: const InputDecoration(labelText: 'Leader Total Female'),
                ),
                TextFormField(
                  controller: pwdMaleController,
                  decoration: const InputDecoration(labelText: 'Leader Total PWD Male'),
                ),
                TextFormField(
                  controller: pwdFemaleController,
                  decoration: const InputDecoration(labelText: 'Leader Total PWD Female'),
                ),
                TextFormField(
                  controller: srMaleController,
                  decoration: const InputDecoration(labelText: 'Leader Senior Male'),
                ),
                TextFormField(
                  controller: srFemaleController,
                  decoration: const InputDecoration(labelText: 'Leader Senior Female'),
                ),
                TextFormField(
                  controller: minorMaleController,
                  decoration: const InputDecoration(labelText: 'Leader Below 18 Male'),
                ),
                TextFormField(
                  controller: minorFemaleController,
                  decoration: const InputDecoration(labelText: 'Leader Below 18 Female'),
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Leader Remarks'),
                  value: selectRemarks! == 'null' ? null : selectRemarks,
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
        title: const Text('Leaders and Members'),
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
            DataColumn(label: Text("First Name")),
            DataColumn(label: Text("Last Name")),
            DataColumn(label: Text("Middle Name")),
            DataColumn(label: Text("Position")),
            DataColumn(label: Text("Gender")),
            DataColumn(label: Text("Age")),
            DataColumn(label: Text("Barangay")),
            DataColumn(label: Text("Civil Status")),
            DataColumn(label: Text("Family Members")),
            DataColumn(label: Text("Total Male")),
            DataColumn(label: Text("Total Female")),
            DataColumn(label: Text("Total PWD Physical Male")),
            DataColumn(label: Text("Total PWD Physical Female")),
            DataColumn(label: Text("Senior Male")),
            DataColumn(label: Text("Senior Female")),
            DataColumn(label: Text("Below 18 Male")),
            DataColumn(label: Text("Below 18 Female")),
            DataColumn(label: Text("Program")),
            DataColumn(label: Text("Remarks")),
            DataColumn(label: Text("Association")),
          ],
          source: LeadersAndMembersDataSource(
            data: leaders,
            onLongPress: (int selectedIndex) => _showUpdateDataDialog(context, selectedIndex),
          ),
          rowsPerPage: leaders.length < ROWS_PER_PAGE ? leaders.length + 1 : ROWS_PER_PAGE,
          header: const Center(
            child: Text('Leaders and Members'),
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
            label: const Text('Add Leaders'), // Name for the first button
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
