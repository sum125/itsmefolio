import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_app/widget/page_header.dart';
import 'package:portfolio_app/widget/project_card.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  static const List<Map<String, String>> _projects = [
    {
      'id': 'chatbot',
      'title': '챗봇 인터랙션 UXR',
      'meta': '4주 · 표본 60',
    },
    {
      'id': 'lgsuite',
      'title': '액티브 시니어 여행 리서치',
      'meta': '텍스트마이닝 · 15,000건+',
    },
    {
      'id': 'org',
      'title': '조직경험 분석',
      'meta': '5주 · 인터뷰 기반',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3EF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PageHeader는 폭 제한 밖 — 화면 전체 너비 기준
            const PageHeader(label: 'WORK'),
            const SizedBox(height: 60),

            // 본문(카탈로그 라벨 + 카드)만 폭 제한 + 가운데 정렬
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                              number: '0${i + 1}', // sku: 대신 number:
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
          ],
        ),
      ),
    );
  }
}
