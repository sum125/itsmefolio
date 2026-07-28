import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext c) => MediaQuery.of(c).size.width < 800;
  static EdgeInsets pagePadding(BuildContext c) => EdgeInsets.all(isMobile(c) ? 20 : 48);
}
