import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_app/widget/page_header.dart';
import 'package:portfolio_app/widget/section_heading.dart';
import 'package:portfolio_app/widget/resume_block.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const Color _ink = Color(0xFF1D1D1B);
  static const Color _grey = Color(0xFFA6A29B);
  static const Color _brick = Color(0xFFA73B2E);
  static const Color _photoBg = Color(0xFFE3E1D8);

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3EF),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 20 : 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageHeader(label: 'ABOUT'),
            SizedBox(height: isMobile ? 40 : 60),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _photo(width: double.infinity, height: 320),
                          const SizedBox(height: 32),
                          _content(context),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _photo(width: 280, height: 340),
                          const SizedBox(width: 48),
                          Expanded(child: _content(context)),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _photo({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: _photoBg,
        borderRadius: BorderRadius.circular(4),
        image: const DecorationImage(
          image: AssetImage('assets/me.png'), // WebP 변환 후 me.webp로 교체 권장
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(
          title: "사용자 행동 뒤의 맥락과 감정을 읽습니다",
          subtitle: "질문을 그대로 받지 않고, 다시 세우는 것부터 시작합니다",
        ),
        const SizedBox(height: 28),
        const Text(
          '경제학으로 구조를 보고, 상담·UX심리로 사람을 봅니다.\n'
          '숫자가 말하지 않는 이유를 인터뷰로 찾고,\n'
          '인터뷰가 놓치는 패턴을 데이터로 확인하는 리서처입니다.',
          style: TextStyle(
            fontFamily: 'Gowun Batang',
            fontSize: 16,
            height: 1.9,
            color: _ink,
          ),
        ),
        const SizedBox(height: 44),
        const ResumeBlock(
          heading: 'EXPERIENCE',
          items: [
            '삼성헬스 마음챙김 AI 콘텐츠·코칭 프로세스 개발 — 산학과제 연구보조원 (2025.10–12)',
            '에프엠커뮤니케이션즈 XTL부서 — 프로모션 기획·실행 인턴 (2024.07–12)',
            'StopNCII 기반 청소년 디지털 성범죄 예방 기획 — Meta 연계 (2025.06–08)',
          ],
        ),
        const SizedBox(height: 16),
        _projectsLink(context),
        const SizedBox(height: 40),
        const ResumeBlock(
          heading: 'EDUCATION',
          items: [
            '한국외국어대학교 경제학 전공 · 상담/UX심리 이중전공 (2026.08 졸업예정)',
          ],
        ),
        const SizedBox(height: 40),
        const ResumeBlock(
          heading: 'DATA & TOOLS',
          items: [
            'AdSP · SQLD · Google Analytics(GAIQ) — 정량 검증',
            'SBERT · UMAP · HDBSCAN — 텍스트마이닝', // [확인] KMeans/HDBSCAN 최종 표기 통일 필요
            '심층 인터뷰 · Sequential Monadic — 정성 리서치',
            'Figma · Flutter — 설계와 구현',
          ],
        ),
        const SizedBox(height: 56),
        const ResumeBlock(
          heading: 'ABOUT THIS SITE',
          items: [
            '첫 화면에서 정보를 숨긴 이유 — 리서치는 답이 아니라 질문에서 시작된다는 경험을 방문자에게도 재현하고 싶었습니다',
            '모든 케이스가 같은 6섹션 구조인 이유 — 요약, 재정의, 방법, 발견, 결정, 회고. 리서치를 반복 가능한 시스템으로 다룬다는 것을 구조로 보여주기 위해서입니다',
            '피벗 다이어그램을 이미지가 아니라 컴포넌트로 만든 이유 — 세 프로젝트에서 같은 구조가 반복된다는 것 자체가 리서치 방식의 증거이기 때문입니다',
          ],
        ),
      ],
    );
  }

  Widget _projectsLink(BuildContext context) {
    return Semantics(
      button: true,
      label: '리서치 케이스 보러 가기',
      child: InkWell(
        onTap: () => context.go('/projects'),
        borderRadius: BorderRadius.circular(4),
        hoverColor: const Color(0x0DA73B2E),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Text(
            '리서치 케이스 3건은 Projects에서 보실 수 있습니다 →',
            style: TextStyle(
              fontFamily: 'Noto Sans KR',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _brick,
            ),
          ),
        ),
      ),
    );
  }
}
