import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parallel/core/models/event.dart';
import 'package:parallel/core/models/eventBooking.dart';
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

  void getMyEvents() {
    mainRepository.getMyEvents().then((events) {
      emit(MyEventsLoaded(events: events));
    });
  }

  void setEventPresence(int hqId, int evId) {
    mainRepository.setEventPresence(hqId, evId).then((value) {
      if (value == 201) {
        emit(EventPresenceSetted());
      }
    });
  }

  void deleteEventSubscription(int hqId, int evId, int bkId) {
    mainRepository.deleteEventBooking(hqId, evId, bkId).then((value) {
      if (value == 204) {
        emit(EventBookingDeleted());
      }
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
