import 'package:flutter/material.dart';

/// 본문 문자열 안의 **강조** 구간을 검정(잉크) 볼드체로 렌더링하고,
/// \n\n(빈 줄)을 기준으로 문단을 나눠 사이에 여백을 넣는 위젯.
/// 브릭레드는 헤딩·구조 신호 전용으로 남겨두고, 본문 강조는 굵기만으로 처리한다.
class RichBodyText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextStyle? boldStyle;
  final double paragraphSpacing;

  const RichBodyText({
    super.key,
    required this.text,
    required this.style,
    this.boldStyle,
    this.paragraphSpacing = 14,
  });

  List<InlineSpan> _parseBold(String paragraph) {
    final TextStyle effectiveBoldStyle = boldStyle ?? style.copyWith(fontWeight: FontWeight.w700);

    final RegExp pattern = RegExp(r'\*\*(.+?)\*\*');
    final List<InlineSpan> spans = [];
    int lastEnd = 0;

    for (final RegExpMatch match in pattern.allMatches(paragraph)) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(text: paragraph.substring(lastEnd, match.start), style: style));
      }
      spans.add(TextSpan(text: match.group(1), style: effectiveBoldStyle));
      lastEnd = match.end;
    }
    if (lastEnd < paragraph.length) {
      spans.add(TextSpan(text: paragraph.substring(lastEnd), style: style));
    }
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> paragraphs = text.split('\n\n').where((p) => p.trim().isNotEmpty).toList();

    if (paragraphs.length <= 1) {
      return Text.rich(TextSpan(children: _parseBold(text)));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(paragraphs.length, (i) {
        final bool isLast = i == paragraphs.length - 1;
        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : paragraphSpacing),
          child: Text.rich(TextSpan(children: _parseBold(paragraphs[i]))),
        );
      }),
    );
  }
}
