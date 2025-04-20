import 'package:flutter/material.dart';
import 'package:mi_fortitu/features/peers/presentation/widgets/peer_avatar.dart';

import '../../domain/entities/peer_entity.dart';

class PeerGrid extends StatelessWidget {
  final List<PeerEntity> peers;
  final bool showAsDisconnected;

  const PeerGrid({
    super.key,
    required this.peers,
    this.showAsDisconnected = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const int crossAxisCount = 5;
        final itemWidth = (constraints.maxWidth - 40) / crossAxisCount;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
            spacing: 8,
            runSpacing: 16,
            children: peers.map((peer) {
              return SizedBox(
                width: itemWidth,
                child: PeerAvatar(peer: peer, masked: showAsDisconnected),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
