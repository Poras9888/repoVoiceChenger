import 'package:flutter/material.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class App extends StatelessWidget {
  final GlobalKey<NavigatorState>? navigatorKey;

  const App({super.key, this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Voice Changer & Sound Effects Recorder',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
    );
  }
}
