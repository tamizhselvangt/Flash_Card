import 'main.dart';
import 'package:flutter/material.dart';


class Flashcardview extends StatelessWidget {
  const Flashcardview({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flash Card"),
      ),
      body:ListView(
        children: [
          Container(
            child: Text("Hello"),
          ),
          Container(
            child: Text("Hello"),
          ),
          Container(
            child: Text("Hello"),
          ),

        ],
      ),
    );
  }
}
