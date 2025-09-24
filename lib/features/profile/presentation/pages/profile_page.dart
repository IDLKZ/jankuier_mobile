import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jankuier_mobile/core/constants/app_colors.dart';
import 'package:jankuier_mobile/core/utils/hive_utils.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/get_me_bloc/get_me_event.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/update_profile_photo_bloc/update_profile_photo_bloc.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/update_profile_photo_bloc/update_profile_photo_event.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/update_profile_photo_bloc/update_profile_photo_state.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/delete_profile_photo_bloc/delete_profile_photo_bloc.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/delete_profile_photo_bloc/delete_profile_photo_event.dart';
import 'package:jankuier_mobile/features/auth/presentation/bloc/delete_profile_photo_bloc/delete_profile_photo_state.dart';

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
  final ImagePicker _imagePicker = ImagePicker();
  late GetMeBloc _getMeBloc;
  late UpdateProfilePhotoBloc _updateProfilePhotoBloc;
  late DeleteProfilePhotoBloc _deleteProfilePhotoBloc;

  @override
  void initState() {
    super.initState();
    _getMeBloc = getIt<GetMeBloc>();
    _updateProfilePhotoBloc = getIt<UpdateProfilePhotoBloc>();
    _deleteProfilePhotoBloc = getIt<DeleteProfilePhotoBloc>();
    _getMeBloc.add(LoadUserProfile());
  }

  Future<void> _showPhotoOptions(BuildContext context, bool hasImage) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              if (!hasImage)
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Сделать фото'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
              if (!hasImage)
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Выбрать из галереи'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
              if (hasImage)
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Сделать новое фото'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
              if (hasImage)
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Выбрать новое из галереи'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
              if (hasImage)
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text('Удалить фото',
                      style: TextStyle(color: Colors.red)),
                  onTap: () {
                    Navigator.pop(context);
                    _deletePhoto();
                  },
                ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text('Отмена'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        final File imageFile = File(pickedFile.path);

        // Check if file exists and is valid
        if (await imageFile.exists()) {
          final fileSize = await imageFile.length();
          if (fileSize > 0) {
            _updateProfilePhotoBloc.add(
                  UpdateProfilePhotoSubmitted(imageFile),
                );
          } else {
            throw Exception('Выбранный файл пуст');
          }
        } else {
          throw Exception('Файл не найден');
        }
      }
    } on PlatformException catch (e) {
      if (mounted) {
        String errorMessage = 'Ошибка доступа к камере/галерее';
        if (e.code == 'photo_access_denied') {
          errorMessage =
              'Доступ к фото запрещен. Проверьте разрешения в настройках';
        } else if (e.code == 'camera_access_denied') {
          errorMessage =
              'Доступ к камере запрещен. Проверьте разрешения в настройках';
        } else if (e.message?.contains('channel-error') == true) {
          errorMessage =
              'Ошибка подключения к камере. Попробуйте перезапустить приложение';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'Настройки',
              textColor: Colors.white,
              onPressed: () {},
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка при выборе изображения: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _deletePhoto() {
    _deleteProfilePhotoBloc.add(
          const DeleteProfilePhotoSubmitted(),
        );
  }

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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PagesCommonAppBar(
        title: "Профиль",
        actionIcon: Icons.notifications_none,
        onActionTap: () {},
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<GetMeBloc, GetMeState>(
            bloc: _getMeBloc,
            listener: (context, state) {
              if (state is GetMeError) {
                context.go(AppRouteConstants.SignInPagePath);
              }
            },
          ),
          BlocListener<UpdateProfilePhotoBloc, UpdateProfilePhotoState>(
            bloc: _updateProfilePhotoBloc,
            listener: (context, state) {
              if (state is UpdateProfilePhotoSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Фото профиля обновлено'),
                    backgroundColor: Colors.green,
                  ),
                );
                _getMeBloc.add(LoadUserProfile());
              } else if (state is UpdateProfilePhotoFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Ошибка: ${state.message}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
          BlocListener<DeleteProfilePhotoBloc, DeleteProfilePhotoState>(
            bloc: _deleteProfilePhotoBloc,
            listener: (context, state) {
              if (state is DeleteProfilePhotoSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Фото профиля удалено'),
                    backgroundColor: Colors.green,
                  ),
                );
                _getMeBloc.add(LoadUserProfile());
              } else if (state is DeleteProfilePhotoFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Ошибка: ${state.message}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<GetMeBloc, GetMeState>(
          bloc: _getMeBloc,
          builder: (context, state) {
            if (state is GetMeLoaded) {
              return EditProfilePage(
                userName: "${state.user.firstName} ${state.user.lastName}",
                onAvatarTap: () {
                  _showPhotoOptions(context, state.user.imageId != null);
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
