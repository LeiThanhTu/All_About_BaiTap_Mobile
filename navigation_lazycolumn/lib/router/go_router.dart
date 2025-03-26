import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/root_screen.dart';
import '../screens/list_screen.dart';
import '../screens/detail_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => RootScreen()),
    GoRoute(path: '/list', builder: (context, state) => ListScreen()),
    GoRoute(
      path: '/detail',
      builder: (context, state) => DetailScreen(text: state.extra as String),
    ),
  ],
);
