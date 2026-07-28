import 'package:flutter/material.dart';

/// GGP(HUFS Global Growth Point) 제도의 운영 순환 구조를 시각화한다.
/// 발견(공백) → 화살표 → 4단계 순환 다이어그램 순서.
class GgpCycleDiagram extends StatelessWidget {
  const GgpCycleDiagram({super.key});

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
          'SOLUTION — HUFS GLOBAL GROWTH POINT',
          style: TextStyle(
            fontFamily: 'IBM Plex Mono',
            fontSize: 11,
            letterSpacing: 2,
            color: _grey,
          ),
        ),
        const SizedBox(height: 28),

        // 발견(공백) 블록
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '자기개발 지원 체계의 공백',
              style: TextStyle(
                fontFamily: 'Noto Sans KR',
                fontSize: 16,
                color: _grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '제도들이 따로 놀아 전문가 성장 트랙이 부재',
              style: TextStyle(
                fontFamily: 'Noto Sans KR',
                fontSize: 13,
                height: 1.6,
                color: _grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Icon(Icons.arrow_downward, size: 22, color: _grey),
        const SizedBox(height: 32),

        // 순환 다이어그램: 데스크톱은 원형, 모바일은 세로 순환 리스트
        Center(
          child: isMobile ? _mobileCycle() : _desktopCycle(),
        ),

        const SizedBox(height: 32),
        const Text(
          '시범운영 신청서(IDP) 설계까지 완료 — 측정 1순위 지표: 재신청률',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Noto Sans KR',
            fontSize: 13,
            color: _ink,
          ),
        ),
      ],
    );
  }

  // 데스크톱: 원 둘레에 4단계를 배치하고 중앙에 인사이트 문장
  // 라벨 구역을 원의 바운딩 박스 바깥으로 완전히 분리해 겹침을 방지한다.
  Widget _desktopCycle() {
    const double circleSize = 300;
    const double labelZone = 150; // 좌우 라벨이 차지하는 폭
    const double totalWidth = circleSize + labelZone * 2;
    const double totalHeight = circleSize + 100; // 상하 라벨 여백

    return SizedBox(
      width: totalWidth,
      height: totalHeight,
      child: Stack(
        children: [
          // 원 — 정중앙에 고정
          Positioned(
            left: labelZone,
            top: 50,
            child: Container(
              width: circleSize,
              height: circleSize,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                border: Border.fromBorderSide(BorderSide(color: _line, width: 1)),
              ),
            ),
          ),

          // 상단 라벨 — 원 위쪽 여백에
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(child: _StageLabel('학습 활동')),
          ),
          // 하단 라벨 — 원 아래쪽 여백에
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(child: _StageLabel('교육 · 자기개발에 사용')),
          ),
          // 우측 라벨 — 원 오른쪽 바깥 여백에 (겹침 없음)
          const Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            width: labelZone,
            child: Center(child: _StageLabel('포인트 적립')),
          ),
          // 좌측 라벨 — 원 왼쪽 바깥 여백에 (겹침 없음)
          const Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            width: labelZone,
            child: Center(child: _StageLabel('재신청 (순환)')),
          ),

          // 중앙 인사이트 문장
          const Positioned.fill(
            child: Center(
              child: SizedBox(
                width: 190,
                child: Text(
                  '몰입은 기여가\n인정받는 순간에서',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Gowun Batang',
                    fontSize: 18,
                    height: 1.5,
                    color: _brick,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 모바일: 원형 대신 세로 4단계 + 순환 화살표 표기
  Widget _mobileCycle() {
    const stages = ['학습 활동', '포인트 적립', '교육 · 자기개발에 사용', '재신청 (순환)'];
    return Column(
      children: [
        for (int i = 0; i < stages.length; i++) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: _line),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              stages[i],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'IBM Plex Mono',
                fontSize: 12,
                color: _ink,
              ),
            ),
          ),
          if (i != stages.length - 1)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Icon(Icons.arrow_downward, size: 16, color: _grey),
            ),
        ],
        const SizedBox(height: 20),
        const Text(
          '몰입은 기여가 인정받는 순간에서',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Gowun Batang',
            fontSize: 17,
            color: _brick,
          ),
        ),
      ],
    );
  }
}

class _StageLabel extends StatelessWidget {
  final String text;
  const _StageLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'IBM Plex Mono',
          fontSize: 11,
          color: Color(0xFF1D1D1B),
        ),
      ),
    );
  }
}
