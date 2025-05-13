import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_fortitu/core/themes/backgrounds.dart';

import '../../../../core/presentation/widgets/dialogs/dev_info_widget.dart';
import '../blocs/slots_bloc/slots_bloc.dart';
import '../viewmodels/slot_group_viewmodel.dart';
import '../widgets/create_slot_dialog.dart';

class ManageSlotsScreen extends StatefulWidget {
  const ManageSlotsScreen({super.key});

  @override
  State<ManageSlotsScreen> createState() => _ManageSlotsScreenState();
}

class _ManageSlotsScreenState extends State<ManageSlotsScreen> {
  late DateTime selectedDate;
  late List<DateTime> availableDates;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    availableDates = List.generate(4, (index) => DateTime.now().add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    return MainBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => _openCreateSlotDialog(context),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(tr('slots.title')),
          actions: [
            IconButton(
              onPressed: () {
                context.read<SlotsBloc>().add(GetSlotsEvent());
              },
              icon: const Icon(Icons.refresh),
            ),
            IconButton(
              onPressed: () {
                showDevInfoDialog(context, 'slotsTestInfo');
              },
              icon: const Icon(Icons.adb),
              color: Colors.red,
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<SlotsBloc, SlotsState>(
              builder: (context, state) {
                if (state is SlotsInitial) {
                  context.read<SlotsBloc>().add(GetSlotsEvent());
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is SlotsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is SlotsError) {
                  return Center(child: Text(state.error));
                }
                if (state is SlotsSuccess) {
                  return Column(
                    children: [
                      _buildDateSelector(),
                      const SizedBox(height: 20),
                      Expanded(child: _buildSlotsList(state.slots)),
                    ],
                  );
                }
                return Center(child: Text(tr('slots.message.error_state')));
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: availableDates.length,
        itemBuilder: (context, index) {
          final date = availableDates[index];
          final isSelected = date.day == selectedDate.day;

          return GestureDetector(
            onTap: () {
              setState(() => selectedDate = date);
            },
            child: Container(
              width: 70,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isSelected ? Colors.deepPurple : Colors.grey[300],
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat.E(tr('language')).format(date),
                    style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat.MMM(tr('language')).format(date),
                    style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : Colors.black),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSlotsList(List<SlotGroupVm> slots) {
    final daySlots = slots.where(
          (slot) => slot.beginAt.toLocal().year == selectedDate.year &&
          slot.beginAt.toLocal().month == selectedDate.month &&
          slot.beginAt.toLocal().day == selectedDate.day,
    ).toList();

    if (daySlots.isEmpty) {
      return Center(child: Text(tr('slots.message.no_slots')));
    }

    return ListView.builder(
      itemCount: daySlots.length,
      itemBuilder: (context, index) {
        final slotsGroup = daySlots[index];
        final beginAt = DateFormat.Hm().format(slotsGroup.beginAt.toLocal());
        final endAt = DateFormat.Hm().format(slotsGroup.endAt.toLocal());
        final evalTo = slotsGroup.isReserved ? ' 💻 ${slotsGroup.userToEvaluate}' : '';

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          color: slotsGroup.isReserved ? Colors.red[100] : Colors.green[100],
          child: ListTile(
            title: Text('$beginAt - $endAt $evalTo'),
            trailing: IconButton(
              icon: Icon(
                slotsGroup.isReserved ? Icons.desktop_access_disabled_rounded : Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                if (!slotsGroup.isReserved) {
                  context.read<SlotsBloc>().add(DestroySlotsEvent(slotsGroup));
                }
              },
            ),
          ),
        );
      },
    );
  }

  void _openCreateSlotDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CreateSlotDialog(selectedDate: selectedDate),
    );
  }
}
