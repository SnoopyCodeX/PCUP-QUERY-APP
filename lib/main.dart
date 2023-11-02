import 'package:flutter/material.dart';
import 'package:query_app/offline/main.dart';
import 'package:query_app/online/login.dart';

void main() => runApp(MaterialApp(
      home: FolderSelectionScreen(),
    ));

class FolderSelectionScreen extends StatelessWidget {
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
                // Navigate to the "online" folder
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Online Folder'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the "offline" folder
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
