import 'package:flutter/material.dart';
import 'rich_body_text.dart';

class StorySection extends StatelessWidget {
  final String heading;
  final String body;

  const StorySection({
    super.key,
    required this.heading,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: const TextStyle(
            fontFamily: 'IBM Plex Mono',
            fontSize: 11,
            color: Color(0xFFA73B2E),
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 10),
        RichBodyText(
          text: body,
          style: const TextStyle(
            fontFamily: 'Noto Sans KR',
            fontWeight: FontWeight.w400,
            fontSize: 15,
            height: 1.8,
            color: Color(0xFF1D1D1B),
          ),
        ),
      ],
    );
  }
}
