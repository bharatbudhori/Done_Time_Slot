import 'package:done_assesment/providers/provider_list.dart';
import 'package:done_assesment/utils/time_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class TimeGrid extends ConsumerStatefulWidget {
  TimeGrid({super.key, required this.sectionTime});
  List<String> sectionTime;

  @override
  ConsumerState<TimeGrid> createState() => _TimeGridState();
}

class _TimeGridState extends ConsumerState<TimeGrid> {
  @override
  Widget build(BuildContext context) {
    var timeSlotProvider = ref.watch(ProviderList.timeSlotProvider);
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.sectionTime.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 120,
        childAspectRatio: 2 / 1.15,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        return TimeCard(
          content: widget.sectionTime[index],
          color:
              timeSlotProvider.selectedTime.contains(widget.sectionTime[index])
                  ? Colors.white
                  : Colors.black,
          backgroundColor:
              timeSlotProvider.selectedTime.contains(widget.sectionTime[index])
                  ? Colors.black
                  : const Color.fromRGBO(238, 238, 238, 1),
          onPressed: () {
            timeSlotProvider.addRemoveTime(widget.sectionTime[index]);
          },
        );
      },
    );
  }
}
