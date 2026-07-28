import 'package:flutter/material.dart';

/// 분석 축/방법론 피벗을 시각화하는 공용 위젯.
/// RedefinitionMark의 시각 언어(취소선 → 세리프 벽돌빨강)를 계승한다.
/// 사용처: 프로젝트 상세 페이지의 '발견(KeyMoment)' 섹션 직후.
class PivotDiagram extends StatelessWidget {
  final String from;
  final String fromNote;
  final String to;
  final String toNote;
  final String? evidenceLabel;
  final List<String> evidences;
  final String? evidenceNote;

  const PivotDiagram({
    super.key,
    required this.from,
    required this.fromNote,
    required this.to,
    required this.toNote,
    this.evidenceLabel,
    this.evidences = const [],
    this.evidenceNote,
  });

  static const Color _ink = Color(0xFF1D1D1B);
  static const Color _grey = Color(0xFFA6A29B);
  static const Color _brick = Color(0xFFA73B2E);
  static const Color _line = Color(0xFFDDDAD1);

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'PIVOT POINT',
          style: TextStyle(
            fontFamily: 'IBM Plex Mono',
            fontSize: 11,
            letterSpacing: 2,
            color: _grey,
          ),
        ),
        const SizedBox(height: 24),
        isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _fromBlock(),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Icon(Icons.arrow_downward, size: 20, color: _grey),
                  ),
                  _toBlock(),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _fromBlock()),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Icon(Icons.arrow_forward, size: 22, color: _grey),
                  ),
                  Expanded(child: _toBlock()),
                ],
              ),
        if (evidenceLabel != null && evidences.isNotEmpty) ...[
          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: _line),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  evidenceLabel!,
                  style: const TextStyle(
                    fontFamily: 'IBM Plex Mono',
                    fontSize: 10,
                    letterSpacing: 2,
                    color: _grey,
                  ),
                ),
                const SizedBox(height: 12),
                for (final e in evidences)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      e,
                      style: const TextStyle(
                        fontFamily: 'IBM Plex Mono',
                        fontSize: 12.5,
                        height: 1.5,
                        color: _ink,
                      ),
                    ),
                  ),
                if (evidenceNote != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    evidenceNote!,
                    style: const TextStyle(
                      fontFamily: 'Noto Sans KR',
                      fontSize: 12,
                      color: _grey,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _fromBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          from,
          style: const TextStyle(
            fontFamily: 'Noto Sans KR',
            fontSize: 18,
            color: _grey,
            decoration: TextDecoration.lineThrough,
            decorationColor: _grey,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          fromNote,
          style: const TextStyle(
            fontFamily: 'Noto Sans KR',
            fontSize: 12.5,
            height: 1.6,
            color: _grey,
          ),
        ),
      ],
    );
  }

  Widget _toBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          to,
          style: const TextStyle(
            fontFamily: 'Gowun Batang',
            fontWeight: FontWeight.bold,
            fontSize: 21,
            color: _brick,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          toNote,
          style: const TextStyle(
            fontFamily: 'Noto Sans KR',
            fontSize: 12.5,
            height: 1.6,
            color: _ink,
          ),
        ),
      ],
    );
  }
}
