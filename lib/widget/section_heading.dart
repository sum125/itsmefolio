import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionHeading({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Gowun Batang',
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: Color(0xFF1D1D1B),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: const TextStyle(
            fontFamily: 'Noto Sans KR',
            fontWeight: FontWeight.w300,
            fontSize: 14,
            color: Color(0xFFA6A29B),
          ),
        ),
      ],
    );
  }
}
