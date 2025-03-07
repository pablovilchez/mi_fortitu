import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mi_fortitu/features/home/domain/entities/intra_event.dart';

class EventDetailSheet extends StatelessWidget {
  final IntraEvent event;

  const EventDetailSheet({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final day = DateFormat('MMMEd').format(event.beginAt);
    final time = DateFormat('HH:mm').format(event.endAt);
    final contentStyle = TextStyle(fontSize: 16);

    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
          EventDetailField(icon: Icons.pin_drop, text: event.location),
          SizedBox(height: 20),
          Text(event.description, style: contentStyle),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [EventDetailButton(event: event)],
          ),
        ],
      ),
    );
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
        Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class EventDetailButton extends StatelessWidget {
  final IntraEvent event;

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
      onPressed: () {

      },
      child: Text(
        event.isSubscribed ? "Unsubscribe" : "Subscribe",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
