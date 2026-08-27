import 'package:e_shop/features/discovery_feed/presentation/pages/discovery_feed_page.dart';
import 'package:flutter/material.dart';
import 'app_theme.dart';

class EShopApp extends StatelessWidget {
  const EShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Shop',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: DiscoveryFeedScreen(),
    );
  }
}