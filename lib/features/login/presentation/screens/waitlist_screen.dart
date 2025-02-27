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
            SizedBox(height: 8),
            Text(
              'Now you are in the waitlist.',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 40),
            SizedBox(
              height: 200,
              child: Image.asset('assets/images/waitlist.png'),
            ),
            SizedBox(height: 40),
            Text(
              'You will be notified\nif you become a tester.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => context.go('/login'),
              child: Text('Log out?'),
            ),
          ],
        ),
      ),
    );
  }
}
