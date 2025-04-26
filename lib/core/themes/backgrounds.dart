import 'package:flutter/cupertino.dart';

class MainBackground extends StatelessWidget {
  final Widget child;
  final bool usingAppBar;

  const MainBackground({super.key, required this.child, this.usingAppBar = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE0E0E0), Color(0xFFA69CDC)],
        ),
      ),
      child: SafeArea(child: child),
    );
  }
}
