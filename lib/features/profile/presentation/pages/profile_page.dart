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
import '../../../../l10n/app_localizations.dart';

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
                  title: Text(AppLocalizations.of(context)!.takePhoto),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
              if (!hasImage)
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: Text(AppLocalizations.of(context)!.chooseFromGallery),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
              if (hasImage)
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: Text(AppLocalizations.of(context)!.takeNewPhoto),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
              if (hasImage)
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title:
                      Text(AppLocalizations.of(context)!.chooseNewFromGallery),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
              if (hasImage)
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: Text(AppLocalizations.of(context)!.deletePhoto,
                      style: const TextStyle(color: Colors.red)),
                  onTap: () {
                    Navigator.pop(context);
                    _deletePhoto();
                  },
                ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: Text(AppLocalizations.of(context)!.cancel),
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
        requestFullMetadata: false,
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
            throw Exception(AppLocalizations.of(context)!.selectedFileEmpty);
          }
        } else {
          throw Exception(AppLocalizations.of(context)!.fileNotFound);
        }
      }
    } on PlatformException catch (e) {
      if (mounted) {
        String errorMessage =
            AppLocalizations.of(context)!.errorAccessingCameraGallery;
        if (e.code == 'camera_access_denied') {
          errorMessage = AppLocalizations.of(context)!.cameraAccessDenied;
        } else if (e.message?.contains('channel-error') == true) {
          errorMessage = AppLocalizations.of(context)!.cameraConnectionError;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: AppLocalizations.of(context)!.settings,
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
            content: Text(
                '${AppLocalizations.of(context)!.errorSelectingImage}: ${e.toString()}'),
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
            content: Text('${AppLocalizations.of(context)!.errorOnLogout}: $e'),
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
        title: AppLocalizations.of(context)!.profile,
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
                  SnackBar(
                    content:
                        Text(AppLocalizations.of(context)!.profilePhotoUpdated),
                    backgroundColor: Colors.green,
                  ),
                );
                _getMeBloc.add(LoadUserProfile());
              } else if (state is UpdateProfilePhotoFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        '${AppLocalizations.of(context)!.unknownError}: ${state.message}'),
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
                  SnackBar(
                    content:
                        Text(AppLocalizations.of(context)!.profilePhotoDeleted),
                    backgroundColor: Colors.green,
                  ),
                );
                _getMeBloc.add(LoadUserProfile());
              } else if (state is DeleteProfilePhotoFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        '${AppLocalizations.of(context)!.unknownError}: ${state.message}'),
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
                userImage: state.user.image,
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
