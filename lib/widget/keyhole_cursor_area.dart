import 'package:flutter/material.dart';
import 'keyhole_hub.dart'; // KeyholeIcon 재사용

class KeyholeCursorArea extends StatefulWidget {
  final Widget child;
  const KeyholeCursorArea({super.key, required this.child});

  @override
  State<KeyholeCursorArea> createState() => _KeyholeCursorAreaState();
}

class _KeyholeCursorAreaState extends State<KeyholeCursorArea> with SingleTickerProviderStateMixin {
  Offset? _cursorPosition;
  bool _isHovering = false;
  late final AnimationController _unlockController;

  @override
  void initState() {
    super.initState();
    _unlockController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _unlockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.none, // 이 영역 안에서는 기본 커서 숨김
      onEnter: (_) {
        setState(() => _isHovering = true);
        _unlockController.forward();
      },
      onExit: (_) {
        setState(() {
          _isHovering = false;
          _cursorPosition = null;
        });
        _unlockController.reverse();
      },
      onHover: (event) {
        setState(() => _cursorPosition = event.localPosition);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          widget.child,

          // 열쇠구멍이 "열리는" 오버레이
          Positioned.fill(
            child: Center(
              child: AnimatedBuilder(
                animation: _unlockController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _unlockController.value,
                    child: Transform.rotate(
                      angle: _unlockController.value * 0.3,
                      child: const KeyholeIcon(
                        size: 40,
                        color: Color(0x33A73B2E), // 반투명 브릭레드
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // 마우스를 따라다니는 열쇠 커서
          if (_isHovering && _cursorPosition != null)
            Positioned(
              left: _cursorPosition!.dx - 12,
              top: _cursorPosition!.dy - 12,
              child: IgnorePointer(
                child: Transform.rotate(
                  angle: -0.5,
                  child: const Icon(
                    Icons.key,
                    size: 26,
                    color: Color(0xFFA73B2E),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
