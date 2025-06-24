import 'package:flutter_check/chat_box_map.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Offline Map',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ChatBox(),
      debugShowCheckedModeBanner: false,
    );
  }
}
