import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_fortitu/features/clusters/presentation/blocs/clusters_bloc/clusters_bloc.dart';

import '../../../profiles/presentation/blocs/user_bloc/user_bloc.dart';
import '../widgets/cluster_layout.dart';
import '../../../../core/widgets/dev_info_widget.dart';

class ClustersScreen extends StatelessWidget {
  const ClustersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('home.tiles.clusters')),
        actions: [
          IconButton(
            onPressed: () {
              context.read<ClustersBloc>().add(RefreshClustersEvent());
            },
            icon: Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              showDevInfoDialog(context, 'clustersTestInfo');
            },
            icon: Icon(Icons.adb),
            color: Colors.red,
          ),
        ],
      ),
      body: BlocBuilder<ClustersBloc, ClustersState>(
        builder: (context, state) {
          if (state is ClustersInitial) {
            final profileState = context.read<UserBloc>().state;
            if (profileState is UserSuccess) {
              final campusId = profileState.profile.campus[0].id.toString();
              context.read<ClustersBloc>().add(GetCampusClustersEvent(campusId: campusId));
            } else {
              return const Center(child: Text('Error loading campus ID'));
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
    );
  }
}
