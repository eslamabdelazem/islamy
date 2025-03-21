import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamy/presentation/prayer_consumer/presentation/cubit/prayer_consumer_state.dart';

class PrayerConsumerCubit extends Cubit<PrayerConsumerState> {
  PrayerConsumerCubit() : super(PrayerConsumerState.initial());
}
