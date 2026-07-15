import 'package:flutter/material.dart';
import 'keyhole_hub.dart'; // KeyholeIcon 재사용

class KeyMoment extends StatelessWidget {
  final String body;

  const KeyMoment({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const KeyholeIcon(size: 28, color: Color(0xFFA73B2E)),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'UNEXPECTED FINDING',
                style: TextStyle(
                  fontFamily: 'IBM Plex Mono',
                  fontSize: 11,
                  color: Color(0xFFA73B2E),
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                body,
                style: const TextStyle(
                  fontFamily: 'Noto Sans KR',
                  fontSize: 15,
                  height: 1.8,
                  color: Color(0xFF1D1D1B),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
