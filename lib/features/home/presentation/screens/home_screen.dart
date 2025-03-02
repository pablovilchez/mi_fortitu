import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_fortitu/features/home/presentation/bloc/intra_profile_cubit/intra_profile_cubit.dart';

import 'package:mi_fortitu/features/home/presentation/widgets/widgets.dart';

import '../../../../core/themes/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IntraProfileCubit(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<IntraProfileCubit, IntraProfileState>(
              builder: (context, state) {
                if (state is IntraProfileLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is IntraProfileFailure) {
                  return const Center(child: Text('Error'));
                }
                final intraProfile = context.read<IntraProfileCubit>().intraProfile;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeProfileCard(profile: intraProfile),
                    const SizedBox(height: 16),
                    HomeValuesCard(),
                    const SizedBox(height: 22),
                    HomeTilesGroup(
                        title: '42 Intra', colorSet: AppColors.pastelBlue),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
