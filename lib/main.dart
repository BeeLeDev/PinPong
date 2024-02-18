import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinpong/controller/TestPage.dart';
import 'package:google_fonts/google_fonts.dart';
/* Firebase */
import 'package:firebase_core/firebase_core.dart';
import 'package:pinpong/homepage.dart';

import 'firebase_options.dart';

import 'package:pinpong/authpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp(const TestPage());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Creates a new FocusNode that is not associated with any text field.
          FocusScopeNode newFocus = FocusScope.of(context);
          // If any text field is currently focused, it unfocuses it.
          if (!newFocus.hasPrimaryFocus && newFocus.hasFocus) {
            // Moves the focus to the new FocusNode, which isn't attached to any text field.
            // This effectively unfocuses any currently focused text field and hides the keyboard.
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const AuthPage(title: 'PinPong'),
        ));
  }
}


