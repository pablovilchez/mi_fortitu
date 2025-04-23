import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_fortitu/features/home/presentation/widgets/event_carousel.dart';

import '../blocs/events_bloc/events_bloc.dart';

class TilesList extends StatelessWidget {
  const TilesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(title: tr('home.titles.events'),
          action: IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<EventsBloc>().add(RefreshIntraEventsEvent());
            },
          ),
        ),
        SizedBox(height: 12),
        EventCarousel(width: double.infinity,),
        SizedBox(height: 12),
        SectionHeader(title: tr('home.titles.intra42')),
        _OptionTile(
          title: tr('home.tiles.me'),
          image: AssetImage('assets/images/home_tiles/profile.png'),
          route: '/profile',
        ),
        _OptionTile(
          title: tr('home.tiles.search'),
          image: AssetImage('assets/images/home_tiles/search.png'),
          route: '/search-students',
        ),
        _OptionTile(
          title: tr('home.tiles.peer2peer'),
          image: AssetImage('assets/images/home_tiles/peer2peer.png'),
          route: '/finder',
        ),
        _OptionTile(
          title: tr('home.tiles.eval_slots'),
          image: AssetImage('assets/images/home_tiles/slots.png'),
          route: '/slots',
        ),
        // _OptionTile(
        //   title: tr('home.tiles.shop'),
        //   icon: Icons.shopping_cart,
        //   route: '/shop',
        // ),
        SectionHeader(title: 'Campus'),
        _OptionTile(
          title: tr('home.tiles.clusters'),
          image: AssetImage('assets/images/home_tiles/clusters.png'),
          route: '/clusters',
        ),
        _OptionTile(
          title: tr('home.tiles.coalitions'),
          image: AssetImage('assets/images/home_tiles/coalitions.png'),
          route: '/coalitions',
        ),
        SectionHeader(title: tr('home.titles.out_box')),
        _OptionTile(
          title: tr('home.tiles.leagues'),
          image: AssetImage('assets/images/home_tiles/leagues.png'),
          route: '/leagues',
        ),
        // _OptionTile(
        //   title: tr('home.tiles.games'),
        //   image: AssetImage('assets/images/home_tiles/games.png'),
        //   route: '/games',
        // ),
        SizedBox(height: 30),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final IconButton ? action;

  const SectionHeader({super.key, required this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          action ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String title;
  final AssetImage image;
  final String route;

  const _OptionTile({
    super.key,
    required this.title,
    required this.image,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: SizedBox(width: 25, height: 25, child: Image(image: image)),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        GoRouter.of(context).push(route);
      },
    );
  }
}
