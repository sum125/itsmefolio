import 'package:flutter/material.dart';

class LinkedinIcon extends StatelessWidget {
  final double size;
  const LinkedinIcon({super.key, this.size = 44});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFF1D1D1B),
        borderRadius: BorderRadius.circular(size * 0.2),
      ),
      alignment: Alignment.center,
      child: Text(
        'in',
        style: TextStyle(
          fontFamily: 'IBM Plex Mono',
          fontWeight: FontWeight.bold,
          fontSize: size * 0.45,
          color: const Color(0xFFF3F3EF),
        ),
      ),
    );
  }
}
