import 'package:flutter/material.dart';

class QuestionStep {
  final String stage;
  final String question;
  final String? answer;
  const QuestionStep({
    required this.stage,
    required this.question,
    this.answer,
  });
}

class QuestionFlow extends StatelessWidget {
  final List<String> journeyStages;
  final List<int> activeIndices;
  final List<QuestionStep> steps;

  const QuestionFlow({
    super.key,
    required this.journeyStages,
    required this.activeIndices,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 전체 여정 진행 바 — 활성 구간만 브릭레드
        Row(
          children: List.generate(journeyStages.length, (index) {
            final bool isActive = activeIndices.contains(index);
            final bool isFirst = index == 0;
            final bool isLast = index == journeyStages.length - 1;
            final bool prevActive = !isFirst && activeIndices.contains(index - 1);

            return Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1.5,
                          color: isFirst
                              ? Colors.transparent
                              : (isActive || prevActive)
                              ? const Color(0xFFA73B2E)
                              : const Color(0xFFDDDAD1),
                        ),
                      ),
                      Container(
                        width: 18,
                        height: 18,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive ? const Color(0xFFA73B2E) : const Color(0xFFF3F3EF),
                          border: Border.all(
                            color: isActive ? const Color(0xFFA73B2E) : const Color(0xFFDDDAD1),
                            width: 1.2,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1.5,
                          color: isLast
                              ? Colors.transparent
                              : isActive
                              ? const Color(0xFFA73B2E)
                              : const Color(0xFFDDDAD1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    journeyStages[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'IBM Plex Mono',
                      fontSize: 10,
                      color: isActive ? const Color(0xFFA73B2E) : const Color(0xFFC7C4BC),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        const SizedBox(height: 12),

        const Text(
          'GGP 관련 발견은 아래 지점의 질문에서 나왔습니다',
          style: TextStyle(
            fontFamily: 'Noto Sans KR',
            fontWeight: FontWeight.w300,
            fontSize: 11,
            color: Color(0xFFA6A29B),
          ),
        ),
        const SizedBox(height: 20),

        // 활성 단계의 실제 질문 + 답변
        ...List.generate(steps.length, (index) {
          final bool isLast = index == steps.length - 1;
          final step = steps[index];
          return Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFDDDAD1)),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFA73B2E), width: 1),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          step.stage,
                          style: const TextStyle(
                            fontFamily: 'IBM Plex Mono',
                            fontSize: 9,
                            color: Color(0xFFA73B2E),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          '“${step.question}”',
                          style: const TextStyle(
                            fontFamily: 'Noto Sans KR',
                            fontStyle: FontStyle.italic,
                            fontSize: 13,
                            height: 1.6,
                            color: Color(0xFF1D1D1B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (step.answer != null) ...[
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 62),
                      child: Text(
                        step.answer!,
                        style: const TextStyle(
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w300,
                          fontSize: 12.5,
                          height: 1.7,
                          color: Color(0xFFA6A29B),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
