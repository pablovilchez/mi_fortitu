import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/event_entity.dart';
import '../blocs/events_bloc/events_bloc.dart';
import '../viewmodels/event_viewmodel.dart';
import 'event_detail_sheet.dart';

class EventCarousel extends StatelessWidget {
  final double width;
  final double height;
  final List<EventEntity> event = [];

  EventCarousel({super.key, this.width = 300, this.height = 200});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        if (state is IntraEventsInitial) {
          return CircularProgressIndicator();
        } else if (state is IntraEventsLoading) {
          return CircularProgressIndicator();
        } else if (state is IntraEventsSuccess) {
          if (state.events.isEmpty) {
            return Text('No events');
          }
          return SizedBox(
            width: width,
            height: height,
            child: ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.black, Colors.transparent, Colors.transparent, Colors.black],
                  stops: [0.0, 0.05, 0.95, 1.0],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstOut,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: state.events.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: EventCard(event: state.events[index]),
                  );
                },
              ),
            ),
          );
        } else if (state is IntraEventsError) {
          return Text(state.message);
        } else {
          return Text('Unknown state');
        }
      },
    );
  }
}

class EventCard extends StatelessWidget {
  final EventVm event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: SizedBox(
        width: 200,
        child: Material(
          color: event.isSubscribed ? Colors.green[100] : Colors.white,
          elevation: 4,
          borderRadius: BorderRadius.circular(12),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => EventDetailSheet(event: event),
              );
            },
            splashColor: Colors.black12,
            highlightColor: Colors.transparent,
            child: Padding(padding: const EdgeInsets.all(16.0), child: _buildEventInfo()),
          ),
        ),
      ),
    );
  }

  Widget _buildEventInfo() {
    final details = event.details;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HeaderEventElement(icon: Icons.calendar_month, text: details.beginDate),
            HeaderEventElement(icon: Icons.access_time, text: details.beginTime),
            HeaderEventElement(icon: Icons.timelapse, text: details.duration),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HeaderEventElement(icon: Icons.pin_drop, text: details.location.split(' ').first),
            HeaderEventElement(
              icon: Icons.people,
              text: details.maxPeople > 0 ? '${details.maxPeople}' : '~',
              alert: event.isFull,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                details.name,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HeaderEventElement extends StatelessWidget {
  final double width;
  final IconData icon;
  final String text;
  final bool alert;

  const HeaderEventElement({
    super.key,
    this.width = 54,
    required this.icon,
    required this.text,
    this.alert = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          Icon(icon, color: alert ? Colors.red : Colors.blue),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: alert ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
