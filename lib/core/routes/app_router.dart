import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/blog/presentation/pages/blog_page.dart';
import '../../features/profile/presentation/pages/edit_account_page.dart';
import '../../features/profile/presentation/pages/edit_password_page.dart';
import '../../features/services/presentation/pages/service_product_page.dart';
import '../../features/services/presentation/pages/service_section_page.dart';
import '../../features/tasks/presentation/pages/tasks_page.dart';
import '../../shared/widgets/main_navigation.dart';
import '../constants/app_route_constants.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const MainNavigation(),
      ),
      GoRoute(
        path: '/tasks',
        name: 'tasks',
        builder: (context, state) => const TasksPage(),
      ),
      GoRoute(
        path: AppRouteConstants.SingleProductPagePath,
        name: AppRouteConstants.SingleProductPageName,
        builder: (context, state) => const ServiceProductPage(),
      ),
      GoRoute(
        path: AppRouteConstants.ServiceSectionSinglePagePath,
        name: AppRouteConstants.ServiceSectionSinglePageName,
        builder: (context, state) => const ServiceSectionSinglePage(),
      ),
      GoRoute(
        path: AppRouteConstants.EditAccountPagePath,
        name: AppRouteConstants.EditAccountPageName,
        builder: (context, state) => const EditAccountPage(),
      ),
      GoRoute(
        path: AppRouteConstants.EditPasswordPagePath,
        name: AppRouteConstants.EditPasswordPageName,
        builder: (context, state) => const EditPasswordPage(),
      ),
      GoRoute(
        path: AppRouteConstants.BlogListPagePath,
        name: AppRouteConstants.BlogListPageName,
        builder: (context, state) => const BlogListPage(),
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
