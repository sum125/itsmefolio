import 'package:flutter/material.dart';

class SpecTable extends StatelessWidget {
  final Map<String, String> specs; // 예: {'기간': '4주', '표본': '스크리닝 60명'}

  const SpecTable({super.key, required this.specs});

  @override
  Widget build(BuildContext context) {
    final entries = specs.entries.toList();
    return Column(
      children: List.generate(entries.length, (index) {
        final isFirst = index == 0;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: isFirst
                ? null
                : const Border(
                    top: BorderSide(color: Color(0xFFDDDAD1), width: 0.5),
                  ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                entries[index].key,
                style: const TextStyle(
                  fontFamily: 'Noto Sans KR',
                  fontSize: 12,
                  color: Color(0xFFA6A29B),
                ),
              ),
              Text(
                entries[index].value,
                style: const TextStyle(
                  fontFamily: 'IBM Plex Mono',
                  fontSize: 12,
                  color: Color(0xFF1D1D1B),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
