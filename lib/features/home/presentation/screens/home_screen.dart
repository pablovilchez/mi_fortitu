import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mi_fortitu/features/home/presentation/widgets/tiles_list.dart';

import '../../../profiles/presentation/blocs/profiles_bloc/profiles_bloc.dart';
import '../../../profiles/presentation/viewmodels/intra_profile_summary_vm.dart';
import '../blocs/events_bloc/events_bloc.dart';
import '../widgets/home_user_cards.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfilesBloc, ProfilesState>(
      listener: (context, state) {
        if (state is ProfileSuccess) {
          context.read<EventsBloc>().add(
            GetIntraEventsEvent(
              state.profile.login,
              state.profile.campus[0].id.toString(),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileInitial) {
          context.read<ProfilesBloc>().add(GetIntraProfileEvent());
          return _LoadingView();
        } else if (state is ProfileLoading) {
          return _LoadingView();
        } else if (state is ProfileError) {
          return _ErrorView(message: state.message);
        } else if (state is ProfileSuccess) {
          return _HomeView(profile: state.profileSummary);
        }
        return const SizedBox();
      },
    );
  }
}

class _HomeView extends StatelessWidget {
  final IntraProfileSummaryVM profile;

  const _HomeView({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 10),
              HomeUserCards(profile: profile),
              SizedBox(height: 8),
              Expanded(
                child: ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent, Colors.transparent, Colors.black],
                      stops: [0.0, 0.05, 0.9, 1.0],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstOut,
                  child: SingleChildScrollView(child: TilesList()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(tr('home.messages.loading_profile')),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(tr('home.messages.loading_error')),
            Text(message),
            ElevatedButton(
              onPressed: () {
                context.read<ProfilesBloc>().add(GetIntraProfileEvent());
              },
              child: Text(tr('buttons.retry')),
            ),
          ],
        ),
      ),
    );
  }
}
