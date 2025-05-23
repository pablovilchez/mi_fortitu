import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_fortitu/features/profiles/presentation/blocs/user_profile_bloc/user_profile_bloc.dart';

import '../blocs/slots_bloc/slots_bloc.dart';

class CreateSlotDialog extends StatefulWidget {
  final DateTime selectedDate;

  const CreateSlotDialog({super.key, required this.selectedDate});

  @override
  State<CreateSlotDialog> createState() => _CreateSlotDialogState();
}

class _CreateSlotDialogState extends State<CreateSlotDialog> {
  bool choosingEndTime = true;

  late List<DateTime> availableTimes;
  int selectedStartIndex = 0;

  int selectedDurationHours = 0;
  int selectedDurationMinutes = 30;

  @override
  void initState() {
    super.initState();
    _generateAvailableTimes();
  }

  void _generateAvailableTimes() {
    final now = DateTime.now().toLocal();
    final isToday = widget.selectedDate.year == now.year &&
        widget.selectedDate.month == now.month &&
        widget.selectedDate.day == now.day;

    late DateTime start;

    if (isToday) {
      final future = now.add(const Duration(minutes: 30));
      int adjustedMinute = ((future.minute ~/ 15) + 1) * 15;
      int adjustedHour = future.hour + (adjustedMinute ~/ 60);
      adjustedMinute = adjustedMinute % 60;

      start = DateTime(future.year, future.month, future.day, adjustedHour, adjustedMinute);
    } else {
      start = DateTime(widget.selectedDate.year, widget.selectedDate.month, widget.selectedDate.day, 0, 0);
    }

    availableTimes = [];
    var current = start;
    while (current.day == start.day) {
      availableTimes.add(current);
      current = current.add(const Duration(minutes: 15));
    }

    if (!isToday) {
      final indexOfNineAM = availableTimes.indexWhere(
            (time) => time.hour == 9 && time.minute == 0,
      );
      if (indexOfNineAM != -1) {
        selectedStartIndex = indexOfNineAM;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    late int userId;
    final userBlocState = context.read<UserProfileBloc>().state;
    userId = userBlocState is UserProfileSuccess ? userBlocState.profile.id : 0;
    final formattedDate = DateFormat('EEEE, d MMM.', tr('language')).format(widget.selectedDate);

    return AlertDialog(
      backgroundColor: Colors.blue[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        formattedDate,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        height: 220,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [_buildStartColumn(), const SizedBox(width: 40), _buildEndOrDurationColumn()],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: () {
            final startTime = availableTimes[selectedStartIndex];

            final DateTime endTime = choosingEndTime
              ? startTime.add(Duration(minutes: selectedDurationMinutes))
              : startTime.add(Duration(minutes: selectedDurationHours * 60 + selectedDurationMinutes));

            // Show start and end in a legible clock format
            print('DEBUG       start: ${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')} end: ${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}');

            // Call the create slot event here
            context.read<SlotsBloc>().add(AddSlotEvent(userId, startTime.toUtc(), endTime.toUtc()));

            Navigator.pop(context);
          },
          child: Text(tr('slots.dialog.create')),
        ),
      ],
    );
  }

  Widget _buildStartColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
          child: Center(
            child: Text(
              tr('slots.dialog.start_time'),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 8),
        _buildPickerFrame(child: _buildStartTimePicker()),
      ],
    );
  }

  Widget _buildEndOrDurationColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
          child: TextButton(
            onPressed: () => setState(() => choosingEndTime = !choosingEndTime),
            child: Text(
              '${choosingEndTime ? tr('slots.dialog.end_time') : tr('slots.dialog.duration')} 🔁',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 8),
        _buildPickerFrame(
          child: choosingEndTime ? _buildEndTimePicker() : _buildDurationPicker(),
          wider: !choosingEndTime,
        ),
      ],
    );
  }

  Widget _buildPickerFrame({required Widget child, bool wider = false}) {
    return Container(
      width: wider ? 120 : 70,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ShaderMask(
            shaderCallback:
                (rect) => const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent, Colors.transparent, Colors.black],
                  stops: [0.0, 0.4, 0.6, 1.0],
                ).createShader(rect),
            blendMode: BlendMode.dstOut,
            child: child,
          ),
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(vertical: 55),
            decoration: BoxDecoration(
              color: Colors.blue.withAlpha(300),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartTimePicker() {
    return ListWheelScrollView.useDelegate(
      itemExtent: 40,
      physics: const FixedExtentScrollPhysics(),
      controller: FixedExtentScrollController(initialItem: selectedStartIndex),
      onSelectedItemChanged: (index) {
        setState(() {
          selectedStartIndex = index;
          if (choosingEndTime) {
            selectedDurationMinutes = 30;
          }
        });
      },
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: availableTimes.length,
        builder: (context, index) {
          final time = availableTimes[index];
          return Center(
            child: Text(
              '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 18),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEndTimePicker() {
    final baseTimes = availableTimes[selectedStartIndex];

    final availableEndTimes = List<DateTime>.generate(
      48,
      (index) => baseTimes.add(Duration(minutes: 15 * (index + 1))),
    );

    return ListWheelScrollView.useDelegate(
      itemExtent: 40,
      physics: const FixedExtentScrollPhysics(),
      controller: FixedExtentScrollController(initialItem: 1),
      onSelectedItemChanged: (index) {
        setState(() {
          selectedDurationMinutes = (index + 1) * 15;
        });
      },
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: availableEndTimes.length,
        builder: (context, index) {
          final time = availableEndTimes[index];
          return Center(
            child: Text(
              '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 18),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDurationPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Hours
        SizedBox(
          width: 50,
          child: ListWheelScrollView.useDelegate(
            itemExtent: 40,
            physics: const FixedExtentScrollPhysics(),
            controller: FixedExtentScrollController(initialItem: selectedDurationHours),
            onSelectedItemChanged: (index) {
              setState(() {
                selectedDurationHours = index;
              });
            },
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: 13,
              builder: (context, index) {
                return Center(child: Text('$index h', style: const TextStyle(fontSize: 18)));
              },
            ),
          ),
        ),

        // Minutes
        SizedBox(
          width: 60,
          child: ListWheelScrollView.useDelegate(
            itemExtent: 40,
            physics: const FixedExtentScrollPhysics(),
            controller: FixedExtentScrollController(initialItem: selectedDurationMinutes ~/ 15),
            onSelectedItemChanged: (index) {
              setState(() {
                selectedDurationMinutes = index * 15;
              });
            },
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: 4,
              builder: (context, index) {
                final minutes = index * 15;
                return Center(
                  child: Text(
                    '${minutes.toString().padLeft(2, '0')} m',
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
