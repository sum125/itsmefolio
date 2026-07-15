import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio_app/widget/page_header.dart';
import 'package:portfolio_app/widget/section_heading.dart';
import 'package:portfolio_app/widget/icon_button_link.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  static const String _email = 'your-email@example.com'; // 실제 이메일로 교체
  static const String _phone = '01000000000'; // 실제 번호로 교체 (하이픈 없이)
  static const String _resumeUrl = 'https://your-resume-link.com'; // 실제 이력서 링크로 교체

  Future<void> _launchEmail() async {
    final uri = Uri(scheme: 'mailto', path: _email);
    await launchUrl(uri);
  }

  Future<void> _launchPhone() async {
    final uri = Uri(scheme: 'tel', path: _phone);
    await launchUrl(uri);
  }

  Future<void> _launchResume() async {
    final uri = Uri.parse(_resumeUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3EF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageHeader(label: 'CONTACT'),
            const SizedBox(height: 60),

            const SectionHeading(
              title: "함께 다음 질문을 찾고 싶습니다",
              subtitle: "이메일, 전화, 이력서 중 편한 방법으로 연락 주세요",
            ),
            const SizedBox(height: 48),

            Row(
              children: [
                IconButtonLink(
                  imagePath: 'assets/email_button.png',
                  label: 'EMAIL',
                  onTap: _launchEmail,
                ),
                const SizedBox(width: 40),
                IconButtonLink(
                  imagePath: 'assets/phone_button.png',
                  label: 'CALL',
                  onTap: _launchPhone,
                ),
              ],
            ),
            const SizedBox(height: 56),

            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: _launchResume,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF1D1D1B)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    '이력서 다운로드',
                    style: TextStyle(
                      fontFamily: 'IBM Plex Mono',
                      fontSize: 12,
                      color: Color(0xFF1D1D1B),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
