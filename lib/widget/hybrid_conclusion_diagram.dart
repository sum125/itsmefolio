import 'package:flutter/material.dart';

/// 두 인터랙션 구조(가이드형/개방형)의 강약점을 비교하고,
/// 하이브리드 모델로 수렴하는 결론을 시각화한다.
class HybridConclusionDiagram extends StatelessWidget {
  const HybridConclusionDiagram({super.key});

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
          'CONCLUSION — HYBRID MODEL',
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
                children: [
                  _card(
                    title: '가이드형 (Wysa)',
                    strength: '진입 장벽 낮음 · 심리적 안전감',
                    weakness: '자율성 저하 · 대화 주도권 부재 · 모호한 솔루션',
                  ),
                  const SizedBox(height: 16),
                  _card(
                    title: '개방형 (ChatGPT)',
                    strength: '표현의 자유 · 주도적 해결',
                    weakness: '표현 부담 · 맥락 파악 실패 시 이탈 · 공감 결여',
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _card(
                      title: '가이드형 (Wysa)',
                      strength: '진입 장벽 낮음 · 심리적 안전감',
                      weakness: '자율성 저하 · 대화 주도권 부재 · 모호한 솔루션',
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: _card(
                      title: '개방형 (ChatGPT)',
                      strength: '표현의 자유 · 주도적 해결',
                      weakness: '표현 부담 · 맥락 파악 실패 시 이탈 · 공감 결여',
                    ),
                  ),
                ],
              ),

        const SizedBox(height: 20),
        const Center(
          child: Icon(Icons.arrow_downward, size: 24, color: _grey),
        ),
        const SizedBox(height: 20),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            border: Border.all(color: _brick),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '하이브리드 인터랙션 + 맥락 확인 질문 시스템',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'IBM Plex Mono',
                  fontSize: 13,
                  color: _brick,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                '좋은 가이드의 전제는 형식이 아니라 맥락 파악이다',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Gowun Batang',
                  fontSize: 18,
                  color: _ink,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _card({
    required String title,
    required String strength,
    required String weakness,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
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
              fontSize: 13,
              color: _ink,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'STRENGTH',
            style: TextStyle(
              fontFamily: 'IBM Plex Mono',
              fontSize: 10.5,
              letterSpacing: 1,
              color: _grey,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            strength,
            style: const TextStyle(
              fontFamily: 'Noto Sans KR',
              fontSize: 13,
              height: 1.6,
              color: _ink,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'WEAKNESS',
            style: TextStyle(
              fontFamily: 'IBM Plex Mono',
              fontSize: 10.5,
              letterSpacing: 1,
              color: _grey,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            weakness,
            style: const TextStyle(
              fontFamily: 'Noto Sans KR',
              fontSize: 13,
              height: 1.6,
              color: _ink,
            ),
          ),
        ],
      ),
    );
  }
}
