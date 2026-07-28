import 'package:flutter/material.dart';

class ProcessStep {
  final String title;
  final String description;
  const ProcessStep({required this.title, required this.description});
}

class ProcessFlow extends StatelessWidget {
  final List<ProcessStep> steps;
  const ProcessFlow({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(steps.length, (index) {
        final bool isLast = index == steps.length - 1;
        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : 28),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFA73B2E), width: 1.2),
                ),
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    fontFamily: 'IBM Plex Mono',
                    fontSize: 10,
                    color: Color(0xFFA73B2E),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      steps[index].title,
                      style: const TextStyle(
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Color(0xFF1D1D1B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      steps[index].description,
                      style: const TextStyle(
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                        height: 1.6,
                        color: Color(0xFFA6A29B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
