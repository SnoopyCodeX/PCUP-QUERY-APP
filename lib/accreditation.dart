import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
        'http://192.168.254.159:8080/PCUP-API/fetch_accreditations.php');
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is List) {
        setState(() {
          accreditations = List<Map<String, dynamic>>.from(data);
        });
      }
    } else {
      throw Exception('Failed to load data');
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
        Uri.parse('http://192.168.254.159:8080/PCUP-API/add_accreditation.php');
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
      setState(() {
        message = 'Data submitted successfully';
      });
    } else {
      setState(() {
        message = 'Failed to submit data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accreditation'),
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
