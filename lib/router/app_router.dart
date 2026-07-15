import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/home_page.dart';
import '../screens/about_page.dart';
import '../screens/projects_page.dart';
import '../screens/projects_detail_page.dart';
import '../screens/contact_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutPage(),
    ),
    GoRoute(
      path: '/projects',
      builder: (context, state) => const ProjectsPage(), // WorkPage → ProjectsPage
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final String projectId = state.pathParameters['id']!;
            return ProjectsDetailPage(projectId: projectId); // 클래스명도 확인 필요
          },
        ),
      ],
    ),
    GoRoute(
      path: '/contact',
      builder: (context, state) => const ContactPage(),
    ),
  ],
  errorBuilder: (context, state) => const Scaffold(
    body: Center(child: Text('페이지를 찾을 수 없습니다')),
  ),
);
