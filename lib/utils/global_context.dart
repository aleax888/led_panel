import 'package:flutter/material.dart';

/// A utility class that holds a global BuildContext and a GlobalKey for the NavigatorState, allowing access to the context and navigation from anywhere in the application.
class GlobalContext {
  GlobalContext._();

  static BuildContext? globalContext;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

}
