import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/events_bloc/events_bloc.dart';
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
      if (_scrollController.position.maxScrollExtent > _scrollController.position.pixels + 20) {
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
                  children: [Text(details.description, style: contentStyle), SizedBox(height: 40)],
                ),
              ),
            ),
            SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [if (_isScrollable && !_isAtBottom) Icon(Icons.keyboard_arrow_down)],
              ),
            ),
            SafeArea(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [EventDetailButton(eventId: widget.event.details.id)],
            ),)
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

  const EventDetailField({super.key, required this.icon, this.text = 'Undefined'});

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

class EventDetailButton extends StatefulWidget {
  final int eventId;

  const EventDetailButton({super.key, required this.eventId});

  @override
  State<EventDetailButton> createState() => _EventDetailButtonState();
}

class _EventDetailButtonState extends State<EventDetailButton> {
  String? confirmationMessage;
  bool isError = false;

  void showConfirmation(String message) {
    setState(() => confirmationMessage = message);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => confirmationMessage = null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventsBloc, EventsState>(
      listener: (context, state) {
        if (state is IntraEventsSuccess) {
          final updatedEvent = state.events.firstWhere(
            (e) => e.details.id == widget.eventId,
            orElse: () => EventVm.empty(),
          );

          if (updatedEvent.details.id != 0) {
            if (updatedEvent.status == EventStatus.subscribed) {
              showConfirmation(tr('events.messages.subscribed'));
            } else if (updatedEvent.status == EventStatus.notSubscribed) {
              showConfirmation(tr('events.messages.unsubscribed'));
            } else if (updatedEvent.status == EventStatus.waitlisted) {
              showConfirmation(tr('events.messages.waitlisted'));
            } else if (updatedEvent.status == EventStatus.unwaitlisted) {
              showConfirmation(tr('events.messages.unwaitlisted'));
            }
          }
        }
      },
      builder: (context, state) {
        if (confirmationMessage != null) {
          return SizedBox(
            height: 40,
            child: Text(
              confirmationMessage!,
              style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
            ),
          );
        }

        if (state is! IntraEventsSuccess) {
          return SizedBox(
            height: 40,
            child: Text(
              tr('Error'),
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
          );
        }

        final event = state.events.firstWhere(
          (e) => e.details.id == widget.eventId,
          orElse: () => throw Exception('Event not found'),
        );

        final bloc = context.read<EventsBloc>();

        final isLoading = event.status == EventStatus.loading;

        if (isLoading) {
          return const SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        }

        if (event.status == EventStatus.failed) {
          return SizedBox(
            height: 40,
            child: Text(
              tr('events.messages.failed'),
              style: const TextStyle(fontSize: 16, color: Colors.orange, fontWeight: FontWeight.bold),
            ),
          );
        }

        if (event.status == EventStatus.subscribed) {
          return SizedBox(
            height: 40,
            child: _buildUnsubscribeButton(() {
              bloc.add(UnsubscribeFromEventEvent(event));
            }),
          );
        } else {
          return SizedBox(
            height: 40,
            child: _buildSubscribeButton(() {
              bloc.add(SubscribeToEventEvent(event));
            }),
          );
        }
      },
    );
  }

  Widget _buildUnsubscribeButton(VoidCallback onPressed) {
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.red.shade300)),
      onPressed: () {
        onPressed();
      },
      child: Text(
        tr('events.button.unsubscribe'),
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  Widget _buildSubscribeButton(VoidCallback onPressed) {
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.green.shade300)),
      onPressed: () {
        onPressed();
      },
      child: Text(tr('events.button.subscribe'), style: TextStyle(fontSize: 16, color: Colors.white)),
    );
  }
}
