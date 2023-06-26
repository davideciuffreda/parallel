// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

import 'package:bloc/bloc.dart';
import 'package:parallel/core/models/workplace/workplace.dart';
import 'package:parallel/core/models/workspace/workspace.dart';
import 'package:parallel/core/models/workplace/wpBooking.dart';
import 'package:parallel/core/repositories/main_repository.dart';

part 'booking_event.dart';
part 'booking_state.dart';

///Utente di destinazione: EMPLOYEE, COMPANY_MANAGER
class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final MainRepository mainRepository;

  BookingBloc(this.mainRepository) : super(BookingInitial()) {

    ///BLoC per la selezione della data dedicato alla gestione dei
    ///possibili stati
    on<BookingDateAdded>((event, emit) async {
      if (event.bookingDate == '') {
        emit(BookingError("La data selezionata non è valida!"));
      } else {
        await mainRepository
            .getWorkspacesByDate(event.hqId, event.bookingDate)
            .then((workspaces) {
          emit(BookingDateSelected(
            bookingDate: event.bookingDate,
            workspaces: workspaces,
            hqId: event.hqId,
          ));
        });
      }
    });

    ///BLoC per la selezione del workspace dedicato alla gestione dei
    ///possibili stati
    on<WorkspaceAdded>((event, emit) async {
      await mainRepository
          .getWorkplacesByWorkspace(event.hqId, event.wsId, event.bookingDate)
          .then((workplaces) {
        emit(WorkspaceSelected(
          wsId: event.wsId,
          hqId: event.hqId,
          workplaces: workplaces,
        ));
      });
    });

    ///BLoC per la creazione di una prenotazione dedicato alla gestione dei
    ///possibili stati
    on<CreateBooking>((event, emit) async {
      await mainRepository
          .createBooking(event.wsId, event.wpId, event.bookingDate)
          .then((booking) {
        if (booking.id != -1) {
          emit(BookingCreated());
        } else {
          emit(BookingError(
              'Probabilmente esiste già una prenotazione a tuo carico per la' +
                  ' data selezionata oppure la postazione non è disponibile!'));
        }
      });
    });

    ///BLoC per ottenere tutte le prenotazioni di un utente dedicato alla
    ///gestione dei possibili stati
    on<GetAllMyWpBookings>((event, emit) async {
      await mainRepository.getBookingsByToken().then((myBookings) {
        emit(BookingsLoaded(myBookings: myBookings));
      });
    });

    ///BLoC per la cancellazione di una prenotazione dedicato alla gestione dei
    ///possibili stati
    on<DeleteBooking>((event, emit) async {
      await mainRepository
          .deleteBooking(event.wsId, event.wpId, event.bkId)
          .then((response) {
        if (response == 'booking_deleted') {
          emit(BookingDeleted());
        } else {
          emit(
            BookingError("Non è stato possibile cancellare la prenotazione"),
          );
        }
      });
    });

    ///BLoC per la pulizia della data dedicato alla gestione dei
    ///possibili stati
    on<CleaningBookingDate>((event, emit) {
      emit(BookingInitial());
    });
  }
}
