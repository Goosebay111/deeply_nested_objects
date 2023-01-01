// timeline_tile 2.0.0

import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TimelineTile(
        alignment: TimelineAlign.center,
        endChild: Container(
          constraints: const BoxConstraints(
            minHeight: 120,
          ),
          color: Colors.lightGreenAccent,
        ),
        startChild: Container(
          color: Colors.amberAccent,
        ),
      ),
      
    );
  }
}
