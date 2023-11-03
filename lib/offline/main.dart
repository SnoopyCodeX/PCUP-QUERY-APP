import 'package:flutter/material.dart';
import 'package:query_app/offline/settings.dart';
import 'package:query_app/offline/report.dart';
import 'package:query_app/offline/leaders_members.dart';
import 'package:query_app/offline/accreditation.dart';
import 'package:query_app/offline/household.dart';
import 'package:query_app/main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePageOffline(userData: {}), // Initialize with an empty map
    );
  }
}

class MyHomePageOffline extends StatefulWidget {
  final Map<String, dynamic> userData;

  MyHomePageOffline({required this.userData});

  @override
  _MyHomePageState createState() => _MyHomePageState(userData: userData);
}

class _MyHomePageState extends State<MyHomePageOffline> {
  final Map<String, dynamic> userData;

  _MyHomePageState({required this.userData});

  int _selectedIndex = 0;

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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePageOffline(userData: userData)));
        break;
      case 'Accreditation':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AccreditationScreen(userData: userData)));
        break;
      case 'Leaders and Members':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LeadersScreen(userData: userData)));
        break;
      case 'Household':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => houseHoldScreen(userData: userData)));
        break;
      case 'Report':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReportScreen(userData: userData)));
        break;
      case 'Settings':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SettingsScreen(userData: userData)));
        break;
      case 'Back':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    FolderSelectionScreen(userData: userData)));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userData = widget.userData;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
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
            _buildListTile('Back', Icons.logout_rounded, 16, () {
              _navigateToScreen('Back');
            }),
          ],
        ),
      ),
    );
  }
}
