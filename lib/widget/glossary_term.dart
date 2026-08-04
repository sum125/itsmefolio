import 'package:flutter/material.dart';

class GlossarySegment {
  final String text;
  final String? term;
  final String? definition;
  final String? rationale;

  const GlossarySegment.text(this.text) : term = null, definition = null, rationale = null;

  const GlossarySegment.term({
    required this.text,
    required String definition,
    required String rationale,
  }) : term = text,
       definition = definition,
       rationale = rationale;
}

class GlossaryParagraph extends StatelessWidget {
  final List<GlossarySegment> segments;
  final double fontSize;

  const GlossaryParagraph({
    super.key,
    required this.segments,
    this.fontSize = 15,
  });

  void _showPopup(BuildContext context, GlossarySegment s) {
    showDialog(
      context: context,
      barrierColor: const Color(0x33000000),
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFFF3F3EF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s.term!,
                style: const TextStyle(
                  fontFamily: 'Gowun Batang',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFFA73B2E),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'WHAT',
                style: TextStyle(fontFamily: 'IBM Plex Mono', fontSize: 10, color: Color(0xFFA6A29B)),
              ),
              const SizedBox(height: 4),
              Text(
                s.definition!,
                style: const TextStyle(fontFamily: 'Noto Sans KR', fontSize: 13, height: 1.6, color: Color(0xFF1D1D1B)),
              ),
              const SizedBox(height: 14),
              const Text(
                'WHY THIS STUDY USED IT',
                style: TextStyle(fontFamily: 'IBM Plex Mono', fontSize: 10, color: Color(0xFFA6A29B)),
              ),
              const SizedBox(height: 4),
              Text(
                s.rationale!,
                style: const TextStyle(fontFamily: 'Noto Sans KR', fontSize: 13, height: 1.6, color: Color(0xFF1D1D1B)),
              ),
              const SizedBox(height: 18),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    '닫기',
                    style: TextStyle(fontFamily: 'IBM Plex Mono', fontSize: 12, color: Color(0xFF1D1D1B)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = TextStyle(
      fontFamily: 'Noto Sans KR',
      fontSize: fontSize,
      height: 1.8,
      color: const Color(0xFF1D1D1B),
    );

    return Text.rich(
      TextSpan(
        children: segments.map((s) {
          if (s.term == null) {
            return TextSpan(text: s.text, style: baseStyle);
          }
          return WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: GestureDetector(
              onTap: () => _showPopup(context, s),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Color(0xFFA73B2E), width: 1)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(s.text, style: baseStyle.copyWith(color: const Color(0xFFA73B2E))),
                      const SizedBox(width: 2),
                      Container(
                        width: 13,
                        height: 13,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFA73B2E), width: 1),
                        ),
                        child: const Text(
                          '?',
                          style: TextStyle(fontFamily: 'IBM Plex Mono', fontSize: 8, color: Color(0xFFA73B2E)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
