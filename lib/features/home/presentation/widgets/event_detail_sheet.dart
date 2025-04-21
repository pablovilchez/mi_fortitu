import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../viewmodels/event_viewmodel.dart';

class EventDetailSheet extends StatefulWidget {
  final EventVm event;

  const EventDetailSheet({super.key, required this.event});

  @override
  State<EventDetailSheet> createState() => _EventDetailSheetState();
}

class _EventDetailSheetState extends State<EventDetailSheet> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrollable = false;
  bool _isAtBottom = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.position.maxScrollExtent > 0) {
        setState(() {
          _isScrollable = true;
        });
      }
    });
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent >
          _scrollController.position.pixels + 20) {
        setState(() {
          _isAtBottom = false;
        });
      } else {
        setState(() {
          _isAtBottom = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final details = widget.event.details;
    final contentStyle = TextStyle(fontSize: 15);

    return FractionallySizedBox(
      heightFactor: 0.7,
      child: Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.event.details.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                EventDetailField(icon: Icons.calendar_today, text: details.beginDate),
                SizedBox(width: 40),
                EventDetailField(icon: Icons.access_time, text: details.beginTime),
              ],
            ),
            SizedBox(height: 10),
            EventDetailField(icon: Icons.pin_drop, text: widget.event.details.location),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    Text(details.description, style: contentStyle),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_isScrollable && !_isAtBottom)
                    Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [EventDetailButton(isSubscribed: widget.event.isSubscribed)],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class EventDetailField extends StatelessWidget {
  final IconData icon;
  final String text;

  const EventDetailField({
    super.key,
    required this.icon,
    this.text = 'Undefined',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 10),
        Text(text, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class EventDetailButton extends StatelessWidget {
  final bool isSubscribed;

  const EventDetailButton({super.key, required this.isSubscribed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            isSubscribed
                ? WidgetStateProperty.all(Colors.red.shade300)
                : WidgetStateProperty.all(Colors.green.shade300),
      ),
      onPressed: () {},
      child: Text(
        isSubscribed ? tr('home.events.unsubscribe') : tr('home.events.subscribe'),
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
