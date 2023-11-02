import 'package:flutter/material.dart';
import 'package:query_app/report.dart';
import 'package:query_app/leaders_members.dart';
import 'package:query_app/household.dart';
import 'package:query_app/main.dart';
import 'package:query_app/accreditation.dart';

class SettingsScreen extends StatelessWidget {
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
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
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
        title: Text('Settings'),
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
          ],
        ),
      ),
      body: Center(
        child: Text('Settings Screen Content'),
      ),
    );
  }
}
