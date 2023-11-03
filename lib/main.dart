import 'package:flutter/material.dart';
import 'package:query_app/offline/main.dart';
import 'package:query_app/online/login.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FolderSelectionScreen(userData: {}),
    ));

class FolderSelectionScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  FolderSelectionScreen({required this.userData});

  void navigateToOnlineScreen(BuildContext context) {
    // Show a loading message using SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(), // Circular loader
            SizedBox(width: 16),
            Text("Loading..."),
          ],
        ),
        duration: Duration(seconds: 1), // You can adjust the duration
      ),
    );

    // Simulate a delay for 2 seconds before navigating to the "Online" screen
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(
            userData: userData,
          ),
        ),
      );
    });
  }

  void navigateToOfflineScreen(BuildContext context) {
    // Show a loading message using SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(), // Circular loader
            SizedBox(width: 16),
            Text("Loading..."),
          ],
        ),
        duration: Duration(seconds: 1), // You can adjust the duration
      ),
    );

    // Simulate a delay for 2 seconds before navigating to the "Online" screen
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePageOffline(
            userData: userData,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choices'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                navigateToOnlineScreen(context);
              },
              child: Text('Online'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                navigateToOfflineScreen(context);
              },
              child: Text('Offline'),
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
