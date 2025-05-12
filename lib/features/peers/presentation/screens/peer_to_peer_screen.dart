import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mi_fortitu/core/themes/backgrounds.dart';
import 'package:mi_fortitu/features/peers/presentation/viewmodels/project_peers_viewmodel.dart';
import 'package:mi_fortitu/features/profiles/presentation/blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../domain/usecases/get_projects_peers_usecase.dart';

import '../../../../core/presentation/widgets/dialogs/dev_info_widget.dart';
import '../widgets/peer_grid.dart';

class PeerToPeerScreen extends StatefulWidget {
  const PeerToPeerScreen({super.key});

  @override
  State<PeerToPeerScreen> createState() => _PeerToPeerScreenState();
}

class _PeerToPeerScreenState extends State<PeerToPeerScreen> {
  final GetProjectsPeersUsecase _getProjectsPeersUsecase = GetIt.I();
  List<ProjectPeersVm> _projectsPeers = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final userState = context.read<UserProfileBloc>().state;
    if (userState is! UserProfileSuccess) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
      return;
    }

    final peersPerProject = await _getProjectsPeersUsecase.call(userState.profile);

    peersPerProject.fold(
      (failure) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      },
      (projects) {
        setState(() {
          _projectsPeers = projects;
          _isLoading = false;
          _hasError = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(tr('peer2peer.title')),
          actions: [
            IconButton(
              icon: const Icon(Icons.adb, color: Colors.red),
              onPressed: () => showDevInfoDialog(context, 'peer2peerTestInfo'),
            ),
          ],
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _hasError
            ? Center(child: Text(tr('peer2peer.loading_error')))
            : _projectsPeers.isEmpty
            ? Center(child: Text(tr('peer2peer.no_projects')))
            : ListView.builder(
          itemCount: _projectsPeers.length,
          itemBuilder: (context, index) {
            final project = _projectsPeers[index];
            final peers = project.peers;
      
            final connectedPeers = peers.where((p) => p.isOnline).toList();
            final disconnectedPeers = peers.where((p) => !p.isOnline).toList();
      
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      project.projectName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  PeerGrid(peers: connectedPeers),
                  if (disconnectedPeers.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    PeerGrid(peers: disconnectedPeers, showAsDisconnected: true),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
