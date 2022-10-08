import 'package:flutter/material.dart';

Widget profileDetailBox(String title, String value) {
  return Container(
    height: 70,
    width: 80,
    decoration: BoxDecoration(
        color: Color(0xFF100E20), borderRadius: BorderRadius.circular(15.0)),
    child: Column(
      children: [
        Text(
          '$value',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$title',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    ),
  );
}
