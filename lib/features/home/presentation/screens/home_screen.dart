import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_fortitu/features/home/presentation/bloc/intra_profile_bloc/intra_profile_bloc.dart';
import 'package:mi_fortitu/features/home/presentation/viewmodels/profile_summary_viewmodel.dart';
import 'package:mi_fortitu/features/home/presentation/widgets/tiles_list.dart';

import '../widgets/profile_cards.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String loginName = 'pvilchez'; // DEBUG

    return BlocProvider(
      create: (context) {
        final bloc = IntraProfileBloc();
        bloc.add(GetIntraProfileEvent(loginName));
        return bloc;
      },
      child: BlocBuilder<IntraProfileBloc, IntraProfileState>(
        builder: (context, state) {
          if (state is IntraProfileLoading) {
            return _LoadingView();
          } else if (state is IntraProfileError) {
            return _ErrorView(message: state.message, loginName: loginName);
          } else if (state is IntraProfileSuccess) {
            return _HomeView(profile: state.profileSummary);
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _HomeView extends StatelessWidget {
  final ProfileSummaryVM profile;

  const _HomeView({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 30),
              ProfileCards(profile: profile),
              SizedBox(height: 8),
              TilesList(),
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
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Loading profile data...'),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final String loginName;

  const _ErrorView({super.key, required this.message, required this.loginName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Error loading profile data'),
            Text(message),
            ElevatedButton(
              onPressed: () {
                context.read<IntraProfileBloc>().add(
                  GetIntraProfileEvent(loginName),
                );
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
