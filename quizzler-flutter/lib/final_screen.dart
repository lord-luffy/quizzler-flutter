import 'package:flutter/material.dart';

class FinalScreen extends StatefulWidget {
  @override
  _FinalScreenState createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Final Screen'),
      ),
      body: Center(
        child: Text(
          "You Finished the Quizzler!",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
