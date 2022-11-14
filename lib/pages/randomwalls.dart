import 'package:flutter/material.dart';
//import 'dart:html';

class randomwalls extends StatefulWidget {
  const randomwalls();

  @override
  State<randomwalls> createState() => _randomwallsState();
}

class _randomwallsState extends State<randomwalls> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [
        Container(
          child: Text("Catogories"),
        ),
      ]),
    );
  }
}
