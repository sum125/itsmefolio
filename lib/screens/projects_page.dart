import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_app/widget/page_header.dart';
import 'package:portfolio_app/widget/project_card.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  // 프로젝트 데이터 — 여기 값만 바꾸면 카드 내용 전체가 바뀜
  static const List<Map<String, String>> _projects = [
    {
      'id': 'chatbot',
      'sku': 'RESEARCH NO. 01',
      'title': '챗봇 인터랙션 UXR',
      'meta': '4주 · 표본 60',
    },
    {
      'id': 'audiobook',
      'sku': 'RESEARCH NO. 02',
      'title': '오디오북 UX 비교',
      'meta': '비교분석 · 2개 앱',
    },
    {
      'id': 'org',
      'sku': 'RESEARCH NO. 03',
      'title': '조직경험 분석',
      'meta': '5주 · 인터뷰 기반',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3EF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Center(
          // ← 추가
          child: ConstrainedBox(
            // ← 추가
            constraints: const BoxConstraints(maxWidth: 1100), // ← 콘텐츠 최대 폭 제한
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PageHeader(label: 'WORK'),
                const SizedBox(height: 60),

                Text(
                  'CATALOG — ${_projects.length} STUDIES',
                  style: const TextStyle(
                    fontFamily: 'IBM Plex Mono',
                    fontSize: 11,
                    color: Color(0xFFA6A29B),
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < _projects.length; i++) ...[
                      Expanded(
                        child: ProjectCard(
                          sku: _projects[i]['sku']!,
                          title: _projects[i]['title']!,
                          meta: _projects[i]['meta']!,
                          onTap: () => context.go('/projects/${_projects[i]['id']}'),
                        ),
                      ),
                      if (i != _projects.length - 1) const SizedBox(width: 24),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
