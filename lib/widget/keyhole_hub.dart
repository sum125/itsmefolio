import 'package:flutter/material.dart';
import 'keyhole_cursor_area.dart';

// 작은 열쇠구멍 아이콘 (프로젝트 노드용)
class KeyholeIcon extends StatelessWidget {
  final double size;
  final Color color;
  const KeyholeIcon({
    super.key,
    this.size = 40,
    this.color = const Color(0xFF1D1D1B),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size * 1.2),
      painter: _KeyholePainter(color: color),
    );
  }
}

class _KeyholePainter extends CustomPainter {
  final Color color;
  _KeyholePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    canvas.drawCircle(
      Offset(size.width / 2, size.width * 0.3),
      size.width * 0.3,
      paint,
    );

    final path = Path()
      ..moveTo(size.width * 0.3, size.height * 0.45)
      ..lineTo(size.width * 0.7, size.height * 0.45)
      ..lineTo(size.width * 0.85, size.height)
      ..lineTo(size.width * 0.15, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _KeyholePainter oldDelegate) => false;
}

// 프로젝트 노드 (아이콘 + 텍스트 + 클릭)
// STEP 7-1: label/title 위계 교환 + 제목 끝 화살표로 상시 클릭 단서
// STEP 8-1: GestureDetector → Semantics + InkWell
class ProjectNode extends StatelessWidget {
  final String label;
  final String title;
  final VoidCallback onTap;
  const ProjectNode({
    super.key,
    required this.label,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '$title 프로젝트 상세 보기',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        hoverColor: const Color(0x0DA73B2E),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Row(
            children: [
              SizedBox(
                width: 36,
                height: 43,
                child: KeyholeCursorArea(
                  child: const KeyholeIcon(size: 36),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 라벨 — 보조 정보로 축소
                  Text(
                    label,
                    style: const TextStyle(
                      fontFamily: 'IBM Plex Mono',
                      fontSize: 11,
                      color: Color(0xFFA6A29B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  // 제목 — 주인공으로 승격 + 상시 클릭 단서(화살표)
                  Text(
                    '$title →',
                    style: const TextStyle(
                      fontFamily: 'Noto Sans KR',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1D1D1B),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 중심 열쇠구멍 → 3개 노드로 이어지는 연결선
class HubLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFDDDAD1)
      ..strokeWidth = 1;

    final Offset hub = Offset(size.width * 0.35, size.height * 0.5);

    canvas.drawLine(hub, Offset(size.width * 0.85, size.height * 0.1), paint);
    canvas.drawLine(hub, Offset(size.width * 0.85, size.height * 0.5), paint);
    canvas.drawLine(hub, Offset(size.width * 0.85, size.height * 0.9), paint);
  }

  @override
  bool shouldRepaint(covariant HubLinesPainter oldDelegate) => false;
}
