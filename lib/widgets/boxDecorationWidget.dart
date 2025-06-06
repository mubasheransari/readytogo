import 'package:flutter/material.dart';

 boxDecoration() {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFFE6DCFD),
        Color(0xFFD8E7FF),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
  );
}
