import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parallel/core/models/event.dart';
import 'package:parallel/core/repositories/main_repository.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  final MainRepository mainRepository;

  EventCubit(this.mainRepository) : super(EventInitial());

  void getEvents() {
    mainRepository.getEvents().then((events) {
      emit(EventsLoaded(events: events));
    });
  }

  void createNewEvent(
    int id,
    String name,
    String eventDate,
    String startTime,
    String endTime,
    int maxPlaces,
  ) {
    mainRepository
        .createNewEvent(id, name, eventDate, startTime, endTime, maxPlaces)
        .then((event) {
      emit(EventCreated());
    });
  }
}
