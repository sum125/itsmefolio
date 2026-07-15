import 'package:flutter/material.dart';
import 'package:portfolio_app/widget/page_header.dart';
import 'package:portfolio_app/widget/redefinition_mark.dart';
import 'package:portfolio_app/widget/spec_table.dart';
import 'package:portfolio_app/widget/story_section.dart';
import 'package:portfolio_app/widget/key_moment.dart';
import 'package:portfolio_app/widget/section_nav_dots.dart';

class ProjectsDetailPage extends StatefulWidget {
  final String projectId;
  const ProjectsDetailPage({super.key, required this.projectId});

  @override
  State<ProjectsDetailPage> createState() => _ProjectsDetailPageState();
}

class _ProjectsDetailPageState extends State<ProjectsDetailPage> {
  final ScrollController _scrollController = ScrollController();
  int _activeSection = 0;

  final List<String> _sectionLabels = [
    '요약',
    '재정의',
    '방법',
    '발견',
    '결정',
    '회고',
  ];
  final List<GlobalKey> _sectionKeys = List.generate(6, (_) => GlobalKey());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateActiveSection);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateActiveSection);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateActiveSection() {
    int closestIndex = 0;
    double closestDistance = double.infinity;

    for (int i = 0; i < _sectionKeys.length; i++) {
      final ctx = _sectionKeys[i].currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox;
      final position = box.localToGlobal(Offset.zero).dy;
      final distance = (position - 120).abs(); // 화면 상단 기준점

      if (position <= 150 && distance < closestDistance) {
        closestDistance = distance;
        closestIndex = i;
      }
    }

    if (closestIndex != _activeSection) {
      setState(() => _activeSection = closestIndex);
    }
  }

  void _jumpTo(int index) {
    final ctx = _sectionKeys[index].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  static const Map<String, Map<String, dynamic>> _data = {
    'chatbot': {
      'sku': 'RESEARCH NO. 01',
      'title': 'AI 멘탈케어 챗봇 인터랙션 분석',
      'summary': '가이드형과 개방형 인터랙션을 비교하며 선호와 이탈 원인을 분리했고, 두 구조 모두에서 반복되는 이탈의 진짜 원인이 맥락 파악 실패에 있다는 것을 발견했습니다.',
      'original': '가이드형과 개방형, 어떤 인터랙션이 더 나은가',
      'redefined': '구조와 무관하게, 사용자는 언제 맥락을 잃고 이탈하는가',
      'specs': {
        '기간': '4주 (+ 논문 보강 1주)',
        '표본': '스크리닝 60명 · 심층인터뷰 20명 (초기 22명·8명에서 확대)',
        '방법론': 'Sequential Monadic',
      },
      'methodReason':
          '가이드형과 개방형을 다른 사람에게 각각 보여주면 응답자 성향 차이가 결과에 섞여버립니다. 같은 사람이 두 인터랙션을 순차 체험하게 해서, 두 번째 경험에서 드러나는 미세한 불편과 상대적 체감 차이를 포착하는 방법을 택했습니다. 초기 22명, 8명이었던 표본은 성향별로 패턴이 갈리는 걸 확인한 뒤, 확신을 위해 60명, 20명까지 넓혔습니다.',
      'pivot':
          '처음엔 \'에너지 상태\'를 분석 축으로 잡았습니다. 그런데 에너지는 그날그날 바뀌는 값이라, 같은 사람도 측정 시점에 따라 다른 답을 낼 수 있었습니다. 이대로면 노이즈를 성향으로 오독할 위험이 있다고 판단해, Self-Regulatory Theory의 promotion/prevention 성향으로 축을 바꿨습니다 — 상태보다 훨씬 안정적으로 유지되는 변수였습니다.',
      'decision':
          '축을 바꾸고 나서야 진짜 패턴이 보였습니다. promotion 성향은 개방형을, prevention 성향은 가이드형을 선호했습니다. 하지만 구조와 무관하게 맥락을 계속 다시 요구받으면 누구든 피로해져 이탈했습니다. 좋은 가이드의 전제는 형식이 아니라 맥락 파악 여부라는 결론을 내렸고, 하이브리드 인터랙션 구조에 \'이해한 맥락을 확인하는 질문\' 시스템을 결합하는 개선안으로 이어졌습니다.',
      'retrospective':
          '문제를 인터랙션 형태(가이드형 vs 개방형)로 두면 답이 안 나온다는 걸 배웠습니다. \'맥락 반영 실패의 반복\'이라는 하나의 변수로 수렴시키고 나서야 개선안이 명확해졌습니다. 팀 안에서 이 결과를 공유하는 것도 설득이 아니라, 기록 기준을 하나로 맞추는 정렬의 문제였습니다.',
    },
    'audiobook': {
      'sku': 'RESEARCH NO. 02',
      'title': '요약형 오디오북 UX 비교 분석',
      'summary':
          '밀리의 서재와 Blinkist를 비교하기 전, 두 서비스가 같은 카테고리가 아니라는 문제부터 제기했습니다. 비교 범주를 요약형 오디오북으로 통일한 뒤에야 전략 차이를 제대로 볼 수 있었습니다.',
      'original': '밀리의 서재와 Blinkist, 어느 쪽 오디오북 경험이 더 나은가',
      'redefined': '요약형 오디오북이라는 같은 조건에서, 두 서비스는 이탈과 몰입을 어떻게 다르게 설계했는가',
      'specs': {
        '기간': '(확인 필요)',
        '대상': '밀리의 서재 · Blinkist',
        '방법론': '[진입–사용–앱 자체] 3단계 비교 프레임',
      },
      'methodReason':
          'Blinkist는 요약형에 특화된 서비스지만, 밀리의 서재는 완독형과 요약형이 섞여 있었습니다. 이 상태로 비교하면 어느 차이가 카테고리 때문인지, 서비스 설계 때문인지 구분할 수 없다고 판단해 비교 범주를 요약형으로 좁히자고 팀에 제안했습니다. 같은 지점(진입, 사용, 앱 자체)에서 두 서비스를 나란히 놓고 비교하는 프레임을 짰습니다 — 기능을 나열하면 정작 중요한 차이가 묻히기 때문입니다.',
      'pivot':
          '팀 안에서 처음엔 전체 오디오북 경험으로 비교하자는 의견이 있었습니다. 그렇게 하면 결론이 \'카테고리가 다르니 다르다\'는 뻔한 이야기로 끝날 위험이 있다고 판단해, 비교 조건을 통일해야 진짜 전략 차이가 보인다고 팀을 설득했습니다.',
      'decision': '(실제 이탈 지점·몰입 전략 차이를 여기에 채워주시면 이 섹션이 훨씬 강해져요)',
      'retrospective': '비교 분석은 무엇을 비교할지 정하는 순간 이미 절반이 결정된다는 걸 배웠습니다. 조건을 통일하지 않으면 아무리 정교하게 비교해도 해석이 흔들립니다.',
    },
    'org': {
      'sku': 'RESEARCH NO. 03',
      'title': '조직경험(Employee Experience) 분석',
      'summary': '조직 문화를 만족도 조사로 접근하지 않기로 결정하고, 구성원의 실제 경험 흐름을 인터뷰로 재구성해 조직 경험이 형성되는 지점을 분석했습니다.',
      'original': '구성원들은 조직 생활에 얼마나 만족하는가',
      'redefined': '구성원은 입사부터 지금까지 어떤 경험 흐름을 지나왔고, 그 흐름의 어디서 몰입이 생기고 어디서 단절되는가',
      'specs': {
        '기간': '4~5주 (주당 5~8시간)',
        '방법론': '반구조화 인터뷰 · 경험 흐름 재구성',
        '흐름': '입사 → 적응 → 관계형성 → 업무경험 → 몰입',
      },
      'methodReason':
          '만족도 점수는 왜 그런 점수가 나왔는지 설명하지 못한다고 판단했습니다. 그래서 의견이 아니라 실제로 있었던 경험 사례를 말하게 하는 질문으로 인터뷰를 설계했습니다. 같은 기준으로 정리해야 패턴이 보이니, 경험을 긍정/부정으로 나누고 흐름 순서로 재배열하는 정리 방식을 만들었습니다.',
      'pivot':
          '제도가 잘 갖춰진 조직이라도 구성원의 몰입도가 늘 높지는 않았습니다. 분석해보니 몰입을 가르는 건 제도 자체가 아니라, 그 제도 밖에서 일어나는 실제 관계 경험이었습니다. 조직이 설계한 것과 구성원이 실제로 겪는 것 사이엔 예상보다 뚜렷한 간극이 있었습니다.',
      'decision': '몰입은 \'자신의 기여가 인정받는 순간\'에서 생긴다는 인사이트를 바탕으로, 피드백 구조 강화와 기여를 명확히 전달하는 장치, 초기 적응 경험 개선을 제안했습니다.',
      'retrospective':
          '경험을 분석할 때는 분석 기준을 먼저 명확히 세우는 것이 결과의 신뢰도를 결정한다는 걸 배웠습니다. 다음엔 인터뷰 데이터를 코딩하고 정량 데이터와 결합해 더 체계적으로 검증하고 싶습니다.',
    },
  };

  @override
  Widget build(BuildContext context) {
    final data = _data[widget.projectId];
    if (data == null) {
      return const Scaffold(body: Center(child: Text('존재하지 않는 프로젝트입니다')));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3EF),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(48),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PageHeader(label: 'PROJECT'),
                    const SizedBox(height: 60),

                    // 0. 요약
                    Container(key: _sectionKeys[0], child: const SizedBox()),
                    Text(
                      data['sku'],
                      style: const TextStyle(fontFamily: 'IBM Plex Mono', fontSize: 11, color: Color(0xFFA73B2E)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      data['title'],
                      style: const TextStyle(
                        fontFamily: 'Gowun Batang',
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: Color(0xFF1D1D1B),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      data['summary'],
                      style: const TextStyle(
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        height: 1.7,
                        color: Color(0xFF1D1D1B),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // 1. 재정의
                    Container(key: _sectionKeys[1], child: const SizedBox()),
                    RedefinitionMark(original: data['original'], redefined: data['redefined']),
                    const SizedBox(height: 32),

                    // 2. 방법
                    Container(key: _sectionKeys[2], child: const SizedBox()),
                    SpecTable(specs: Map<String, String>.from(data['specs'])),
                    const SizedBox(height: 12),
                    StorySection(heading: 'WHY THIS METHOD', body: data['methodReason']),
                    const SizedBox(height: 48),

                    // 3. 발견 — 열쇠 마커
                    Container(key: _sectionKeys[3], child: const SizedBox()),
                    KeyMoment(body: data['pivot']),
                    const SizedBox(height: 48),

                    // 4. 결정
                    Container(key: _sectionKeys[4], child: const SizedBox()),
                    StorySection(heading: 'INSIGHT TO DECISION', body: data['decision']),
                    const SizedBox(height: 40),

                    // 5. 회고
                    Container(key: _sectionKeys[5], child: const SizedBox()),
                    StorySection(heading: 'RETROSPECTIVE', body: data['retrospective']),
                  ],
                ),
              ),
            ),
          ),
          // 우측 고정 섹션 내비게이션
          Positioned(
            right: 32,
            top: 0,
            bottom: 0,
            child: Center(
              child: SectionNavDots(
                labels: _sectionLabels,
                activeIndex: _activeSection,
                onTapDot: _jumpTo,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
