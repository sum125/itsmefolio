import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavItems extends StatelessWidget {
  final MainAxisAlignment alignment;
  const NavItems({super.key, this.alignment = MainAxisAlignment.center});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: alignment,
      spacing: 40,
      children: [
        _navItem(context, "Home", '/'),
        _navItem(context, "About", '/about'),
        _navItem(context, "Projects", '/projects'),
        _navItem(context, "Contact", '/contact'),
      ],
    );
  }

  // STEP 8-1: GestureDetector → Semantics + InkWell (키보드 포커스·스크린리더 대응)
  Widget _navItem(BuildContext context, String label, String path) {
    final String currentPath = GoRouterState.of(context).uri.toString();
    final bool isActive = path == '/' ? currentPath == '/' : currentPath.startsWith(path);

    return Semantics(
      button: true,
      label: '$label 페이지로 이동',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: InkWell(
          onTap: () => context.go(path),
          borderRadius: BorderRadius.circular(4),
          hoverColor: const Color(0x0DA73B2E),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isActive ? const Color(0xFFA73B2E) : const Color(0xFF1D1D1B),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
