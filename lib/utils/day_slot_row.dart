import 'package:done_assesment/utils/time_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/provider_list.dart';

// ignore: must_be_immutable
class BuildRow extends ConsumerWidget {
  BuildRow({
    super.key,
    required this.allMorning,
    required this.allAfternoon,
    required this.allEvening,
    required this.morningTime,
    required this.afternoonTime,
    required this.eveningTime,
  });
  bool allMorning;
  bool allAfternoon;
  bool allEvening;
  List<String> morningTime;
  List<String> afternoonTime;
  List<String> eveningTime;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var timeSlotProvider = ref.watch(ProviderList.timeSlotProvider);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TimeCard(
            isDayLabel: true,
            content: 'Morning',
            color: allMorning ? Colors.white : Colors.black,
            backgroundColor: allMorning
                ? Colors.black
                : const Color.fromRGBO(238, 238, 238, 1),
            onPressed: () {
              timeSlotProvider.selectAllSection(morningTime);
            },
          ),
          TimeCard(
            isDayLabel: true,
            content: 'Afternoon',
            color: allAfternoon ? Colors.white : Colors.black,
            backgroundColor: allAfternoon
                ? Colors.black
                : const Color.fromRGBO(238, 238, 238, 1),
            onPressed: () {
              ref
                  .watch(ProviderList.timeSlotProvider.notifier)
                  .selectAllSection(afternoonTime);
            },
          ),
          TimeCard(
            isDayLabel: true,
            content: 'Evening',
            color: allEvening ? Colors.white : Colors.black,
            backgroundColor: allEvening
                ? Colors.black
                : const Color.fromRGBO(238, 238, 238, 1),
            onPressed: () {
              ref
                  .watch(ProviderList.timeSlotProvider.notifier)
                  .selectAllSection(eveningTime);
            },
          ),
        ],
      ),
    );
  }
}
