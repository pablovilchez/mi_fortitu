import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_fortitu/core/themes/backgrounds.dart';
import 'package:mi_fortitu/features/coalitions_blocs/coalitions_blocs.dart';
import 'package:mi_fortitu/features/home/presentation/viewmodels/home_user_data_viewmodel.dart';
import 'package:mi_fortitu/features/home/presentation/widgets/tiles_list.dart';

import '../../../../core/helpers/avatar_storage_helper.dart';
import '../../../../core/presentation/widgets/dialogs/dev_info_widget.dart';
import '../../../../core/services/avatar_notifier.dart';
import '../../../profiles/presentation/blocs/user_profile_bloc/user_profile_bloc.dart';
import '../blocs/events_bloc/events_bloc.dart';
import '../widgets/profile_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileBloc, UserProfileState>(
      listener: (context, state) {
        if (state is UserProfileSuccess) {
          context.read<EventsBloc>().add(
            GetIntraEventsEvent(
              state.profile.login,
              state.profile.id,
              state.profile.campus[0].id,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is UserProfileInitial) {
          context.read<UserProfileBloc>().add(GetUserProfileEvent());
          return const _LoadingView();
        } else if (state is UserProfileLoading) {
          return const _LoadingView();
        } else if (state is UserProfileError) {
          return _ErrorView(message: state.message);
        } else if (state is UserProfileSuccess) {
          context.read<CoalitionsBlocsBloc>().add(
            GetCoalitionsEvent(campusId: state.profile.campus[0].id),
          );
          return _HomeView();
        }
        return const SizedBox();
      },
    );
  }
}

class _HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: AvatarStorageHelper.getAvatarPath(),
      builder: (context, snapshot) {
        final avatarPath = snapshot.data ?? 'assets/images/default_avatar.png';

        final profile =
            context.read<UserProfileBloc>().state is UserProfileSuccess
                ? (context.read<UserProfileBloc>().state as UserProfileSuccess).profile
                : null;

        final intraData =
            profile != null
                ? HomeUserDataVm.fromEntity(profile).copyWith(customAvatar: avatarPath)
                : HomeUserDataVm.empty();

        return _buildHomeLayout(context, intraData);
      },
    );
  }

  Widget _buildHomeLayout(BuildContext context, HomeUserDataVm intraData) {
    return Scaffold(
      body: MainBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                ValueListenableBuilder<File?>(
                  valueListenable: avatarNotifier,
                  builder: (context, avatarFile, _) {
                    final updatedData = intraData.copyWith(
                      customAvatar: avatarFile?.path ?? intraData.customAvatar,
                    );
                    return ProfileHeader(userData: updatedData);
                  },
                ),
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {
                        GoRouter.of(context).push('/settings');
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        showDevInfoDialog(context, 'homeTestInfo');
                      },
                      icon: const Icon(Icons.adb),
                      color: Colors.red,
                    ),
                  ],
                ),
                // HomeUserCards(profile: profile),
                const SizedBox(height: 8),
                Expanded(
                  child: ShaderMask(
                    shaderCallback: (bounds) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black,
                        ],
                        stops: [0.0, 0.05, 0.9, 1.0],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.dstOut,
                    child: const SingleChildScrollView(child: TilesList()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(tr('home.message.loading_profile')),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(tr('home.message.loading_error')),
            Text(message),
            ElevatedButton(
              onPressed: () {
                context.read<UserProfileBloc>().add(GetUserProfileEvent());
              },
              child: Text(tr('home.button.retry')),
            ),
          ],
        ),
      ),
    );
  }
}
