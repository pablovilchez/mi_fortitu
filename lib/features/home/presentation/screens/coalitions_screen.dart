import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_fortitu/features/home/presentation/bloc/intra_coalitions_bloc/intra_coalitions_bloc.dart';

import '../bloc/intra_profile_bloc/intra_profile_bloc.dart';
import '../widgets/coalitions_layout.dart';
import '../widgets/dev_info_widget.dart';

class CoalitionsScreen extends StatelessWidget {
  const CoalitionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('home.tiles.coalitions')),
        actions: [
          IconButton(
            onPressed: () {
              showDevInfoDialog(context, 'coalitionsTestInfo');
            },
            icon: Icon(Icons.adb),
            color: Colors.red,
          ),
        ],
      ),
      body: BlocBuilder<IntraCoalitionsBloc, IntraCoalitionsState>(builder: (context, state) {
        if (state is IntraCoalitionsInitial) {
          final profileState = context.read<IntraProfileBloc>().state;
          if (profileState is IntraProfileSuccess) {
            final campusId = profileState.intraProfile.campus[0].id.toString();
            context.read<IntraCoalitionsBloc>().add(GetCoalitionsEvent(campusId: campusId));
          } else {
            return const Center(child: Text('Error loading campus ID'));
          }
          return const Center(child: CircularProgressIndicator());
        }
        if (state is IntraCoalitionsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is IntraCoalitionsError) {
          return Center(child: Text(state.errorMessage));
        }
        if (state is IntraCoalitionsSuccess) {
          return CoalitionsLayout(coalitions: state.coalitions);
        }
        return const SizedBox();
      }),
    );
  }
}
