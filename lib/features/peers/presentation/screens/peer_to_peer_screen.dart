import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../profiles/presentation/blocs/profiles_bloc/profiles_bloc.dart';
import '../../../../core/widgets/dev_info_widget.dart';

class PeerToPeerScreen extends StatelessWidget {
  const PeerToPeerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userState = context.read<ProfilesBloc>().state;
    final projects = userState is ProfileSuccess ? userState.profile.projectsUsers : null;
    final openProjects = projects?.where((project) => project.status == 'in_progress' && project.marked == false).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('home.tiles.peer2peer')),
        actions: [IconButton(onPressed: (){
          showDevInfoDialog(context, 'peer2peerTestInfo');
        }, icon: Icon(Icons.adb),
          color: Colors.red,)],
      ),
      body: openProjects == null
          ? const Center(child: Text('Error loading projects'))
          : openProjects.isEmpty
              ? Center(
                  child: Text('No projects found'),
                )
              : ListView.builder(
                  itemCount: openProjects.length,
                  itemBuilder: (context, index) {
                    final project = openProjects[index];
                    return ListTile(
                      title: Text(project.project.name),
                    );
                  },
                ),
    );
  }
}