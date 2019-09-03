import 'package:flutter/material.dart';

Widget cYM(double y) {
  return SizedBox(
    height: y,
  );
}

Widget cXM(double x) {
  return SizedBox(
    width: x,
  );
}

Widget cYMW(double y) {
  return SizedBox(
    height: y,
    child: Container(
      color: Colors.white,

    ),
  );
}