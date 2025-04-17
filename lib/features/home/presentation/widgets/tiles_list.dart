import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_fortitu/features/home/presentation/widgets/event_carousel.dart';

class TilesList extends StatelessWidget {
  const TilesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(title: tr('home.titles.events')),
        SizedBox(height: 12),
        EventCarousel(width: double.infinity,),
        SizedBox(height: 12),
        SectionHeader(title: tr('home.titles.intra42')),
        _OptionTile(
          title: tr('home.tiles.me'),
          icon: Icons.person,
          route: '/profile',
        ),
        _OptionTile(
          title: tr('home.tiles.search'),
          icon: Icons.search,
          route: '/search-students',
        ),
        _OptionTile(
          title: tr('home.tiles.eval_slots'),
          icon: Icons.calendar_today,
          route: '/slots',
        ),
        // _OptionTile(
        //   title: tr('home.tiles.shop'),
        //   icon: Icons.shopping_cart,
        //   route: '/shop',
        // ),
        SectionHeader(title: 'Campus'),
        _OptionTile(
          title: tr('home.tiles.peer2peer'),
          icon: Icons.search,
          route: '/finder',
        ),
        _OptionTile(
          title: tr('home.tiles.clusters'),
          icon: Icons.login,
          route: '/clusters',
        ),
        _OptionTile(
          title: tr('home.tiles.coalitions'),
          icon: Icons.groups,
          route: '/coalitions',
        ),
        SectionHeader(title: tr('home.titles.out_code')),
        _OptionTile(
          title: tr('home.tiles.leagues'),
          icon: Icons.sports_soccer,
          route: '/leagues',
        ),
        SizedBox(height: 30),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;

  const _OptionTile({
    super.key,
    required this.title,
    required this.icon,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        GoRouter.of(context).push(route);
      },
    );
  }
}
