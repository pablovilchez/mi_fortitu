import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/peer_entity.dart';

class PeerAvatar extends StatelessWidget {
  final PeerEntity peer;
  final bool masked;

  const PeerAvatar({super.key, required this.peer, this.masked = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push('/search-students/${peer.loginName}');
      },
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(radius: 28, backgroundImage: NetworkImage(peer.photoUrl)),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: masked ? Colors.black.withValues(alpha: 0.3) : Colors.transparent,
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: masked ? Colors.red.withValues(alpha: 0.5) : Colors.green.withValues(alpha: 0.5), width: 5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            peer.loginName,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
          if (peer.isOnline && !masked)
            Text(
              peer.location,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}
