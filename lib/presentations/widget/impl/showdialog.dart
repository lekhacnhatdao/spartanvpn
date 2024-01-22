import 'package:flutter/material.dart';

class ShowDialogPage extends StatefulWidget {
  const ShowDialogPage({super.key});

  @override
  State<ShowDialogPage> createState() => _ShowDialogPageState();
}

class _ShowDialogPageState extends State<ShowDialogPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
     
      child: Text("You were connected to a server so you couldn't test your Internet speed!" , style: TextStyle(color: Colors.red), ),
    );
  }
}