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
          return _ShimmerCarousel(width: width, height: height);
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
                  final event = state.events[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: Duration(milliseconds: 400 + index * 100),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 20 * (1 - value)),
                            child: EventCard(event: event),
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
          return Text('Unknown state');
        }
      },
    );
  }
}

class _ShimmerCarousel extends StatelessWidget {
  final double width;
  final double height;

  const _ShimmerCarousel({required this.width, required this.height});

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
