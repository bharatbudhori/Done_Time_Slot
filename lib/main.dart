import 'package:flutter/material.dart';

import 'package:done_assesment/screens/time_slot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          //white color
          0xFFFFFFFF,
          <int, Color>{
            50: Color(0xFFE0E0E0),
            100: Color(0xFFB3B3B3),
            200: Color(0xFF808080),
            300: Color(0xFF4D4D4D),
            400: Color(0xFF262626),
            500: Color(0xFF000000),
            600: Color(0xFF000000),
            700: Color(0xFF000000),
            800: Color(0xFF000000),
            900: Color(0xFF000000),
          },
        ),
      ),
      home: TimeSlotSelection(),
    );
  }
}
