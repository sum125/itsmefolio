import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_app/widget/nav_items.dart';
import 'package:portfolio_app/widget/keyhole_hub.dart';
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
            // Section A
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Container(
                color: Color.lerp(Colors.black, Colors.white, _progress),
                child: Center(
                  child: Opacity(
                    opacity: 1 - _progress,
                    child: Transform.scale(
                      scale: 1 + (_progress * 2),
                      child: AnimatedBuilder(
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
                    ),
                  ),
                ),
              ),
            ),

            // Section B
            _buildSectionB(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionB(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
      color: const Color(0xFFF3F3EF),
      padding: const EdgeInsets.all(48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(),
          const SizedBox(height: 60),

          // 허브 다이어그램 — Align은 여기서 끝
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 420,
              width: 1280,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(painter: HubLinesPainter()),
                  ),
                  const Positioned(
                    left: 0,
                    top: 60,
                    child: SizedBox(
                      width: 150,
                      child: Placeholder(fallbackHeight: 260),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 20,
                    child: ProjectNode(
                      label: 'RESEARCH 01',
                      title: '챗봇 인터랙션 UXR',
                      onTap: () => context.go('/projects/chatbot'),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 190,
                    child: ProjectNode(
                      label: 'RESEARCH 02',
                      title: '오디오북 UX 비교',
                      onTap: () => context.go('/projects/audiobook'),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 360,
                    child: ProjectNode(
                      label: 'RESEARCH 03',
                      title: '조직경험 분석',
                      onTap: () => context.go('/projects/org'),
                    ),
                  ),
                ],
              ),
            ),
          ), // ← Align 닫는 괄호, 여기서 끝

          const SizedBox(height: 20), // ← Column의 다음 children으로 정상 배치
          const SectionHeading(
            title: "사용자의 망설임을 관찰합니다",
            subtitle: "질문을 다시 세우는 것에서, 리서치는 시작됩니다",
          ),
        ],
      ),
    );
  }
}
