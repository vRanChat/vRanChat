import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
