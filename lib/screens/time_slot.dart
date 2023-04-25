import 'dart:developer' as dev;
import 'dart:math';
import 'package:done_assesment/utils/app_bar.dart';
import 'package:done_assesment/utils/day_slot_row.dart';
import 'package:done_assesment/utils/next_button.dart';
import 'package:done_assesment/utils/time_grid.dart';
import 'package:flutter/material.dart';

import 'package:done_assesment/utils/custom_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/provider_list.dart';

// ignore: must_be_immutable
class TimeSlotSelection extends ConsumerStatefulWidget {
  TimeSlotSelection({super.key});
  DateTime selectedDate = DateTime(2023, 4, 20);

  @override
  ConsumerState<TimeSlotSelection> createState() => _TimeSlotSelectionState();
}

class _TimeSlotSelectionState extends ConsumerState<TimeSlotSelection>
    with SingleTickerProviderStateMixin {
  double _progressValue = 0.7;
  late AnimationController _controller;
  late Animation<double> _animation;
  List<String> morningTime = [];
  List<String> afternoonTime = [];
  List<String> eveningTime = [];
  String displayDate = '';

  @override
  void initState() {
    super.initState();
    var timeSlotProvider = ref.read(ProviderList.timeSlotProvider);
    morningTime = timeSlotProvider.generateTimeList(
        startTime: '7:00', endTime: '11:30', interval: 30);
    afternoonTime = timeSlotProvider.generateTimeList(
        startTime: '12:00', endTime: '16:30', interval: 30);
    eveningTime = timeSlotProvider.generateTimeList(
        startTime: '17:00', endTime: '19:00', interval: 30);
    displayDate =
        timeSlotProvider.displayMessage(selectedDate: widget.selectedDate);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation =
        Tween<double>(begin: _progressValue, end: 0.9).animate(_controller)
          ..addListener(
            () {
              setState(() {
                _progressValue = _animation.value;
              });
            },
          );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var timeSlotProvider = ref.watch(ProviderList.timeSlotProvider);
    bool allMorning = timeSlotProvider.isSectionSelected(morningTime);
    bool allAfternoon = timeSlotProvider.isSectionSelected(afternoonTime);
    bool allEvening = timeSlotProvider.isSectionSelected(eveningTime);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: ProgressAppBar(progressValue: _progressValue),
        //back button iOs
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text:
                    'When can we call you ${(displayDate == 'today' || displayDate == 'tomorrow' || displayDate == 'day after tomorrow') ? displayDate : 'on $displayDate'} ?',
                color: Colors.black,
                fontSize: min(30, MediaQuery.of(context).size.width * 0.08),
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomText(
                text: 'Choose as many as you want.',
                color: Colors.grey,
                fontSize: 17,
                fontWeight: FontWeight.normal,
              ),
              const SizedBox(
                height: 20,
              ),
              //three boxes for morining, afternoon and evening
              BuildRow(
                allMorning: allMorning,
                allAfternoon: allAfternoon,
                allEvening: allEvening,
                morningTime: morningTime,
                afternoonTime: afternoonTime,
                eveningTime: eveningTime,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomText(
                text: 'Morning',
                overflow: TextOverflow.ellipsis,
                color: Colors.grey,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),

              const SizedBox(
                height: 15,
              ),
              //Grid view for morning time
              TimeGrid(
                sectionTime: morningTime,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomText(
                text: 'Afternoon',
                overflow: TextOverflow.ellipsis,
                color: Colors.grey,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(
                height: 15,
              ),
              //Grid view for afternoon time
              TimeGrid(
                sectionTime: afternoonTime,
              ),

              const SizedBox(
                height: 20,
              ),
              CustomText(
                text: 'Evening',
                overflow: TextOverflow.ellipsis,
                color: Colors.grey,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(
                height: 15,
              ),
              //Grid view for evening time
              TimeGrid(
                sectionTime: eveningTime,
              ),
              const SizedBox(
                height: 35,
              ),
              //Next button
              NextButton(onPressed: () {
                timeSlotProvider.selectedTime.isEmpty
                    ? null
                    : _controller.forward();
                dev.log(timeSlotProvider.selectedTime.length.toString());
                dev.log(timeSlotProvider.selectedTime.toString());
              })
            ],
          ),
        ),
      ),
    );
  }
}
