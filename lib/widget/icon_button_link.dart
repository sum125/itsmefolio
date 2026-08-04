import 'package:flutter/material.dart';

class IconButtonLink extends StatelessWidget {
  final String? imagePath;
  final Widget? iconWidget;
  final String label;
  final VoidCallback onTap;

  const IconButtonLink({
    super.key,
    this.imagePath,
    this.iconWidget,
    required this.label,
    required this.onTap,
  }) : assert(imagePath != null || iconWidget != null);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            SizedBox(
              width: 44,
              height: 44,
              child: iconWidget ?? Image.asset(imagePath!, width: 44, height: 44),
            ),
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
