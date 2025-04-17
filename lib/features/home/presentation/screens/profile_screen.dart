import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_fortitu/features/home/presentation/bloc/intra_profile_bloc/intra_profile_bloc.dart';
import 'package:mi_fortitu/features/home/presentation/widgets/cursus_profile.dart';

import '../widgets/dev_info_widget.dart';

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
      body: BlocBuilder<IntraProfileBloc, IntraProfileState>(
        builder: (context, state) {
          if (state is IntraProfileSuccess) {
            final intraProfile = state.intraProfile;
            return CursusProfile(profile: intraProfile);
          }
          return Center(child: Text('Error: Cannot load profile'));
        },
      ),
    );
  }
}
