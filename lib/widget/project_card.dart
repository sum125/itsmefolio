import 'package:flutter/material.dart';
import 'keyhole_hub.dart';
import 'keyhole_cursor_area.dart';

class ProjectCard extends StatefulWidget {
  final String number; // '01', '02', '03'
  final String title;
  final String meta;
  final VoidCallback onTap;

  const ProjectCard({
    super.key,
    required this.number,
    required this.title,
    required this.meta,
    required this.onTap,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF1D1D1B), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 서랍 칸 — 열쇠구멍 + 빛나는 번호 배지
              AspectRatio(
                aspectRatio: 1,
                child: KeyholeCursorArea(
                  child: Container(
                    color: const Color(0xFFEDEBE4),
                    child: Stack(
                      children: [
                        const Center(
                          child: KeyholeIcon(size: 44, color: Color(0xFF1D1D1B)),
                        ),
                        Positioned(
                          top: 12,
                          left: 12,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFF3F3EF),
                              border: Border.all(
                                color: const Color(0xFFA73B2E),
                                width: 1.2,
                              ),
                              boxShadow: _isHovering
                                  ? [
                                      BoxShadow(
                                        color: const Color(0xFFA73B2E).withOpacity(0.55),
                                        blurRadius: 12,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Center(
                              child: Text(
                                widget.number,
                                style: const TextStyle(
                                  fontFamily: 'IBM Plex Mono',
                                  fontSize: 11,
                                  color: Color(0xFFA73B2E),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 하단 라벨
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Color(0xFF1D1D1B), width: 1),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontFamily: 'Gowun Batang',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFF1D1D1B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.meta,
                      style: const TextStyle(
                        fontFamily: 'IBM Plex Mono',
                        fontSize: 10,
                        color: Color(0xFFA6A29B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
