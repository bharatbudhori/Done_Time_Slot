import 'package:done_assesment/providers/provider_list.dart';
import 'package:done_assesment/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class NextButton extends ConsumerWidget {
  NextButton({super.key, required this.onPressed});
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var timeSlotProvider = ref.watch(ProviderList.timeSlotProvider);
    return TextButton(
      onPressed: onPressed,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: timeSlotProvider.selectedTime.isEmpty
              ? Colors.black54
              : Colors.black,
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
    );
  }
}
