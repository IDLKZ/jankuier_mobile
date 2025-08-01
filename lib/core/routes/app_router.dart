import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/tasks/presentation/pages/tasks_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'tasks',
        builder: (context, state) => const TasksPage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
} 