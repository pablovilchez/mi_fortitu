import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_fortitu/core/themes/backgrounds.dart';
import 'package:mi_fortitu/features/clusters/presentation/blocs/clusters_bloc/clusters_bloc.dart';

import '../../../profiles/presentation/blocs/user_profile_bloc/user_profile_bloc.dart';
import '../widgets/cluster_layout.dart';
import '../../../../core/presentation/widgets/dialogs/dev_info_widget.dart';

class ClustersScreen extends StatelessWidget {
  const ClustersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(tr('clusters.title')),
          actions: [
            IconButton(
              onPressed: () {
                context.read<ClustersBloc>().add(RefreshClustersEvent());
              },
              icon: const Icon(Icons.refresh),
            ),
            IconButton(
              onPressed: () {
                showDevInfoDialog(context, 'clustersTestInfo');
              },
              icon: const Icon(Icons.adb),
              color: Colors.red,
            ),
          ],
        ),
        body: BlocBuilder<ClustersBloc, ClustersState>(
          builder: (context, state) {
            if (state is ClustersInitial) {
              final profileState = context.read<UserProfileBloc>().state;
              if (profileState is UserProfileSuccess) {
                final campusId = profileState.profile.campus[0].id.toString();
                context.read<ClustersBloc>().add(GetCampusClustersEvent(campusId: campusId));
              } else {
                return Center(child: Text(tr('clusters.message.campus_load_error')));
              }
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ClustersLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ClustersError) {
              return Center(child: Text(state.errorMessage));
            }
            if (state is ClustersSuccess) {
              return ClusterLayout(clusters: state.campusClusters);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
