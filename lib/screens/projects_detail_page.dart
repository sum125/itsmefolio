import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_app/widget/page_header.dart';
import 'package:portfolio_app/widget/redefinition_mark.dart';
import 'package:portfolio_app/widget/spec_table.dart';
import 'package:portfolio_app/widget/story_section.dart';
import 'package:portfolio_app/widget/key_moment.dart';
import 'package:portfolio_app/widget/section_nav_dots.dart';
import 'package:portfolio_app/widget/prototype_carousel.dart';
import 'package:portfolio_app/widget/prev_next_project_nav.dart';
import 'package:portfolio_app/widget/process_flow.dart';
import 'package:portfolio_app/widget/question_flow.dart';

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
      final distance = (position - 120).abs();

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

  // 프로젝트별 콘텐츠 데이터
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
      'process': null,
      'journeyStages': null,
      'activeJourneyIndices': null,
      'interviewQuestions': null,
      'pivot':
          '처음엔 \'에너지 상태\'를 분석 축으로 잡았습니다. 그런데 에너지는 그날그날 바뀌는 값이라, 같은 사람도 측정 시점에 따라 다른 답을 낼 수 있었습니다. 이대로면 노이즈를 성향으로 오독할 위험이 있다고 판단해, Self-Regulatory Theory의 promotion/prevention 성향으로 축을 바꿨습니다 — 상태보다 훨씬 안정적으로 유지되는 변수였습니다.',
      'decision':
          '축을 바꾸고 나서야 진짜 패턴이 보였습니다. promotion 성향은 개방형을, prevention 성향은 가이드형을 선호했습니다. 하지만 구조와 무관하게 맥락을 계속 다시 요구받으면 누구든 피로해져 이탈했습니다. 좋은 가이드의 전제는 형식이 아니라 맥락 파악 여부라는 결론을 내렸고, 하이브리드 인터랙션 구조에 \'이해한 맥락을 확인하는 질문\' 시스템을 결합하는 개선안으로 이어졌습니다.',
      'retrospective':
          '문제를 인터랙션 형태(가이드형 vs 개방형)로 두면 답이 안 나온다는 걸 배웠습니다. \'맥락 반영 실패의 반복\'이라는 하나의 변수로 수렴시키고 나서야 개선안이 명확해졌습니다. 사람이 왜 대화를 멈추는지, 그 이유를 끝까지 좁혀가는 과정 자체가 흥미로웠던 프로젝트입니다.',
      'prototypes': [
        {
          'image': 'assets/mental_entry.png',
          'caption': '진입 단계 — 진행 시점 선택권 추가',
        },
        {
          'image': 'assets/mental_emotion.png',
          'caption': '대화 진행 단계 — 맥락 확인 질문(감정 칩) 시스템',
        },
        {
          'image': 'assets/mental_finish.png',
          'caption': '마무리 단계 — 종결 시점의 선택권',
        },
      ],
      'outcomes': [
        {'image': 'assets/outcome_chatbot_01.png', 'caption': '최종 보고서 표지'},
      ],
    },
    'lgsuite': {
      'sku': 'RESEARCH NO. 02',
      'title': '액티브 시니어 여행 경험에 스며드는 제품 설계 리서치',
      'summary':
          '네이버 카페·블로그 15,000건 이상의 텍스트를 분석해 액티브 시니어의 여행 행동을 클러스터링했고, 제품을 전면에 내세우는 대신 사용자의 실제 여행 경험 안에 자연스럽게 스며드는 방식으로 서비스를 설계했습니다.',
      'original': 'LG 가전을 어떻게 더 많이 체험시킬 것인가',
      'redefined': '가전을 보여주는 대신, 고객의 여행이라는 경험 안에 어떻게 스며들 수 있는가',
      'specs': {
        '표본': '네이버 카페·블로그 15,000건+',
        '방법론': 'SBERT 임베딩 · UMAP · KMeans 클러스터링',
        '도구': 'OKT 형태소 · ngram(2-3) · TF-IDF · LDA',
      },
      'methodReason':
          '인스타그램이 아니라 네이버 카페·블로그를 택한 이유는, 액티브 시니어가 여행 경험을 짧은 이미지가 아니라 긴 서술형 텍스트로 남기는 채널이었기 때문입니다. 감정과 페인포인트가 문장에 담기는 곳이라 SBERT·LDA 기반 분석에 적합하다고 판단했습니다.',
      'process': [
        {
          'title': '크롤링할 곳 선정',
          'description':
              '액티브 시니어가 여행 경험을 길게 서술하는 채널이 어디인지부터 판단했습니다. 짧은 이미지 위주인 인스타그램 대신, 감정과 맥락이 문장에 담기는 네이버 카페·블로그를 선택했습니다.',
        },
        {
          'title': '1차 크롤링 진행',
          'description': '여행 후기 게시글 15,000건 이상을 수집했습니다.',
        },
        {
          'title': '핵심 키워드 도출',
          'description': 'OKT 형태소 분석과 ngram(2-3)으로 의미 있는 복합어를 추출해, 어떤 언어가 반복적으로 나타나는지 먼저 확인했습니다.',
        },
        {
          'title': '2차 크롤링 진행',
          'description': '1차 키워드에서 드러난 맥락을 더 깊이 확인하기 위해, 관련성이 높은 게시글을 추가로 수집했습니다.',
        },
        {
          'title': 'Actor-Action 분석',
          'description': '누가(Actor) 무엇을(Action) 했는지를 문서 단위로 구조화해, 단순 키워드 빈도가 아니라 행동 패턴으로 데이터를 다시 읽었습니다.',
        },
        {
          'title': '페르소나 도출',
          'description':
              'SBERT 임베딩과 KMeans로 3개 Actor 클러스터를 나눴고, 체력·완주 의지·프리미엄 숙소 예약 패턴이 동시에 나타난 클러스터를 핵심 페르소나로 선정했습니다.',
        },
        {
          'title': '사용자 경험 데이터 분석',
          'description': '이 페르소나가 여행 중 실제로 겪는 경험의 흐름 — 피로가 쌓이는 시점, 판단이 흔들리는 순간 — 을 데이터에서 재구성했습니다.',
        },
        {
          'title': '데이터 기반 솔루션 도출',
          'description': '그 여정에서 제품이 자연스럽게 개입할 수 있는 지점을 찾아, 제품을 경험의 중심이 아니라 경험 안에 스며드는 요소로 설계했습니다.',
        },
      ],
      'journeyStages': null,
      'activeJourneyIndices': null,
      'interviewQuestions': null,
      'pivot':
          '처음엔 데이터부터 모으면 답이 나올 거라 생각해 크롤링부터 시작했습니다. 그런데 무엇을 수집해야 할지조차 명확하지 않다는 걸 깨닫고, 타겟 특성부터 먼저 정의하는 순서로 전체를 다시 짰습니다. 그렇게 도출한 3개 Actor 클러스터 중에서도, 체력·컨디션 언급 빈도가 가장 높고 완주 의지와 불안이 동시에 나타나며 프리미엄 숙소를 직접 예약하는 패턴을 보인 클러스터 하나를 핵심 페르소나로 선정했습니다.',
      'decision':
          '\'체력 때문에 일정을 포기한다\'는 데이터 패턴 하나를 \'여행 완주 컨디션\'이라는 서비스 가치로 바꿔 제안했습니다. 가전을 전면에 내세우지 않고, 사용자가 여행이라는 경험을 완주하도록 돕는 배경으로 설계했습니다.',
      'retrospective':
          '데이터는 질문이 먼저 있을 때에만 방향이 된다는 걸 배웠습니다. 그리고 좋은 제품 경험은 제품이 두드러지는 게 아니라, 사용자가 원래 하려던 일 안에 자연스럽게 녹아있을 때 만들어진다는 것도 이 프로젝트에서 배운 것입니다.',
      'prototypes': null,
      'outcomes': [
        {'image': 'assets/outcome_lgsuite_01.png', 'caption': 'Actor 클러스터 시각화'},
      ],
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
      'process': null,
      'journeyStages': ['입사', '적응・성장', '휴식과 일상', '성장 동기부여', '퇴직'],
      'activeJourneyIndices': [2, 3],
      'interviewQuestions': [
        {
          'stage': '휴식과 일상',
          'question': '운영 중인 복지 제도에는 어떤 것들이 있는지 간단히 소개해주실 수 있을까요?',
          'answer':
              '대학원 무료 지원, 자녀 학자금, 건강검진, 대출·전자제품 할인 등 혜택은 많다. 하지만 역량강화교육 같은 자기개발 관련 복지는 "학교에서 열어줄 테니 알아서 들어라" 수준이고, 이를 지원하는 금전적 지원은 없다. 제도들이 따로 놀아서 한 분야 전문가로 성장할 수 있는 트랙이 부재하다.',
        },
        {
          'stage': '성장 동기부여',
          'question': '업무 성과에 대해서는 보통 어떤 방식으로 인정이나 보상이 이루어지나요?',
          'answer':
              '직무의 가치를 평가해 성과에 따라 보상하는 시스템이 부족하고, 기존 호봉제만으로는 업무 동기부여가 어렵다. 전문가로 성장할 수 있는 트랙(박사 학위, 해외 파견, 교환 프로그램 등)이 확대되었으면 좋겠다는 바람이 있다.',
        },
      ],
      'pivot':
          '제도가 잘 갖춰진 조직이라도 구성원의 몰입도가 늘 높지는 않았습니다. 분석해보니 몰입을 가르는 건 제도 자체가 아니라, 그 제도 밖에서 일어나는 실제 관계 경험이었습니다. 조직이 설계한 것과 구성원이 실제로 겪는 것 사이엔 예상보다 뚜렷한 간극이 있었습니다.',
      'decision':
          '몰입은 \'자신의 기여가 인정받는 순간\'에서 생긴다는 인사이트를 바탕으로, 피드백 구조 강화와 기여를 명확히 전달하는 장치, 초기 적응 경험 개선을 제안했습니다. 특히 자기개발 지원 체계가 비어있다는 발견을 바탕으로 HUFS Global Growth Point(GGP)라는 자기주도 학습 포인트 제도를 설계했습니다.',
      'retrospective':
          '경험을 분석할 때는 분석 기준을 먼저 명확히 세우는 것이 결과의 신뢰도를 결정한다는 걸 배웠습니다. 제품이 없어도, 사람이 겪는 흐름이 있는 곳이면 같은 방법론이 통한다는 것도 이 프로젝트에서 확인했습니다.',
      'prototypes': null,
      'outcomes': [
        {'image': 'assets/apply.png', 'caption': '시범운영 신청서 양식(IDP) 설계'},
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    final data = _data[widget.projectId];

    if (data == null) {
      return const Scaffold(
        body: Center(child: Text('존재하지 않는 프로젝트입니다')),
      );
    }

    final List<String> ids = _data.keys.toList();
    final int currentIndex = ids.indexOf(widget.projectId);
    final String prevId = ids[(currentIndex - 1 + ids.length) % ids.length];
    final String nextId = ids[(currentIndex + 1) % ids.length];
    final Map<String, dynamic> prevData = _data[prevId]!;
    final Map<String, dynamic> nextData = _data[nextId]!;

    final List<dynamic>? prototypes = data['prototypes'];
    final List<dynamic>? outcomes = data['outcomes'];
    final List<dynamic>? process = data['process'];
    final List<dynamic>? journeyStages = data['journeyStages'];

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3EF),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // PageHeader — 화면 전체 너비 기준 (다른 페이지들과 위치 통일)
                const PageHeader(label: 'PROJECT'),
                const SizedBox(height: 60),

                // 본문만 720px로 제한 + 가운데 정렬
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 720),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 0. 요약
                        Container(key: _sectionKeys[0], child: const SizedBox()),
                        Text(
                          data['sku'],
                          style: const TextStyle(
                            fontFamily: 'IBM Plex Mono',
                            fontSize: 11,
                            color: Color(0xFFA73B2E),
                          ),
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
                        RedefinitionMark(
                          original: data['original'],
                          redefined: data['redefined'],
                        ),
                        const SizedBox(height: 32),

                        // 2. 방법
                        Container(key: _sectionKeys[2], child: const SizedBox()),
                        SpecTable(specs: Map<String, String>.from(data['specs'])),
                        const SizedBox(height: 12),
                        StorySection(
                          heading: 'WHY THIS METHOD',
                          body: data['methodReason'],
                        ),
                        const SizedBox(height: 32),

                        // 인터뷰 여정 흐름 — org 전용
                        if (journeyStages != null) ...[
                          QuestionFlow(
                            journeyStages: List<String>.from(journeyStages),
                            activeIndices: List<int>.from(data['activeJourneyIndices']),
                            steps: (data['interviewQuestions'] as List)
                                .map(
                                  (q) => QuestionStep(
                                    stage: q['stage'] as String,
                                    question: q['question'] as String,
                                    answer: q['answer'] as String?, // ← 이 줄 추가
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 32),
                        ],

                        // 프로세스 파이프라인 — lgsuite 전용
                        if (process != null) ...[
                          const Text(
                            'PROCESS',
                            style: TextStyle(
                              fontFamily: 'IBM Plex Mono',
                              fontSize: 11,
                              color: Color(0xFFA73B2E),
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ProcessFlow(
                            steps: process
                                .map(
                                  (p) => ProcessStep(
                                    title: p['title'] as String,
                                    description: p['description'] as String,
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 48),
                        ] else
                          const SizedBox(height: 16),

                        // 3. 발견 — 열쇠 마커
                        Container(key: _sectionKeys[3], child: const SizedBox()),
                        KeyMoment(body: data['pivot']),
                        const SizedBox(height: 48),

                        // 4. 결정
                        Container(key: _sectionKeys[4], child: const SizedBox()),
                        StorySection(
                          heading: 'INSIGHT TO DECISION',
                          body: data['decision'],
                        ),
                        const SizedBox(height: 32),

                        // 프로토타입 — chatbot 전용
                        if (prototypes != null && prototypes.isNotEmpty) ...[
                          PrototypeCarousel(
                            items: prototypes
                                .map(
                                  (p) => PrototypeItem(
                                    imagePath: p['image'] as String,
                                    caption: p['caption'] as String,
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 40),
                        ],

                        // 결과물 갤러리 — 데이터에 있을 때만
                        if (outcomes != null && outcomes.isNotEmpty) ...[
                          const Text(
                            'OUTCOME',
                            style: TextStyle(
                              fontFamily: 'IBM Plex Mono',
                              fontSize: 11,
                              color: Color(0xFFA73B2E),
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 20),
                          PrototypeCarousel(
                            items: outcomes
                                .map(
                                  (o) => PrototypeItem(
                                    imagePath: o['image'] as String,
                                    caption: o['caption'] as String,
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 48),
                        ],

                        // 5. 회고
                        Container(key: _sectionKeys[5], child: const SizedBox()),
                        StorySection(
                          heading: 'RETROSPECTIVE',
                          body: data['retrospective'],
                        ),
                        const SizedBox(height: 40),

                        // 이전/다음 프로젝트
                        PrevNextProjectNav(
                          prevTitle: prevData['title'],
                          nextTitle: nextData['title'],
                          onTapPrev: () => context.go('/projects/$prevId'),
                          onTapNext: () => context.go('/projects/$nextId'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
