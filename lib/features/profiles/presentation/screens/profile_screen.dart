import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_fortitu/features/profiles/presentation/widgets/cursus_profile.dart';

import '../../../../core/widgets/dev_info_widget.dart';
import '../blocs/profiles_bloc/profiles_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('home.tiles.me')),
        actions: [
          IconButton(
            onPressed: () {
              showDevInfoDialog(context, 'profileTestInfo');
            },
            icon: Icon(Icons.adb),
            color: Colors.red,
          ),
        ],
      ),
      body: BlocBuilder<ProfilesBloc, ProfilesState>(
        builder: (context, state) {
          if (state is ProfileSuccess) {
            final intraProfile = state.profile;
            return CursusProfile(profile: intraProfile);
          }
          return Center(child: Text('Error: Cannot load profile'));
        },
      ),
    );
  }
}
