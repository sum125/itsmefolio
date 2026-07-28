import 'package:flutter/material.dart';

/// 클러스터 분석에서 도출된 핵심 페르소나를 보여주는 카드.
/// 스톡 사진·태그 배지 등은 배제하고 타이포와 구조로만 구성한다.
class PersonaCard extends StatelessWidget {
  const PersonaCard({super.key});

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
          'KEY PERSONA — FROM CLUSTER DATA',
          style: TextStyle(
            fontFamily: 'IBM Plex Mono',
            fontSize: 11,
            letterSpacing: 2,
            color: _grey,
          ),
        ),
        const SizedBox(height: 20),

        // 이름 · 한 줄 프로필
        const Text(
          '고은재',
          style: TextStyle(
            fontFamily: 'Gowun Batang',
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: _ink,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          '56세 · 부부 동반 여행 선호 · 경제적 여유가 있는 은퇴 준비층',
          style: TextStyle(
            fontFamily: 'Noto Sans KR',
            fontSize: 13,
            color: _grey,
          ),
        ),
        const SizedBox(height: 24),

        // 인용구
        Text(
          '"여행에서도 컨디션을 유지하며,\n끝까지 여행을 잘 하고 싶다."',
          style: const TextStyle(
            fontFamily: 'Gowun Batang',
            fontSize: 19,
            height: 1.6,
            color: _ink,
          ),
        ),
        const SizedBox(height: 16),

        // 핵심 욕구 — 강조
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: const BoxDecoration(
            border: Border(left: BorderSide(color: _brick, width: 2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '핵심 욕구',
                style: TextStyle(
                  fontFamily: 'IBM Plex Mono',
                  fontSize: 10.5,
                  letterSpacing: 1,
                  color: _grey,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '내가 직접 고른 숙소에서, 원하는 만큼 온전히 쉬며\n컨디션을 조절하고 싶다',
                style: TextStyle(
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  height: 1.6,
                  color: _brick,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // 여행 패턴 / 핵심 Pain Points — 3열 → 모바일 1열
        isMobile
            ? Column(
                children: [
                  _column('가치관', _values),
                  const SizedBox(height: 20),
                  _column('여행 패턴', _pattern),
                  const SizedBox(height: 20),
                  _column('핵심 PAIN POINTS', _pain, accent: true),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _column('가치관', _values)),
                  const SizedBox(width: 20),
                  Expanded(child: _column('여행 패턴', _pattern)),
                  const SizedBox(width: 20),
                  Expanded(child: _column('핵심 PAIN POINTS', _pain, accent: true)),
                ],
              ),
      ],
    );
  }

  static const List<String> _values = [
    '내가 원하는 게 뭔지 아는 것, 그것이 나이가 주는 선물이다',
    '스스로 결정한 것에는 만족도 책임도 내가 진다',
    '나이 들수록 잘 쉬는 법을 알아야 한다',
  ];

  static const List<String> _pattern = [
    '연 1~2회, 유럽·동남아 해외 자유여행을 직접 기획',
    '호텔·에어비앤비·리조트를 모두 비교해 직접 예약',
    '여행지보다 숙소 탐색에 더 많은 시간을 투자',
  ];

  static const List<String> _pain = [
    '위치·동선·컨디션을 고려한 숙소 결정에 과도한 시간 소모',
    '장거리 이동으로 체력 부담',
    '컨디션 이슈로 쉼을 택해야 하는 순간, 여행지를 놓치게 됨',
  ];

  Widget _column(String title, List<String> items, {bool accent = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'IBM Plex Mono',
            fontSize: 11,
            letterSpacing: 1,
            color: accent ? _brick : _ink,
          ),
        ),
        const SizedBox(height: 4),
        const Divider(color: _line, height: 20, thickness: 1),
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('· ', style: TextStyle(color: _grey, fontSize: 13)),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontFamily: 'Noto Sans KR',
                      fontSize: 12.5,
                      height: 1.5,
                      color: _ink,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
