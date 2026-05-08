import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/home/presentation/screens/home_screen.dart';

class NustOneApp extends StatelessWidget {
  const NustOneApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
      ],
    );

    return MaterialApp.router(
      title: 'NUST One',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
