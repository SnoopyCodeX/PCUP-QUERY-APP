// ignore_for_file: unused_field, unused_element

import 'package:flutter/material.dart';
import 'package:query_app/main.dart';
import 'package:query_app/online/accreditation.dart';
import 'package:query_app/online/household.dart';
import 'package:query_app/online/leaders_members.dart';
import 'package:query_app/online/report.dart';
import 'package:query_app/online/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePageOnline(userData: {}), // Initialize with an empty map
    );
  }
}

class MyHomePageOnline extends StatefulWidget {
  final Map<String, dynamic> userData;

  const MyHomePageOnline({Key? key, required this.userData}) : super(key: key);

  @override
  State<MyHomePageOnline> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePageOnline> {
  int _selectedIndex = 0;

  Widget _buildListTile(String title, IconData iconData, double fontSize, VoidCallback onTap) {
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pop(context);
    });
  }

  void _navigateToScreen(String routeName) {
    Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    final userData = widget.userData;
    const userImage = AssetImage('assets/images/avatar.png');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
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
            _buildListTile('Logout', Icons.logout, 16, () {
              _navigateToScreen('Logout');
            }),
          ],
        ),
      ),
    );
  }
}
