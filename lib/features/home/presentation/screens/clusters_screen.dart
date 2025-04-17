import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_fortitu/features/home/presentation/bloc/intra_clusters_bloc/intra_clusters_bloc.dart';
import 'package:mi_fortitu/features/home/presentation/bloc/intra_profile_bloc/intra_profile_bloc.dart';

import '../widgets/cluster_layout.dart';
import '../widgets/dev_info_widget.dart';

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
              context.read<IntraClustersBloc>().add(RefreshClustersEvent());
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
      body: BlocBuilder<IntraClustersBloc, IntraClustersState>(
        builder: (context, state) {
          if (state is IntraClustersInitial) {
            final profileState = context.read<IntraProfileBloc>().state;
            if (profileState is IntraProfileSuccess) {
              final campusId = profileState.intraProfile.campus[0].id.toString();
              context.read<IntraClustersBloc>().add(GetCampusClustersEvent(campusId: campusId));
            } else {
              return const Center(child: Text('Error loading campus ID'));
            }
            return const Center(child: CircularProgressIndicator());
          }
          if (state is IntraClustersLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is IntraClustersError) {
            return Center(child: Text(state.errorMessage));
          }
          if (state is IntraClustersSuccess) {
            return ClusterLayout(clusters: state.campusClusters);
          }
          return const SizedBox();
        },
      ),
    );
  }
}
