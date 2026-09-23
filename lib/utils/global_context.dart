import 'package:flutter/material.dart';

class GlobalContext {
  GlobalContext._();

  static BuildContext? globalContext;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

}
