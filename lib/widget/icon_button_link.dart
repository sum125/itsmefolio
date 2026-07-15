import 'package:flutter/material.dart';

class IconButtonLink extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const IconButtonLink({
    super.key,
    required this.imagePath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Image.asset(imagePath, width: 44, height: 44),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'IBM Plex Mono',
                fontSize: 12,
                color: Color(0xFF1D1D1B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
