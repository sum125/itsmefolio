import 'package:flutter/material.dart';

class PrototypeItem {
  final String imagePath;
  final String caption;

  const PrototypeItem({required this.imagePath, required this.caption});
}

class PrototypeCarousel extends StatefulWidget {
  final List<PrototypeItem> items;
  final double height;
  final double? width;

  const PrototypeCarousel({
    super.key,
    required this.items,
    this.height = 420,
    this.width,
  });

  @override
  State<PrototypeCarousel> createState() => _PrototypeCarouselState();
}

class _PrototypeCarouselState extends State<PrototypeCarousel> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    if (index < 0 || index >= widget.items.length) return;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _arrowButton(
          icon: Icons.chevron_left,
          onTap: () => _goTo(_currentIndex - 1),
          enabled: _currentIndex > 0,
        ),
        const SizedBox(width: 20),
        Column(
          children: [
            Container(
              width: widget.width ?? widget.height * 1.3,
              height: widget.height,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFF1D1D1B), width: 1.4),
              ),
              child: ClipRect(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.items.length,
                  onPageChanged: (index) => setState(() => _currentIndex = index),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Image.asset(
                        widget.items[index].imagePath,
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '${(_currentIndex + 1).toString().padLeft(2, '0')} / ${widget.items.length.toString().padLeft(2, '0')}  —  ${widget.items[_currentIndex].caption}',
              style: const TextStyle(
                fontFamily: 'IBM Plex Mono',
                fontSize: 12,
                color: Color(0xFFA6A29B),
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
        _arrowButton(
          icon: Icons.chevron_right,
          onTap: () => _goTo(_currentIndex + 1),
          enabled: _currentIndex < widget.items.length - 1,
        ),
      ],
    );
  }

  Widget _arrowButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool enabled,
  }) {
    return MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: enabled ? const Color(0xFF1D1D1B) : const Color(0xFFDDDAD1),
              width: 1.4,
            ),
          ),
          child: Icon(
            icon,
            color: enabled ? const Color(0xFF1D1D1B) : const Color(0xFFDDDAD1),
          ),
        ),
      ),
    );
  }
}
