import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:done_assesment/utils/custom_text.dart';
import 'package:done_assesment/utils/time_card.dart';

// ignore: must_be_immutable
class TimeSlotSelection extends StatefulWidget {
  TimeSlotSelection({super.key});
  DateTime selectedDate = DateTime(2023, 4, 15);

  @override
  State<TimeSlotSelection> createState() => _TimeSlotSelectionState();
}

class _TimeSlotSelectionState extends State<TimeSlotSelection>
    with SingleTickerProviderStateMixin {
  List<String> selectedTime = [];
  List<String> morningTime = [
    '7:00',
    '7:30',
    '8:00',
    '8:30',
    '9:00',
    '9:30',
    '10:00',
    '10:30',
    '11:00',
    '11:30'
  ];
  List<String> afternoonTime = [
    '12:00',
    '12:30',
    '13:00',
    '13:30',
    '14:00',
    '14:30',
    '15:00',
    '15:30',
    '16:00',
    '16:30'
  ];
  List<String> eveningTime = [
    '17:00',
    '17:30',
    '18:00',
    '18:30',
    '19:00',
  ];
  String displayDate = '';
  double _progressValue = 0.7;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    displayDate = displayMessage();
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

  String displayMessage() {
    if (widget.selectedDate.day == DateTime.now().day &&
        widget.selectedDate.month == DateTime.now().month &&
        widget.selectedDate.year == DateTime.now().year) {
      return 'today';
    } else if (widget.selectedDate.day == DateTime.now().day + 1 &&
        widget.selectedDate.month == DateTime.now().month &&
        widget.selectedDate.year == DateTime.now().year) {
      return 'tomorrow';
    } else if (widget.selectedDate.day == DateTime.now().day + 2 &&
        widget.selectedDate.month == DateTime.now().month &&
        widget.selectedDate.year == DateTime.now().year) {
      return 'day after tomorrow';
    } else {
      return DateFormat('EEEE, MMMM d, yyyy').format(widget.selectedDate);
    }
  }

  bool allMorningTimeSelected() {
    for (var i = 0; i < morningTime.length; i++) {
      if (!selectedTime.contains(morningTime[i])) {
        return false;
      }
    }
    return true;
  }

  bool allAfternoonTimeSelected() {
    for (var i = 0; i < afternoonTime.length; i++) {
      if (!selectedTime.contains(afternoonTime[i])) {
        return false;
      }
    }
    return true;
  }

  bool allEveningTimeSelected() {
    for (var i = 0; i < eveningTime.length; i++) {
      if (!selectedTime.contains(eveningTime[i])) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    bool allMorning = allMorningTimeSelected();
    bool allAfternoon = allAfternoonTimeSelected();
    bool allEvening = allEveningTimeSelected();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: SizedBox(
          height: 15,
          width: MediaQuery.of(context).size.width * 0.5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: _progressValue,
              backgroundColor: Color.fromARGB(173, 211, 207, 207),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          ),
        ),
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
                fontSize: 30,
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
                height: 30,
              ),
              //three boxes for morining, afternoon and evening
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        //add morningTime to selectedTime
                        for (var element in morningTime) {
                          if (!selectedTime.contains(element)) {
                            selectedTime.add(element);
                          }
                        }
                      });
                    },
                    child: TimeCard(
                      content: 'Morning',
                      color: allMorning ? Colors.white : Colors.black,
                      backgroundColor: allMorning
                          ? Colors.black
                          : const Color.fromRGBO(238, 238, 238, 1),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        for (var element in afternoonTime) {
                          if (!selectedTime.contains(element)) {
                            selectedTime.add(element);
                          }
                        }
                      });
                    },
                    child: TimeCard(
                      content: 'Afternoon',
                      color: allAfternoon ? Colors.white : Colors.black,
                      backgroundColor: allAfternoon
                          ? Colors.black
                          : const Color.fromRGBO(238, 238, 238, 1),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        for (var element in eveningTime) {
                          if (!selectedTime.contains(element)) {
                            selectedTime.add(element);
                          }
                        }
                      });
                    },
                    child: TimeCard(
                      content: 'Evening',
                      color: allEvening ? Colors.white : Colors.black,
                      backgroundColor: allEvening
                          ? Colors.black
                          : const Color.fromRGBO(238, 238, 238, 1),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
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
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: morningTime.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 120,
                    childAspectRatio: 2 / 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedTime.contains(morningTime[index])) {
                          selectedTime.remove(morningTime[index]);
                        } else {
                          selectedTime.add(morningTime[index]);
                        }
                      });
                    },
                    child: TimeCard(
                      content: morningTime[index],
                      color: selectedTime.contains(morningTime[index])
                          ? Colors.white
                          : Colors.black,
                      backgroundColor: selectedTime.contains(morningTime[index])
                          ? Colors.black
                          : const Color.fromRGBO(238, 238, 238, 1),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 30,
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
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: afternoonTime.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 120,
                    childAspectRatio: 2 / 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedTime.contains(afternoonTime[index])) {
                          selectedTime.remove(afternoonTime[index]);
                        } else {
                          selectedTime.add(afternoonTime[index]);
                        }
                      });
                    },
                    child: TimeCard(
                      content: afternoonTime[index],
                      color: selectedTime.contains(afternoonTime[index])
                          ? Colors.white
                          : Colors.black,
                      backgroundColor:
                          selectedTime.contains(afternoonTime[index])
                              ? Colors.black
                              : const Color.fromRGBO(238, 238, 238, 1),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 30,
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
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: eveningTime.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 120,
                    childAspectRatio: 2 / 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedTime.contains(eveningTime[index])) {
                          selectedTime.remove(eveningTime[index]);
                        } else {
                          selectedTime.add(eveningTime[index]);
                        }
                      });
                    },
                    child: TimeCard(
                      content: eveningTime[index],
                      color: selectedTime.contains(eveningTime[index])
                          ? Colors.white
                          : Colors.black,
                      backgroundColor: selectedTime.contains(eveningTime[index])
                          ? Colors.black
                          : const Color.fromRGBO(238, 238, 238, 1),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 35,
              ),
              //Next button
              GestureDetector(
                onTap: selectedTime.isEmpty
                    ? null
                    : () {
                        _controller.forward();
                        log(selectedTime.length.toString());
                        log(selectedTime.toString());
                      },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: selectedTime.isEmpty ? Colors.black54 : Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: CustomText(
                      text: 'Next',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
