import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   title: Text('Main Page'),
      // ),
      body: Center(
        child: Text(
          'Main Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
