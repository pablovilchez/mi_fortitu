import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mi_fortitu/core/helpers/data_format_helper.dart';

import '../../domain/entities/intra_event_entity.dart';
import '../bloc/intra_events_bloc/intra_events_bloc.dart';
import 'event_detail_sheet.dart';

class EventCarousel extends StatelessWidget {
  final double width;
  final double height;
  final List<IntraEventEntity> event = [];

  EventCarousel({super.key, this.width = 300, this.height = 200});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntraEventsBloc, IntraEventsState>(
      builder: (context, state) {
        if (state is IntraEventsInitial) {
          return CircularProgressIndicator();
        } else if (state is IntraEventsLoading) {
          return CircularProgressIndicator();
        } else if (state is IntraEventsSuccess) {
          if (state.events.isEmpty) {
            return Text('No events');
          }
          state.events.removeWhere(
            (event) => event.endAt.isBefore(DateTime.now()),
          );
          state.events.sort((a, b) => a.beginAt.compareTo(b.beginAt));
          return SizedBox(
            width: width,
            height: height,
            child: ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black,
                  ],
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
  final IntraEventEntity event;

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
            // Color del efecto de toque
            highlightColor: Colors.transparent,
            // Evita que se vea un color sólido al tocar
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildEventInfo(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventInfo() {
    final begin = event.beginAt;
    final end = event.endAt;
    final days = end.difference(begin).inDays;
    final hours = (end.difference(begin).inMinutes / 60).truncate();
    final minutes = end.difference(begin).inMinutes % 60;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HeaderEventElement(
              icon: Icons.calendar_month,
              text: () {
                if (begin.day == DateTime.now().day) {
                  return tr('home.events.today');
                } else if (begin.day == DateTime.now().day + 1) {
                  return tr('home.events.tomorrow');
                } else {
                  return DataFormatHelper.shortFormatDate(begin);
                }
              }(),
            ),
            HeaderEventElement(
              icon: Icons.access_time,
              text: DateFormat('HH:mm').format(begin),
            ),
            HeaderEventElement(
              icon: Icons.timelapse,
              text: () {
                if (days > 0) {
                  return '${days}d';
                } else if (hours == 0) {
                  return '${minutes}m';
                } else if (minutes == 0) {
                  return '${hours}h';
                } else {
                  return '${hours}h ${minutes}m';
                }
              }(),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HeaderEventElement(
              icon: Icons.pin_drop,
              text: event.location.split(' ').first,
            ),
            HeaderEventElement(
              icon: Icons.people,
              text: event.maxPeople > 0 ? '${event.maxPeople}' : '~',
              alert:
                  event.maxPeople > 0 &&
                  event.maxPeople <= event.nbrSubscribers,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                event.name,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
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
