import 'package:done_assesment/providers/time_slot_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProviderList {
  static var timeSlotProvider =
      ChangeNotifierProvider<TimeSlotProvider>((_) => TimeSlotProvider());
}
