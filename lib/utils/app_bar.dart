import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProgressAppBar extends StatelessWidget {
  ProgressAppBar({super.key, required this.progressValue});
  double progressValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      width: MediaQuery.of(context).size.width * 0.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: LinearProgressIndicator(
          value: progressValue,
          backgroundColor: const Color.fromARGB(173, 211, 207, 207),
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );
  }
}
