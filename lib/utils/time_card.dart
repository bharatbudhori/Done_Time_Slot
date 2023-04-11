import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TimeCard extends StatelessWidget {
  TimeCard({
    super.key,
    required this.content,
    required this.color,
    required this.backgroundColor,
  });
  String content;
  Color color;
  Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3.5,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          content,
          style: TextStyle(
            fontSize: 20,
            color: color,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
      ),
    );
  }
}
