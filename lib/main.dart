import 'package:flutter/material.dart';
import 'package:grid_notes/screens/NotesScreen.dart';

void main() {
  runApp(MyApp2());
}

class MyApp2 extends StatelessWidget {
  MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: Scaffold(body: NotestScreen())),
    );
  }
}
