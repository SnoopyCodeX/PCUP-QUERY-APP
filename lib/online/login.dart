import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:query_app/online/main.dart';
import 'package:query_app/online/signup.dart'; // Import the signup screen file

void main() => runApp(MaterialApp(
      home: LoginScreen(userData: {}),
    ));

class LoginScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  LoginScreen({required this.userData});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        // Use a ListView to make the content scrollable
        children: [
          Container(
            margin: EdgeInsets.only(top: 170, bottom: 20), // Add top margin
            child: Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/download.png'),
                // Provide the path to your image asset
              ),
            ),
          ),
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      String username = usernameController.text;
                      String password = passwordController.text;

                      var url = Uri.parse(
                          'http://192.168.254.159:8080/pcup-api/login.php');
                      var response = await http.post(
                        url,
                        headers: {'Content-Type': 'application/json'},
                        body: json.encode(
                            {'user_name': username, 'user_password': password}),
                      );
                      print(response.body);
                      String responseBody =
                          response.body; // Extract the response body
                      String errorMessage =
                          ''; // Initialize the error message variable

                      if (response.statusCode == 200) {
                        var data = json.decode(response.body);

                        if (data.containsKey('user_id')) {
                          // User is logged in; store user data and navigate to the main screen
                          Map<String, dynamic> userData =
                              data; // Store user data
                          if (userData['user_remarks'] == 'APPROVED') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Successfuly Login'),
                                duration: Duration(seconds: 3),
                              ),
                            );

                            // Delay the navigation to the login screen for 5 seconds
                            Future.delayed(Duration(seconds: 3), () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MyHomePageOnline(userData: userData),
                                ),
                              );
                            });
                          } else if (responseBody
                              .contains('Login failed. User not approved.')) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text("Login failed. User not approved."),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        } else if (responseBody
                            .contains('Login failed. Invalid credentials.')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("Login failed. Invalid credentials."),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      } else {
                        // Handle the API response status code (e.g., show an error message)
                        print(
                            "API Error - Status Code: ${response.statusCode}");
                      }
                    },
                    child: Text('Login'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to the sign-up screen when the "Sign Up" button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                    child: Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
