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
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Icon(Icons.circle_rounded, size: 10, color: Colors.white,)),
        const SizedBox(width: 5,),
        Container( child: Text( '${widget.text}', style: const TextStyle(color: Color(0xffffff00)),)),
        
        
        
      ],
    );
  }
}