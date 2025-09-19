import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jankuier_mobile/core/constants/app_colors.dart';
import 'package:jankuier_mobile/core/utils/hive_utils.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/get_me_bloc/get_me_event.dart';

import '../../../../core/constants/app_route_constants.dart';
import '../../../../core/di/injection.dart';
import '../../../../shared/widgets/common_app_bars/pages_common_app_bar.dart';
import '../../../auth/presentation/bloc/get_me_bloc/get_me_bloc.dart';
import '../../../auth/presentation/bloc/get_me_bloc/get_me_state.dart';
import '../widgets/edit_profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> _onLogout() async {
    try {
      // Clear all user data from Hive
      final hiveUtils = getIt<HiveUtils>();
      await hiveUtils.clearAccessToken();
      await hiveUtils.clearCurrentUser();

      // Navigate to SignIn page
      if (mounted) {
        context.go(AppRouteConstants.SignInPagePath);
      }
    } catch (e) {
      // Handle any errors during logout
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка при выходе: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GetMeBloc>()..add(LoadUserProfile()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: PagesCommonAppBar(
          title: "Профиль",
          actionIcon: Icons.notifications_none,
          onActionTap: () {},
        ),
        body: BlocConsumer<GetMeBloc, GetMeState>(
          listener: (context, state) {
            if (state is GetMeError) {
              context.go(AppRouteConstants.SignInPagePath);
            }
          },
          builder: (context, state) {
            if (state is GetMeLoaded) {
              return EditProfilePage(
                userName: "${state.user.firstName} ${state.user.lastName}",
                onAvatarTap: () {
                  // Открыть выбор аватара
                },
                onPersonalDataTap: () {
                  context.push(AppRouteConstants.EditAccountPagePath);
                },
                onSecurityTap: () {
                  context.push(AppRouteConstants.EditPasswordPagePath);
                },
                onLogout: _onLogout,
              );
            }
            return const SizedBox.expand(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
