import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_fortitu/features/home/presentation/bloc/intra_profile_bloc/intra_profile_bloc.dart';
import 'package:mi_fortitu/features/home/presentation/widgets/cursus_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<IntraProfileBloc, IntraProfileState>(
        builder: (context, state) {
          if (state is IntraProfileSuccess) {
            final intraProfile = state.intraProfile;
            return CursusProfile(intraProfile: intraProfile);
          }
          return Center(child: Text('Error: Cannot load profile'));
        },
      ),
    );
  }
}