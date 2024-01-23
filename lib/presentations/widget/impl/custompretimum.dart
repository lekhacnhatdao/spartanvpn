import 'package:flutter/material.dart';

class CustomPretimum extends StatefulWidget {
  const CustomPretimum({super.key, required this.text,  this.image});
  final String ? image;

  final String text;
  @override
  State<CustomPretimum> createState() => _CustomPretimumState();
}

class _CustomPretimumState extends State<CustomPretimum> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Container( margin: EdgeInsets.symmetric(horizontal: 15), child: Text( '+  ${widget.text}', style: const TextStyle(color: Colors.white,),)),
        
        
        
      ],
    );
  }
}