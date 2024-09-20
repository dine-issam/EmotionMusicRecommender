import 'package:flutter/material.dart';

class MyBackground extends StatelessWidget {
  const MyBackground(
      {super.key, required this.backgroundImage, required this.child});
  final String? backgroundImage;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF330000),
            Color(0xFF000000),
          ],
        ),
        // Background image here
        image: DecorationImage(
          image: AssetImage(
            backgroundImage!,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
