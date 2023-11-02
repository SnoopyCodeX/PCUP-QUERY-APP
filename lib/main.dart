import 'package:flutter/material.dart';
import 'package:query_app/offline/main.dart';
import 'package:query_app/online/login.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false, // Add this line

      home:
          FolderSelectionScreen(userData: {}), // Pass user data as a parameter
    ));

class FolderSelectionScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  FolderSelectionScreen({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Folder Selection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Navigate to the "online" folder and pass user data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreen(userData: userData)),
                );
              },
              child: Text('Online Folder'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the "offline" folder and pass user data
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePageOffline()),
                );
              },
              child: Text('Offline Folder'),
            ),
          ],
        ),
      ),
    );
  }
}

class OnlineFolderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online Folder'),
      ),
      body: Center(
        child: Text('Contents of the Online Folder'),
      ),
    );
  }
}

class OfflineFolderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offline Folder'),
      ),
      body: Center(
        child: Text('Contents of the Offline Folder'),
      ),
    );
  }
}
