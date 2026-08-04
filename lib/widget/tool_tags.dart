import 'package:flutter/material.dart';

class ToolTags extends StatelessWidget {
  final List<String> tags;
  const ToolTags({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: tags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFDDDAD1)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            tag,
            style: const TextStyle(
              fontFamily: 'IBM Plex Mono',
              fontSize: 12,
              color: Color(0xFF1D1D1B),
            ),
          ),
        );
      }).toList(),
    );
  }
}
