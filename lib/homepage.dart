import 'package:flutter/material.dart';

/* FIREBASE */
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, background: Color.fromRGBO(32, 33, 36, 1)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Nearest Game'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Row( // Add Row here
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold, 
            ),
          ),
          const Expanded(child: SizedBox()),
          Image.asset(
            'assets/sign_out.png',
            scale: 2.5,
          ), // Replace 'your_image.png' with your image path
        ],
      ),
      centerTitle: false,
    ),
      body: 
      // Cards Display
      Column(
        children: [
          SizedBox(
            height: 150,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35.0), // Adjust the value as needed
              ),
              color: const Color.fromRGBO(255, 77, 77, 1),
              child: Row(
                children: [     
                  Container(
                    // for some reason i can adjust these to move the position of the image...
                    width: 150, // Adjust width as needed
                    height: 110, // Adjust height as needed
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        // Replace 'assets/image.jpg' with your image path
                        image: AssetImage('assets/cc.jpg'),
                        // Choose how the image should be displayed
                        fit: BoxFit.cover,
                        alignment: Alignment(.2, 0)
                        // alignment: Alignment.centerLeft
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Game Name
                      Text(
                        "Trivia",
                        style: TextStyle(
                              color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      // Location
                      Text(
                        "University Hall Beacon Cafe",
                        style: TextStyle(
                              color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      // Remaining Queue Time
                       Text(
                        "14m until the next game",
                        style: TextStyle(
                          color: Color.fromRGBO(254, 213, 67, 1),
                          fontSize: 20,
                        ),
                      ),
                      // Players in Queue
                      Row(
                        children: [
                           Image(
                            image: AssetImage('assets/person_icon.png'),
                          ),
                          Text(
                            "16 players waiting...",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ]
                      ),
                    ],
                  ),
                  // the text cuts out of the card, could use this or padding, but this adds more spacing than padding
                  Container(
                    width: 4,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}