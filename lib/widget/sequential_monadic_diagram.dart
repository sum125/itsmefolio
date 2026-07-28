import 'package:flutter/material.dart';

/// Sequential Monadic 실험 설계를 보여주는 다이어그램.
/// 두 트랙(A: 가이드형→개방형 / B: 개방형→가이드형)이 순서 효과를
/// 제거하기 위해 교차 배치되었음을 시각화한다.
class SequentialMonadicDiagram extends StatelessWidget {
  const SequentialMonadicDiagram({super.key});

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
          'RESEARCH DESIGN — SEQUENTIAL MONADIC',
          style: TextStyle(
            fontFamily: 'IBM Plex Mono',
            fontSize: 11,
            letterSpacing: 2,
            color: _grey,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          '같은 사람이 두 인터랙션을 순차 체험한다',
          style: TextStyle(
            fontFamily: 'Gowun Batang',
            fontSize: 20,
            color: _ink,
          ),
        ),
        const SizedBox(height: 28),

        _track(
          context,
          label: 'TRACK A',
          steps: const ['가이드형 먼저', '진입 · 사용 · 평가', '개방형', '진입 · 사용 · 평가'],
          isMobile: isMobile,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: Text(
              '순서 효과 제거 — 교차 배치',
              style: const TextStyle(
                fontFamily: 'IBM Plex Mono',
                fontSize: 11,
                letterSpacing: 1.5,
                color: _brick,
              ),
            ),
          ),
        ),
        _track(
          context,
          label: 'TRACK B',
          steps: const ['개방형 먼저', '진입 · 사용 · 평가', '가이드형', '진입 · 사용 · 평가'],
          isMobile: isMobile,
        ),
        const SizedBox(height: 28),

        // 통제 조건 4가지
        isMobile
            ? Column(
                children: [
                  for (final c in _controls) ...[
                    _controlCard(c.$1, c.$2),
                    const SizedBox(height: 12),
                  ],
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < _controls.length; i++) ...[
                    Expanded(child: _controlCard(_controls[i].$1, _controls[i].$2)),
                    if (i != _controls.length - 1) const SizedBox(width: 16),
                  ],
                ],
              ),
        const SizedBox(height: 28),

        Center(
          child: Text(
            '두 번째 경험에서 드러나는 상대적 체감 차이를 포착하기 위한 설계',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Gowun Batang',
              fontSize: 15,
              color: _brick,
            ),
          ),
        ),
      ],
    );
  }

  static const List<(String, String)> _controls = [
    ('① 성향 밸런스', '가이드형 4명 + 개방형 4명 선별'),
    ('② 기술 숙련도 통제', 'AI 경험 유/무 균형'),
    ('③ 성비 밸런스', '표본 내 성별 구성 균형'),
    ('④ 순서 효과 제거', '선행 앱 교차 배치'),
  ];

  Widget _controlCard(String title, String body) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: _line),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'IBM Plex Mono',
              fontSize: 12,
              color: _ink,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: const TextStyle(
              fontFamily: 'Noto Sans KR',
              fontSize: 13,
              height: 1.5,
              color: _grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _track(
    BuildContext context, {
    required String label,
    required List<String> steps,
    required bool isMobile,
  }) {
    final chips = <Widget>[];
    for (int i = 0; i < steps.length; i++) {
      final bool isFirst = i == 0;
      chips.add(_chip(steps[i], emphasize: isFirst));
      if (i != steps.length - 1) {
        chips.add(
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Text('→', style: TextStyle(color: _grey, fontSize: 16)),
          ),
        );
      }
    }
    chips.add(
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 6),
        child: Text('→', style: TextStyle(color: _grey, fontSize: 16)),
      ),
    );
    chips.add(_chip('사후 질문', emphasize: true, accent: true));

    final content = Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 0,
      runSpacing: 8,
      children: chips,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 64,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'IBM Plex Mono',
              fontSize: 11,
              color: _grey,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: content),
      ],
    );
  }

  Widget _chip(String text, {bool emphasize = false, bool accent = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: accent ? _brick : _line),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'IBM Plex Mono',
          fontSize: 11.5,
          color: accent ? _brick : (emphasize ? _ink : _grey),
        ),
      ),
    );
  }
}
