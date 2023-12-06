import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:query_app/main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Map<String, dynamic> userData = {}; // Define a Map to store user data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        // Wrap the content with SingleChildScrollView
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: fullnameController,
                      decoration: const InputDecoration(
                        labelText: 'Fullname',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        String username = usernameController.text;
                        String password = passwordController.text;
                        String fullname = fullnameController.text;
                        String email = emailController.text;
                        String phone = phoneController.text;

                        final response = await http.post(
                          Uri.parse('https://sweet-salvador.kenkarlo.com/PCUP-API/online/signup.php'),
                          body: {
                            'user_name': username,
                            'user_password': password,
                            'user_fullname': fullname,
                            'user_email': email,
                            'user_phone': phone,
                          },
                        );
                        debugPrint("Response Body: ${response.body}");

                        if (response.statusCode == 200) {
                          String responseBody = response.body; // Extract the response body

                          if (responseBody.contains('User registered successfully')) {
                            WidgetsBinding.instance.addPostFrameCallback((_) => ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('User registered successfully'),
                                    duration: Duration(seconds: 3),
                                  ),
                                ));

                            // Delay the navigation to the login screen for 5 seconds
                            Future.delayed(const Duration(seconds: 3), () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(userData: userData),
                                ),
                              );
                            });
                            return; // Exit the function and the current page
                          } else if (responseBody.contains('Email or username already exists')) {
                            WidgetsBinding.instance.addPostFrameCallback((_) => ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Email or username already exists'),
                                    duration: Duration(seconds: 2),
                                  ),
                                ));
                          } else {
                            WidgetsBinding.instance.addPostFrameCallback((_) => ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Invalid request method'),
                                    duration: Duration(seconds: 2),
                                  ),
                                ));
                          }
                        }
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
