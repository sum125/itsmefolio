import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_app/widget/keyhole_hub.dart';
import 'package:portfolio_app/widget/keyhole_cursor_area.dart';
import 'package:portfolio_app/widget/page_header.dart';
import 'package:portfolio_app/widget/section_heading.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  double _progress = 0.0;

  late final AnimationController _bounceController;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final screenHeight = MediaQuery.of(context).size.height;
    setState(() {
      _progress = (_scrollController.offset / screenHeight).clamp(0.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _buildSectionA(context),
            _buildSectionB(context),
          ],
        ),
      ),
    );
  }

  // ── Section A: 첫 화면 ──────────────────────────────────────────
  Widget _buildSectionA(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Container(
            color: Color.lerp(Colors.black, Colors.white, _progress),
            child: Center(
              child: Opacity(
                opacity: 1 - _progress,
                child: Transform.scale(
                  scale: 1 + (_progress * 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _bounceController,
                        builder: (context, child) {
                          final double bounceOffset = _bounceController.value * 10;
                          return Transform.translate(
                            offset: Offset(0, -bounceOffset),
                            child: child,
                          );
                        },
                        child: Image.asset(
                          'assets/union.png',
                          width: 80,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'KIM SUMIN — UX RESEARCHER',
                        style: TextStyle(
                          fontFamily: 'IBM Plex Mono',
                          fontSize: 13,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        '질문을 다시 세우는 것에서, 리서치는 시작됩니다',
                        style: TextStyle(
                          fontFamily: 'Gowun Batang',
                          fontSize: 17,
                          color: Color(0xFFCCC9C0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 1 - _progress,
              child: const Center(
                child: Text(
                  'SCROLL',
                  style: TextStyle(
                    fontFamily: 'IBM Plex Mono',
                    fontSize: 11,
                    color: Color(0xFF888888),
                    letterSpacing: 3,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Section B: 질문 → 세 개의 리서치 + CTA ──────────────────────
  // 물음표 하나(질문)에서 세 카드(잠긴 질문들)로 뻗는 구조.
  // 화면 폭과 무관하게 항상 중앙 정렬되어 넓은 화면에서도 여백이 어색해지지 않는다.
  Widget _buildSectionB(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
      color: const Color(0xFFF3F3EF),
      padding: EdgeInsets.all(isMobile ? 20 : 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(),
          const SizedBox(height: 60),

          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                children: [
                  // 중앙 — 물음표 (첫 화면과 같은 아이콘, "질문"의 상징)
                  Image.asset(
                    'assets/union.png',
                    width: 48,
                    color: const Color(0xFF1D1D1B),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '하나의 질문에서 세 개의 리서치로',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Noto Sans KR',
                      fontSize: 14,
                      height: 1.6,
                      color: Color(0xFF1D1D1B),
                    ),
                  ),
                  SizedBox(height: isMobile ? 40 : 56),

                  // 세 리서치 카드 — 데스크톱 3열 / 모바일 세로
                  isMobile ? _mobileNodes(context) : _desktopNodes(context),
                ],
              ),
            ),
          ),

          const SizedBox(height: 56),
          const SectionHeading(
            title: "사용자의 망설임을 관찰합니다",
            subtitle: "질문을 다시 세우는 것에서, 리서치는 시작됩니다",
          ),
          const SizedBox(height: 40),
          Center(child: _viewAllCta(context)),
        ],
      ),
    );
  }

  Widget _desktopNodes(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _nodeCard(
            context,
            label: 'RESEARCH 01',
            title: '챗봇 인터랙션 UXR',
            onTap: () => context.go('/projects/chatbot'),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _nodeCard(
            context,
            label: 'RESEARCH 02',
            title: '액티브 시니어 여행 리서치',
            onTap: () => context.go('/projects/lgsuite'),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _nodeCard(
            context,
            label: 'RESEARCH 03',
            title: '조직경험 분석',
            onTap: () => context.go('/projects/org'),
          ),
        ),
      ],
    );
  }

  Widget _mobileNodes(BuildContext context) {
    return Column(
      children: [
        _nodeCard(
          context,
          label: 'RESEARCH 01',
          title: '챗봇 인터랙션 UXR',
          onTap: () => context.go('/projects/chatbot'),
        ),
        const SizedBox(height: 16),
        _nodeCard(
          context,
          label: 'RESEARCH 02',
          title: '액티브 시니어 여행 리서치',
          onTap: () => context.go('/projects/lgsuite'),
        ),
        const SizedBox(height: 16),
        _nodeCard(
          context,
          label: 'RESEARCH 03',
          title: '조직경험 분석',
          onTap: () => context.go('/projects/org'),
        ),
      ],
    );
  }

  Widget _nodeCard(
    BuildContext context, {
    required String label,
    required String title,
    required VoidCallback onTap,
  }) {
    return Semantics(
      button: true,
      label: '$title 프로젝트 상세 보기',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        hoverColor: const Color(0x0DA73B2E),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFDDDAD1)),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              SizedBox(
                width: 34,
                height: 41,
                child: KeyholeCursorArea(
                  child: const KeyholeIcon(size: 34),
                ),
              ),
              const SizedBox(height: 16),
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
                '$title →',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Noto Sans KR',
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1D1D1B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _viewAllCta(BuildContext context) {
    return Semantics(
      button: true,
      label: '모든 리서치 프로젝트 보기',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: InkWell(
          onTap: () => context.go('/projects'),
          borderRadius: BorderRadius.circular(4),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF1D1D1B)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              '모든 리서치 보기 →',
              style: TextStyle(
                fontFamily: 'IBM Plex Mono',
                fontSize: 13,
                color: Color(0xFF1D1D1B),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
