// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parallel/core/models/event/event.dart';
import 'package:parallel/core/models/event/eventBooking.dart';
import 'package:parallel/core/models/headquarter/headquarterCompany.dart';
import 'package:parallel/core/repositories/main_repository.dart';

part 'event_state.dart';

///Utente di destinazione: EMPLOYEE, COMPANY_MANAGER
class EventCubit extends Cubit<EventState> {
  final MainRepository mainRepository;

  EventCubit(this.mainRepository) : super(EventInitial());

  ///getEvents ottiene la lista degli eventi
  ///INPUT: -
  ///OUTPUT: EventsLoaded State
  void getEvents() {
    mainRepository.getEvents().then((events) {
      emit(EventsLoaded(events: events));
    });
  }

  ///getMyEvents ottiene la lista degli eventi di un utente
  ///INPUT: -
  ///OUTPUT: MyEventsLoaded State
  void getMyEvents() {
    mainRepository.getMyEvents().then((events) {
      emit(MyEventsLoaded(events: events));
    });
  }

  ///setEventPresence iscrive un utente ad un evento
  ///INPUT: id headquarter, id evento
  ///OUTPUT: EventPresenceSetted State
  void setEventPresence(int hqId, int evId) {
    mainRepository.setEventPresence(hqId, evId).then((value) {
      if (value == 201) {
        emit(EventPresenceSetted());
      }
    });
  }

  ///deleteEventSubscription cancella l'iscrizione di un utente ad un evento
  ///INPUT: id headquarter, id evento, id prenotazione
  ///OUTPUT: EventBookingDeleted State
  void deleteEventSubscription(int hqId, int evId, int bkId) {
    mainRepository.deleteEventBooking(hqId, evId, bkId).then((value) {
      if (value == 204) {
        emit(EventBookingDeleted());
      }
    });
  }

  ///createNewEvent crea un nuovo evento
  ///INPUT: id, nome evento, data, ora di inizio e fine, numero di posti
  ///OUTPUT: EventCreated State | EventError
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
      if (event == [] || event == null) {
        emit(EventError("Non puoi pianificare un evento per il weekend!"));
      } else {
        emit(EventCreated());
      }
    });
  }

  ///getHeadquartersByCompany restituisce la lista delle sedi di una company
  ///INPUT: -
  ///OUTPUT: EventHeadquartersByCompanyLoaded State
  void getHeadquartersByCompany() {
    mainRepository.getHeadquartersByCompany().then((headquarters) {
      emit(EventHeadquartersByCompanyLoaded(headquarters));
    });
  }

  ///deleteEvent cancella un evento
  ///INPUT: id headquarter, id evento
  ///OUTPUT: EventCanceled State | EventError
  void deleteEvent(int hqId, int evId) {
    mainRepository.deleteEvent(hqId, evId).then((value) {
      if (value == 204) {
        emit(EventCanceled());
      } else {
        emit(EventError("Non è stato possibile eliminare questo evento!"));
      }
    });
  }
}
