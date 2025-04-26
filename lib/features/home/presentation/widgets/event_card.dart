import 'package:flutter/material.dart';

import '../viewmodels/event_viewmodel.dart';
import 'event_detail_sheet.dart';

class EventCard extends StatelessWidget {
  final EventVm event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final details = event.details;

    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: event.status == EventStatus.subscribed ? Colors.green[100] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(2, 4))],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          showModalBottomSheet(
            useSafeArea: false,
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => EventDetailSheet(event: event),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          details.beginWeekDay,
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                        Text(
                          details.beginDay,
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                        ),
                        Text(
                          details.beginMonth,
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          details.beginLapse,
                          style: const TextStyle(color: Colors.blue, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _IconText(icon: Icons.access_time, text: details.beginTime),
                      const SizedBox(height: 6),
                      _IconText(icon: Icons.timelapse, text: details.duration),
                      const SizedBox(height: 6),
                      _IconText(
                        icon: Icons.pin_drop,
                        text:
                            details.location.length <= 9
                                ? details.location
                                : details.location.split(' ').first,
                      ),
                      const SizedBox(height: 6),
                      _IconText(
                        icon: Icons.people,
                        text: details.maxPeople > 0 ? '${details.maxPeople}' : '~',
                        alert: event.isFull,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                details.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool alert;

  const _IconText({required this.icon, required this.text, this.alert = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: alert ? Colors.red : Colors.grey),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: alert ? Colors.red : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
