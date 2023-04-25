import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TimeCard extends StatelessWidget {
  TimeCard({
    super.key,
    required this.content,
    required this.color,
    required this.backgroundColor,
    required this.onPressed,
    this.isDayLabel,
  });
  String content;
  Color color;
  Color backgroundColor;
  bool? isDayLabel;
  VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width / 3.8,
        padding: isDayLabel != null && isDayLabel == true
            ? const EdgeInsets.symmetric(horizontal: 10, vertical: 15)
            : const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            content,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18,
              color: color,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato',
            ),
          ),
        ),
      ),
    );
  }
}
