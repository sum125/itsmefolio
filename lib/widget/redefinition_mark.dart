import 'package:flutter/material.dart';

class RedefinitionMark extends StatelessWidget {
  final String original;
  final String redefined;

  const RedefinitionMark({
    super.key,
    required this.original,
    required this.redefined,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          original,
          style: const TextStyle(
            fontFamily: 'Noto Sans KR',
            fontSize: 15,
            color: Color(0xFFA6A29B),
            decoration: TextDecoration.lineThrough,
            decorationColor: Color(0xFFA6A29B),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '→ $redefined',
          style: const TextStyle(
            fontFamily: 'Gowun Batang',
            fontWeight: FontWeight.bold,
            fontSize: 19,
            color: Color(0xFFA73B2E),
          ),
        ),
      ],
    );
  }
}
