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

  Widget _navItem(BuildContext context, String label, String path) {
    final String currentPath = GoRouterState.of(context).uri.toString();
    final bool isActive = path == '/' ? currentPath == '/' : currentPath.startsWith(path);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go(path),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isActive ? const Color(0xFFA73B2E) : const Color(0xFF1D1D1B),
          ),
        ),
      ),
    );
  }
}
