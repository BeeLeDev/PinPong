import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
/* Firebase */
import 'package:firebase_core/firebase_core.dart';
import 'package:pinpong/gameLobbyPage.dart';
import 'package:pinpong/homepage.dart';

import 'package:pinpong/controller/TestPage.dart';
import 'firebase_options.dart';

import 'package:pinpong/controller/FireStore.dart';
import 'package:pinpong/model/User.dart';

import 'dart:developer' as dev;

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, required this.title});
  final String title;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  dynamic name = "John Doe";
  dynamic studentID = "12345678";
  dynamic _errorText;

  String getName() {
    return name;
  }

  String getStudentID() {
    return studentID;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _studentIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 165),
            Text(
              '📍PinPong',
              style: GoogleFonts.vt323(
                textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 60,
                    ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Please type your name and student ID.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                children: [
                  // Name Input
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      hintText: 'Name',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                    ),
                    onChanged: (value) {
                      // if the name with the studentID is already in the database, it will not update the name in the database
                      name = value;
                    },
                  ),

                  const SizedBox(height: 8),

                  // ID Input
                  TextField(
                    controller: _studentIdController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      hintText: 'Student ID',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                      errorText:
                          _errorText, // Use the _errorText variable for errorText
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    maxLength: 8, // Set maximum length to 8 characters
                    onChanged: (value) {
                      studentID = value;
                      if (value.length != 8) {
                        // If the length is not 8, set the errorText
                        setState(() {
                          _errorText = 'Student ID must be exactly 8 digits';
                        });
                      } else {
                        // If the length is 8, clear the errorText
                        setState(() {
                          _errorText = null;
                        });
                        // You can also perform other actions here if needed
                      }
                    },
                  ),

                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (getName() != null && getStudentID().length == 8) {
                          login(
                              User(name: getName(), studentId: getStudentID()));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyHomePage(
                                      title: 'Nearest Game',
                                    )),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Join',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Image.asset(
                'assets/UMB-Logo.png',
                width: 300,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
