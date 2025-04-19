import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../core/widgets/dev_info_widget.dart';
import '../../../profiles/presentation/blocs/user_bloc/user_bloc.dart';
import '../blocs/coalitions_blocs_bloc/coalitions_blocs_bloc.dart';
import '../widgets/coalitions_layout.dart';

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
      body: BlocBuilder<CoalitionsBlocsBloc, CoalitionsBlocsState>(builder: (context, state) {
        if (state is IntraCoalitionsInitial) {
          final profileState = context.read<UserBloc>().state;
          if (profileState is UserSuccess) {
            final campusId = profileState.profile.campus[0].id.toString();
            context.read<CoalitionsBlocsBloc>().add(GetCoalitionsEvent(campusId: campusId));
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
