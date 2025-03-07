import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_fortitu/features/home/presentation/widgets/event_carousel.dart';

class TilesList extends StatelessWidget {
  const TilesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SectionHeader(title: 'Events'),
        SizedBox(height: 12),
        EventCarousel(width: double.infinity,),
        SizedBox(height: 12),
        _SectionHeader(title: 'Intra 42'),
        _OptionTile(
          title: 'My Student Profile',
          icon: Icons.person,
          route: '/profile',
        ),
        _OptionTile(
          title: 'Search Students',
          icon: Icons.search,
          route: '/search-students',
        ),
        _OptionTile(
          title: 'My Evaluation Slots',
          icon: Icons.calendar_today,
          route: '/slots',
        ),
        _OptionTile(
          title: 'Shop',
          icon: Icons.shopping_cart,
          route: '/shop',
        ),
        _SectionHeader(title: 'Campus'),
        _OptionTile(
          title: 'p2p',
          icon: Icons.search,
          route: '/finder',
        ),
        _OptionTile(
          title: 'Clusters',
          icon: Icons.login,
          route: '/clusters',
        ),
        _OptionTile(
          title: 'Coalitions',
          icon: Icons.groups,
          route: '/coalitions',
        ),
        _SectionHeader(title: 'Out of Code'),
        _OptionTile(
          title: 'Leagues',
          icon: Icons.sports_soccer,
          route: '/leagues',
        ),
        SizedBox(height: 30),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({super.key, required this.title});

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
