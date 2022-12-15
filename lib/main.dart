import 'package:flutter/material.dart';
import 'package:trial_space/passingArguments.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Testing space',
      // home: MyHomePage(),
      routes: {
        '/': (context) => FirstPage(
              hex: const Color(0xff443a49),
            ),
        '/second': (context) => const SecondPage()
      },
    );
  }
}

