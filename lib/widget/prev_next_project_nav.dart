import 'package:flutter/material.dart';

class PrevNextProjectNav extends StatelessWidget {
  final String prevTitle;
  final String nextTitle;
  final VoidCallback onTapPrev;
  final VoidCallback onTapNext;

  const PrevNextProjectNav({
    super.key,
    required this.prevTitle,
    required this.nextTitle,
    required this.onTapPrev,
    required this.onTapNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 40, bottom: 24),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFFDDDAD1), width: 0.7),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _link(
            alignment: CrossAxisAlignment.start,
            label: '← 이전 프로젝트',
            title: prevTitle,
            onTap: onTapPrev,
          ),
          _link(
            alignment: CrossAxisAlignment.end,
            label: '다음 프로젝트 →',
            title: nextTitle,
            onTap: onTapNext,
          ),
        ],
      ),
    );
  }

  Widget _link({
    required CrossAxisAlignment alignment,
    required String label,
    required String title,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: alignment,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'IBM Plex Mono',
                fontSize: 11,
                color: Color(0xFFA6A29B),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Noto Sans KR',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color(0xFF1D1D1B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
