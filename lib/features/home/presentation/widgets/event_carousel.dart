import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../blocs/events_bloc/events_bloc.dart';
import 'event_card.dart';

class EventCarousel extends StatelessWidget {
  final double width;
  final double height;

  const EventCarousel({super.key, this.width = 300, this.height = 200});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        if (state is IntraEventsInitial || state is IntraEventsLoading) {
          return _ShimmerCarousel(height: height);
        } else if (state is IntraEventsSuccess) {
          if (state.events.isEmpty) {
            return Text(tr('events.message.no_events'));
          }
          return SizedBox(
            width: width,
            height: height + 24,
            child: ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.black, Colors.transparent, Colors.transparent, Colors.black],
                  stops: [0.0, 0.05, 0.95, 1.0],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstOut,
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 10, 24),
                scrollDirection: Axis.horizontal,
                itemCount: state.events.length,
                itemBuilder: (context, index) {
                  final event = state.events[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: Duration(milliseconds: 400 + index * 100),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Material(
                              elevation: 8,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              clipBehavior: Clip.none,
                              child: EventCard(event: event),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          );
        } else if (state is IntraEventsError) {
          return Text(state.message);
        } else {
          return const Text('Unknown state');
        }
      },
    );
  }
}

class _ShimmerCarousel extends StatelessWidget {
  final double height;

  const _ShimmerCarousel({required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 200,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
