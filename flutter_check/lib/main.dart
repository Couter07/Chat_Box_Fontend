import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_check/view/chat_box_map.dart';
import 'package:flutter_check/view/map.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:device_preview/device_preview.dart';

void main() => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(), // Wrap your app
  ),
);

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
