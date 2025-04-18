import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mi_fortitu/features/home/domain/entities/event_entity.dart';

class EventDetailSheet extends StatefulWidget {
  final EventEntity event;

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
    final day = DateFormat('MMMEd').format(widget.event.beginAt);
    final time = DateFormat('HH:mm').format(widget.event.beginAt);
    final contentStyle = TextStyle(fontSize: 15);

    return FractionallySizedBox(
      heightFactor: 0.7,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.event.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  EventDetailField(icon: Icons.calendar_today, text: day),
                  SizedBox(width: 40),
                  EventDetailField(icon: Icons.access_time, text: time),
                ],
              ),
              SizedBox(height: 10),
              EventDetailField(icon: Icons.pin_drop, text: widget.event.location),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      Text(widget.event.description, style: contentStyle),
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
                children: [EventDetailButton(event: widget.event)],
              ),
            ],
          ),
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
  final EventEntity event;

  const EventDetailButton({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            event.isSubscribed
                ? WidgetStateProperty.all(Colors.red.shade300)
                : WidgetStateProperty.all(Colors.green.shade300),
      ),
      onPressed: () {},
      child: Text(
        event.isSubscribed ? "Unsubscribe" : "Subscribe",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
