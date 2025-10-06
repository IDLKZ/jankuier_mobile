import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jankuier_mobile/core/constants/app_constants.dart';
import 'package:jankuier_mobile/core/constants/ticketon_api_constants.dart';
import 'package:jankuier_mobile/core/di/injection.dart';
import 'package:jankuier_mobile/features/auth/presentation/pages/sign_in_page.dart';
import 'package:jankuier_mobile/features/auth/presentation/pages/sign_up_page.dart';
import 'package:jankuier_mobile/features/auth/presentation/pages/enter_phone_page.dart';
import 'package:jankuier_mobile/features/auth/presentation/pages/verify_code_page.dart';
import 'package:jankuier_mobile/features/auth/data/entities/user_verification_entity.dart';
import 'package:jankuier_mobile/features/booking_field_party/presentation/pages/my_booking_field_parties_page.dart';
import 'package:jankuier_mobile/features/cart/presentation/pages/my_cart_page.dart';
import 'package:jankuier_mobile/features/game/presentation/pages/game_page.dart';
import 'package:jankuier_mobile/features/home/presentation/pages/home_page.dart';
import 'package:jankuier_mobile/features/kff/presentation/pages/kff_matches_page.dart';
import 'package:jankuier_mobile/features/kff_league/presentation/pages/kff_league_club_page.dart';
import 'package:jankuier_mobile/features/local_auth/presentations/refresh_token_via_local_auth_page.dart';
import 'package:jankuier_mobile/features/local_auth/presentations/reload_pin_code_page.dart';
import 'package:jankuier_mobile/features/notifications/presentation/pages/my_notification_page.dart';
import 'package:jankuier_mobile/features/product_order/presentation/pages/product_order_details_page.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/full_product_detail/full_product_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/full_product_detail/full_product_detail_state.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/full_product_detail/full_product_event.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/get_full_academy_detail/get_full_academy_detail_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/get_full_academy_detail/get_full_academy_detail_event.dart';
import 'package:jankuier_mobile/features/standings/presentation/pages/standings_page.dart';
import 'package:jankuier_mobile/features/ticket/presentation/bloc/shows/ticketon_bloc.dart';
import 'package:jankuier_mobile/features/ticket/presentation/pages/tickets_page.dart';
import '../../features/activity/presentation/pages/activity_page.dart';
import '../../features/blog/presentation/pages/blog_page.dart';
import '../../features/countries/presentation/pages/countries_page.dart';
import '../../features/local_auth/domain/repository/local_auth_interface.dart';
import '../../features/local_auth/presentations/set_first_time_local_auth_page.dart';
import '../../features/matches/presentation/pages/matches_page.dart';
import '../../features/product_order/presentation/bloc/get_my_product_order_by_id/get_my_product_order_by_id_bloc.dart';
import '../../features/product_order/presentation/bloc/get_my_product_order_by_id/get_my_product_order_by_id_event.dart';
import '../../features/product_order/presentation/pages/my_orders_page.dart';
import '../../features/profile/presentation/pages/edit_account_page.dart';
import '../../features/profile/presentation/pages/edit_password_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/services/presentation/pages/service_product_page.dart';
import '../../features/services/presentation/pages/service_section_page.dart';
import '../../features/services/presentation/pages/services_page.dart';
import '../../features/standings/data/entities/match_entity.dart';
import '../../features/tasks/presentation/pages/tasks_page.dart';
import '../../features/ticket/domain/parameters/ticketon_get_shows_parameter.dart';
import '../../features/ticket/presentation/bloc/shows/ticketon_event.dart';
import '../../features/tournament/presentation/pages/tournament_selection_page.dart';
import '../../features/welcome/presentation/pages/welcome_video_page.dart';
import '../../shared/widgets/main_navigation.dart';
import '../constants/app_route_constants.dart';
import 'app_route_middleware.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRouteConstants.WelcomePagePath,
    routes: [
      // Welcome video page (outside shell to show fullscreen)
      GoRoute(
        path: AppRouteConstants.WelcomePagePath,
        name: AppRouteConstants.WelcomePageName,
        builder: (context, state) => const WelcomeVideoPage(),
      ),
      GoRoute(
        path: AppRouteConstants.SignInPagePath,
        name: AppRouteConstants.SignInPageName,
        builder: (context, state) => const SignInPage(),
        redirect: (BuildContext context, GoRouterState state) async {
          return await AppRouteMiddleware()
              .checkGuestMiddleware(context, state);
        },
      ),
      GoRoute(
        path: AppRouteConstants.SignUpPagePath,
        name: AppRouteConstants.SignUpPageName,
        builder: (context, state) => const SignUpPage(),
        redirect: (BuildContext context, GoRouterState state) async {
          return await AppRouteMiddleware()
              .checkGuestMiddleware(context, state);
        },
      ),
      GoRoute(
        path: AppRouteConstants.EnterPhonePagePath,
        name: AppRouteConstants.EnterPhonePageName,
        builder: (context, state) {
          final phone = state.uri.queryParameters['phone'];
          return EnterPhonePage(phone: phone);
        },
        redirect: (BuildContext context, GoRouterState state) async {
          return await AppRouteMiddleware()
              .checkGuestMiddleware(context, state);
        },
      ),
      GoRoute(
        path: AppRouteConstants.VerifyCodePagePath,
        name: AppRouteConstants.VerifyCodePageName,
        builder: (context, state) {
          final phone = state.uri.queryParameters['phone'] ?? '';
          final verificationResult =
              state.extra as UserCodeVerificationResultEntity;
          return VerifyCodePage(
            phone: phone,
            verificationResult: verificationResult,
          );
        },
        redirect: (BuildContext context, GoRouterState state) async {
          return await AppRouteMiddleware()
              .checkGuestMiddleware(context, state);
        },
      ),
      GoRoute(
        path: AppRouteConstants.MyFirstLocalAuthPagePath,
        name: AppRouteConstants.MyFirstLocalAuthPageName,
        builder: (context, state) => const SetFirstTimeLocalAuthTypePage(),
        redirect: (BuildContext context, GoRouterState state) async {
          return await AppRouteMiddleware()
              .setLocalAuthBefore(context, state, getIt<LocalAuthInterface>());
        },
      ),
      GoRoute(
        path: AppRouteConstants.RefreshTokenViaLocalAuthPagePath,
        name: AppRouteConstants.RefreshTokenViaLocalAuthPageName,
        builder: (context, state) => const RefreshTokenViaLocalAuthPage(),
        redirect: (BuildContext context, GoRouterState state) async {
          return await AppRouteMiddleware().refreshAuthTokenViaLocalAuth(
              context, state, getIt<LocalAuthInterface>());
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainNavigation(navigationShell: navigationShell);
        },
        branches: [
          // Branch 0: Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouteConstants.HomePagePath,
                name: AppRouteConstants.HomePageName,
                builder: (context, state) => const HomePage(),
                redirect: (BuildContext context, GoRouterState state) async {
                  return await AppRouteMiddleware().setLocalAuthBefore(
                      context, state, getIt<LocalAuthInterface>());
                },
                routes: [
                  GoRoute(
                    path: AppRouteConstants.TasksCleanPagePath,
                    name: AppRouteConstants.TasksPageName,
                    builder: (context, state) => const TasksPage(),
                  ),
                  GoRoute(
                    path: AppRouteConstants.MatchesCleanPagePath,
                    name: AppRouteConstants.MatchesPageName,
                    builder: (context, state) => const MatchesPage(),
                  ),
                  GoRoute(
                    path: AppRouteConstants.KffMatchesCleanPagePath,
                    name: AppRouteConstants.KffMatchesPageName,
                    builder: (context, state) => const KffMatchesPage(),
                  ),
                  GoRoute(
                    path: AppRouteConstants.KffLeagueClubCleanPagePath,
                    name: AppRouteConstants.KffLeagueClubPageName,
                    builder: (context, state) => const KffLeagueClubPage(),
                  ),
                  GoRoute(
                    path: AppRouteConstants.CountryListCleanPagePath,
                    name: AppRouteConstants.CountryListPageName,
                    builder: (context, state) => const CountriesPage(),
                  ),
                  GoRoute(
                    path: AppRouteConstants.TournamentSelectionCleanPagePath,
                    name: AppRouteConstants.TournamentSelectionPageName,
                    builder: (context, state) =>
                        const TournamentSelectionPage(),
                  ),
                  GoRoute(
                    path: AppRouteConstants.StandingsCleanPagePath,
                    name: AppRouteConstants.StandingsPageName,
                    builder: (context, state) => const StandingsPage(),
                  ),
                  GoRoute(
                    path: '${AppRouteConstants.GameStatPagePath}:gameId',
                    name: AppRouteConstants.GameStatPageName,
                    builder: (context, state) {
                      final match = state.extra as MatchEntity;
                      String gameId = state.pathParameters['gameId'] ?? "0";
                      return GamePage(gameId: gameId, match: match);
                    },
                  ),
                  GoRoute(
                    path: AppRouteConstants.ActivityPagePath,
                    name: AppRouteConstants.ActivityPageName,
                    builder: (context, state) => const ActivityPage(),
                  ),
                ],
              ),
            ],
          ),
          // Branch 1: Tickets
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouteConstants.TicketPagePath,
                name: AppRouteConstants.TicketPageName,
                builder: (context, state) {
                  return BlocProvider(
                    create: (BuildContext context) {
                      return getIt<TicketonShowsBloc>()
                        ..add(LoadTicketonShowsEvent(
                            parameter:
                                TicketonGetShowsParameter.withCurrentLocale(
                                    place: TicketonApiConstant.PlaceId)));
                    },
                    child: const TicketsPage(),
                  );
                },
              ),
            ],
          ),
          // Branch 2: Services
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouteConstants.ServicesPagePath,
                name: AppRouteConstants.ServicesPageName,
                builder: (context, state) => const ServicesPage(),
                routes: [
                  GoRoute(
                    path:
                        '${AppRouteConstants.SingleProductCleanPagePath}:productId',
                    name: AppRouteConstants.SingleProductPageName,
                    builder: (context, state) {
                      int productId = int.tryParse(
                              state.pathParameters['productId'] ?? "0") ??
                          0;
                      return BlocProvider(
                        create: (BuildContext context) {
                          return getIt<FullProductBloc>()
                            ..add(GetFullProductEvent(productId));
                        },
                        child: ServiceProductPage(productId: productId),
                      );
                    },
                  ),
                  GoRoute(
                    path:
                        '${AppRouteConstants.ServiceSectionSingleCleanPagePath}:academyId',
                    name: AppRouteConstants.ServiceSectionSinglePageName,
                    builder: (context, state) {
                      int academyId = int.tryParse(
                              state.pathParameters['academyId'] ?? "0") ??
                          0;
                      return BlocProvider(
                        create: (BuildContext context) {
                          return getIt<GetFullAcademyDetailBloc>()
                            ..add(GetFullAcademyEvent(academyId));
                        },
                        child: ServiceSectionSinglePage(academyId: academyId),
                      );
                    },
                  ),
                  GoRoute(
                    path: AppRouteConstants.MyCartCleanPagePath,
                    name: AppRouteConstants.MyCartPageName,
                    builder: (context, state) => const MyCartPage(),
                    redirect:
                        (BuildContext context, GoRouterState state) async {
                      return await AppRouteMiddleware()
                          .checkAuthMiddleware(context, state);
                    },
                  ),
                  GoRoute(
                    path: AppRouteConstants.MyProductOrdersCleanPagePath,
                    name: AppRouteConstants.MyProductOrdersPageName,
                    builder: (context, state) => const MyOrdersPage(),
                    redirect:
                        (BuildContext context, GoRouterState state) async {
                      return await AppRouteMiddleware()
                          .checkAuthMiddleware(context, state);
                    },
                    routes: [
                      GoRoute(
                        path:
                            "${AppRouteConstants.MySingleProductOrderCleanPagePath}:productOrderId",
                        name: AppRouteConstants.MySingleProductOrderPageName,
                        builder: (context, state) {
                          int productOrderId = int.tryParse(
                                  state.pathParameters['productOrderId'] ??
                                      "0") ??
                              0;
                          return ProductOrderDetailsPage(
                              orderId: productOrderId);
                        },
                        redirect:
                            (BuildContext context, GoRouterState state) async {
                          return await AppRouteMiddleware()
                              .checkAuthMiddleware(context, state);
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: AppRouteConstants.MyBookingFieldRequestsCleanPagePath,
                    name: AppRouteConstants.MyBookingFieldRequestsPageName,
                    builder: (context, state) =>
                        const MyBookingFieldPartiesPage(),
                    redirect:
                        (BuildContext context, GoRouterState state) async {
                      return await AppRouteMiddleware()
                          .checkAuthMiddleware(context, state);
                    },
                  ),
                ],
              ),
            ],
          ),
          // Branch 3: Blog
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouteConstants.BlogListPagePath,
                name: AppRouteConstants.BlogListPageName,
                builder: (context, state) => const BlogListPage(),
              ),
            ],
          ),
          // Branch 4: Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouteConstants.ProfilePagePath,
                name: AppRouteConstants.ProfilePageName,
                builder: (context, state) => const ProfilePage(),
                redirect: (BuildContext context, GoRouterState state) async {
                  return await AppRouteMiddleware()
                      .checkAuthMiddleware(context, state);
                },
                routes: [
                  GoRoute(
                    path: AppRouteConstants.EditAccountCleanPagePath,
                    name: AppRouteConstants.EditAccountPageName,
                    builder: (context, state) => const EditAccountPage(),
                    redirect:
                        (BuildContext context, GoRouterState state) async {
                      return await AppRouteMiddleware()
                          .checkAuthMiddleware(context, state);
                    },
                  ),
                  GoRoute(
                    path: AppRouteConstants.EditPasswordCleanPagePath,
                    name: AppRouteConstants.EditPasswordPageName,
                    builder: (context, state) => const EditPasswordPage(),
                    redirect:
                        (BuildContext context, GoRouterState state) async {
                      return await AppRouteMiddleware()
                          .checkAuthMiddleware(context, state);
                    },
                  ),
                  GoRoute(
                    path: AppRouteConstants.MyNotificationsCleanPagePath,
                    name: AppRouteConstants.MyNotificationsPageName,
                    builder: (context, state) => const MyNotificationPage(),
                    redirect:
                        (BuildContext context, GoRouterState state) async {
                      return await AppRouteMiddleware()
                          .checkAuthMiddleware(context, state);
                    },
                  ),
                  GoRoute(
                    path: AppRouteConstants.ReloadPINCodeCleanPath,
                    name: AppRouteConstants.ReloadPINCodePageName,
                    builder: (context, state) => const ReloadPinCodePage(),
                    redirect:
                        (BuildContext context, GoRouterState state) async {
                      return await AppRouteMiddleware()
                          .checkAuthMiddleware(context, state);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
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
              onPressed: () => context.go(AppRouteConstants.HomePagePath),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}
