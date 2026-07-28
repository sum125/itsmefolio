import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'router/app_router.dart';

void main() {
  usePathUrlStrategy();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(fontFamily: "ProductSans"),
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      // STEP 8-2(텍스트 드래그 선택)는 go_router 조합에서 Overlay 충돌이 발생해 보류.
      // 앱 정상 구동을 우선하고, 이 기능은 나중에 안전한 방식으로 다시 시도합니다.
    );
  }
}
