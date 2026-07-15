import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  final String sku;
  final String title;
  final String meta;
  final VoidCallback onTap;

  const ProjectCard({
    super.key,
    required this.sku,
    required this.title,
    required this.meta,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이미지 자리 (썸네일)
            AspectRatio(
              aspectRatio: 3 / 4, // 4/5 → 3/4로 변경, 카드가 덜 길쭉해짐
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE3E1D8),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 12),

            Text(
              sku,
              style: const TextStyle(
                fontFamily: 'IBM Plex Mono',
                fontSize: 10,
                color: Color(0xFFA73B2E),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 4),

            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Gowun Batang',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF1D1D1B),
              ),
            ),
            const SizedBox(height: 6),

            Text(
              meta,
              style: const TextStyle(
                fontFamily: 'IBM Plex Mono',
                fontSize: 11,
                color: Color(0xFFA6A29B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
