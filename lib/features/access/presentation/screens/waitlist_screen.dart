import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WaitlistScreen extends StatelessWidget {
  const WaitlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Thank you!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Now you are in the waitlist.',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 200,
              child: Image.asset('assets/images/waitlist.png'),
            ),
            const SizedBox(height: 40),
            Text(
              'Finally, write me on slack!',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text('@pvilchez', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 30),
            Text(
              'Tell me your email, and the reason why\nyou want to join the test version.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 35),
            Text(
              '(Or if you already have permission, ...)',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/auth');
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
