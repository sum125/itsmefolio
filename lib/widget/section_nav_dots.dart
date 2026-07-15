import 'package:flutter/material.dart';

class SectionNavDots extends StatelessWidget {
  final List<String> labels;
  final int activeIndex;
  final void Function(int index) onTapDot;

  const SectionNavDots({
    super.key,
    required this.labels,
    required this.activeIndex,
    required this.onTapDot,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(labels.length, (index) {
        final bool isActive = index == activeIndex;
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => onTapDot(index),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: isActive ? 8 : 6,
                    height: isActive ? 8 : 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive ? const Color(0xFFA73B2E) : const Color(0xFFDDDAD1),
                    ),
                  ),
                  if (isActive) ...[
                    const SizedBox(width: 8),
                    Text(
                      labels[index],
                      style: const TextStyle(
                        fontFamily: 'IBM Plex Mono',
                        fontSize: 10,
                        color: Color(0xFFA73B2E),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
