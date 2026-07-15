import 'package:flutter/material.dart';

class ResumeBlock extends StatelessWidget {
  final String heading;
  final List<String> items;

  const ResumeBlock({
    super.key,
    required this.heading,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFDDDAD1), width: 0.7),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 헤딩 영역 — 살짝 다른 배경으로 구분
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFDDDAD1), width: 0.7),
              ),
            ),
            child: Text(
              heading,
              style: const TextStyle(
                fontFamily: 'IBM Plex Mono',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFFA73B2E),
                letterSpacing: 1,
              ),
            ),
          ),

          // 항목 리스트 — 넘버링 + 헤어라인 구분
          ...List.generate(items.length, (index) {
            final bool isLast = index == items.length - 1;
            final String number = (index + 1).toString().padLeft(2, '0');

            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                border: isLast
                    ? null
                    : const Border(
                        bottom: BorderSide(color: Color(0xFFDDDAD1), width: 0.4),
                      ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    number,
                    style: const TextStyle(
                      fontFamily: 'IBM Plex Mono',
                      fontSize: 12,
                      color: Color(0xFFA6A29B),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      items[index],
                      style: const TextStyle(
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xFF1D1D1B),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
