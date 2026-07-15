import 'package:flutter/material.dart';
import 'package:portfolio_app/widget/page_header.dart';
import 'package:portfolio_app/widget/section_heading.dart';
import 'package:portfolio_app/widget/resume_block.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3EF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageHeader(label: 'ABOUT'),
            const SizedBox(height: 60),

            // 사진(왼쪽 고정) + 텍스트(오른쪽) 좌우분할
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 왼쪽 — 프로필 사진
                Container(
                  width: 280,
                  height: 340,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3E1D8),
                    borderRadius: BorderRadius.circular(4),
                    image: const DecorationImage(
                      image: AssetImage('assets/me.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 48),

                // 오른쪽 — 정체성 서술 + 이력
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionHeading(
                        title: "사용자 행동 뒤의 맥락과 감정을 읽습니다",
                        subtitle: "질문을 그대로 받지 않고, 다시 세우는 것부터 시작합니다",
                      ),
                      const SizedBox(height: 40),

                      const ResumeBlock(
                        heading: 'EDUCATION & CAREER',
                        items: [
                          '카카오뱅크 AI홈팀 UX Research 인턴',
                          'CJ올리브네트웍스 UX/UI 기획·리서치',
                          // 실제 학력/경력 항목으로 교체 예정
                        ],
                      ),
                      const SizedBox(height: 32),

                      const ResumeBlock(
                        heading: 'TOOLS & METHODOLOGY',
                        items: [
                          'Figma · Flutter',
                          '스크리닝 서베이 · 심층 인터뷰',
                          'Sequential Monadic 비교분석',
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
